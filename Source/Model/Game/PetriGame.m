//
//  PetriGame.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGame.h"

#import "PetriGameConfiguration.h"
#import "PetriSquareGridBoard.h"
#import "PetriPiece.h"
#import "PetriPlayer.h"
#import "PetriBoardCell.h"
#import "PetriCellType.h"
#import "PetriBiteItem.h"

#import "PetriBoardPrototype.h"

/*!
 Private methods for PetriGame
 */
@interface PetriGame(Private)

/*!
 Tells the board to capture one iteration of cells for the current player.
 Should be called in a loop until it returns \c NO.
 */
- (BOOL)stepCapturesForCurrentPlayer;

/*!
 Returns the next PetriPiece to be assigned to \c currentPiece, chosen at random based on the distribution provided at initialization.
 */
- (id<PetriPiece>)nextPiece;

/*!
 Returns the next player to play, to be assigned to \c currentPlayer.
 */
- (PetriPlayer*)nextPlayer;

/*!
 Updates the controlled percentages of the board for all players in the game.
 */
- (void)updateControlPercentages;

@end

@implementation PetriGame

- (id)initWithPlayers:(NSArray*)playersInGame
	gameConfiguration:(PetriGameConfiguration*)configuration
{
	if (playersInGame == nil || [playersInGame count] == 0)
	{
		NSString* reason = @"Attempted to create game with no players or nil players array";
		[[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
	}
	
	// Copy the players array, and assign the first player
	players = [playersInGame copy];
	currentPlayer = [players objectAtIndex:0];
	
	// Hold a reference to the game configuration
	gameConfiguration = configuration;
	
	// Create a board, set up the player's heads, and update the player's initial controlled percentages of it
	board = [[[configuration boardPrototype] boardClass] boardWithParameters:[[configuration boardPrototype] setupParameters]];
	[board setHeadsForPlayers:players];
	[self updateControlPercentages];
	
	// Create the first piece
	currentPiece = [self nextPiece];
	
	// Set initial flag states
	inCaptureBatch = NO;
	inClearBatch = NO;
	gameOver = NO;
	
	return self;
}

- (PetriPlayer*)playerByID:(NSInteger)ID
{
	for (PetriPlayer* player in players)
	{
		if ([player playerID] == ID)
		{
			return player;
		}
	}
	
	/* Something went wrong if we don't have this playerID stored */
	return nil;
}

#pragma mark -
#pragma mark Game-State Actions

- (void)nextTurn
{
	PetriPlayer* previousPlayer = currentPlayer;
	[self willChangeValueForKey:@"currentPlayer"];
	NSLog(@"--- * Changing turn.");
	do
	{
		currentPlayer = [self nextPlayer];
	} while ([currentPlayer countOfControlledCells] == 0);
	[self didChangeValueForKey:@"currentPlayer"];
	
	if ([previousPlayer isEqual:currentPlayer])
	{
		[self willChangeValueForKey:@"gameOver"];
		gameOver = YES;
		[self didChangeValueForKey:@"gameOver"];
	}
	
	[self willChangeValueForKey:@"currentPiece"];
	currentPiece = [self nextPiece];
	[self didChangeValueForKey:@"currentPiece"];
	
	NSLog(@"Current player has %lu cells, %lu cells are on the board.", [currentPlayer countOfControlledCells], [board countOfCells]);
	
	if ((random() % 10) == 0)
	{
		for (PetriPlayer* player in players)
		{
			if ([player countOfControlledCells] > 0)
				[player addItemsObject:[PetriBiteItem item]];
		}
	}
}

- (void)performCapturesForCurrentPlayer
{
	NSLog(@">>> + Starting captures for current player.");
	BOOL capturesPerformed = NO;
	do
	{
		capturesPerformed = [self stepCapturesForCurrentPlayer];
		[self updateControlPercentages];
	} while (capturesPerformed);
	NSLog(@"<<< + End of captures for current player.");
}

- (BOOL)stepCapturesForCurrentPlayer
{
	[self setInCaptureBatch:YES];
	NSLog(@">>> + Starting capture batch.");
	
	// Perform a step of the captures
	BOOL didPerformCaptures = [board stepCapturesForPlayer:currentPlayer];
	
	NSLog(@"<<< + Ending capture batch.");
	[self setInCaptureBatch:NO];
	
	return didPerformCaptures;
}

- (void)clearDeadCells
{
	[self setInClearBatch:YES];
	NSLog(@">>> - Starting clear batch.");
	// Clean up dead cells caused by captures.
	[board clearDeadCells];
	NSLog(@"<<< - Ending clear batch.");
	[self setInClearBatch:NO];
	
	[self updateControlPercentages];
}

- (void)updateControlPercentages
{
	// Determine what percentage of the board each player controls
	for (PetriPlayer* player in [self players])
	{
		double controlPercentage = (100.0 * ((double)[player countOfControlledCells] / (double)[board countOfCells]));
		[player setControlPercentage:(NSUInteger)lround(controlPercentage)];
	}
}

- (void)rotateCurrentPiece
{
	[currentPiece rotate];
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)countOfPlayers
{
	return [players count];
}

- (NSEnumerator*)enumeratorOfPlayers
{
	return [players objectEnumerator];
}

- (PetriPlayer*)memberOfPlayers:(PetriPlayer*)player
{
	return [players firstObjectCommonWithArray:[NSArray arrayWithObject:player]];
}

- (id<PetriPiece>)nextPiece
{
	// Create a list from which to select a next piece
	NSMutableArray* pieces = [NSMutableArray array];
	for (id<PetriPiece> piece in [gameConfiguration pieceFrequencies])
	{
		// Populate the array with each piece type in the dictionary, duplicated according to its frequency
		for (NSInteger i = 0; i < [[[gameConfiguration pieceFrequencies] objectForKey:piece] integerValue]; i++)
		{
			[pieces addObject:piece];
		}
	}
	
	// Choose a piece at random from the list
	id<PetriPiece> nextPiece = [pieces objectAtIndex:(random() % [pieces count])];
	
	// Choose at random a number of times to rotate the piece
	NSInteger numRotations = (random() % [[nextPiece class] orientationsCount]);
	
	// Rotate the piece
	nextPiece = [[[nextPiece class] alloc] initWithPiece:nextPiece
											   rotations:numRotations];
	
	return nextPiece;
}

- (PetriPlayer*)nextPlayer
{
	//N.B. Assumes that there are no duplicate player objects.
	NSUInteger index = [players indexOfObject:currentPlayer];
	return [players objectAtIndex:((index + 1) % [players count])];
}

- (void)useItem:(PetriItem*)item
		onCells:(NSArray*)cells
		 pieces:(NSArray*)pieces
		players:(NSArray*)targetPlayers
	   byPlayer:(PetriPlayer*)usingPlayer
{
	[usingPlayer removeItemsObject:item];
	[item useItemOnCells:cells pieces:pieces players:targetPlayers byPlayer:usingPlayer onBoard:board];
	
	// If the item can create captures, perform them
	if ([item allowsCaptures])
		[self performCapturesForCurrentPlayer];
	
	// Clean up any dead cells
	[self clearDeadCells];
}

- (void)placePiece:(id<PetriPiece>)piece
         forPlayer:(PetriPlayer*)pieceOwner
            onCell:(PetriBoardCell*)cell
{
	[[self board] placePiece:piece
	               withOwner:pieceOwner
	                  onCell:cell];
	
	[self performCapturesForCurrentPlayer];

	[self clearDeadCells];

	[self nextTurn];
}

@synthesize players;
@synthesize currentPlayer;
@synthesize board;
@synthesize gameConfiguration;
@synthesize currentPiece;
@synthesize inClearBatch;
@synthesize inCaptureBatch;
@synthesize gameOver;

@end
