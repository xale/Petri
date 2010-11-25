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

/*!
 Private methods for PetriGame
 */
@interface PetriGame(Private)

/*!
 Returns the next PetriPiece to be assigned to \c currentPiece, chosen at random based on the distribution provided at initialization.
 */
- (PetriPiece*)nextPiece;

/*!
 Returns the next player to play, to be assigned to \c currentPlayer.
 */
- (PetriPlayer*)nextPlayer;

@end

@implementation PetriGame

- (id)initWithPlayers:(NSArray*)playersInGame
	gameConfiguration:(PetriGameConfiguration*)configuration
{
	if (playersInGame == nil || [playersInGame count] == 0)
	{
		NSString* reason = @"Attempted to create game with no players or nil players array";
		[[NSException exceptionWithName:@"BadPlayersArrayException" reason:reason userInfo:nil] raise];
	}
	players = [playersInGame copy];
	currentPlayer = [players objectAtIndex:0];
	gameConfiguration = configuration;
	board = [[PetriSquareGridBoard alloc] initWithWidth:20
												 height:20]; // FIXME: generate board from game configuration
	currentPiece = [self nextPiece];
	return self;
}

- (void)nextTurn
{
	[self willChangeValueForKey:@"currentPiece"];
	[self willChangeValueForKey:@"currentPlayer"];
	currentPlayer = [self nextPlayer];
	currentPiece = [self nextPiece];
	[self didChangeValueForKey:@"currentPlayer"];
	[self didChangeValueForKey:@"currentPiece"];
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

- (PetriPiece*)nextPiece
{
	// Create a list from which to select a next piece
	NSMutableArray* pieces = [NSMutableArray array];
	for (PetriPiece* piece in [gameConfiguration pieceFrequencies])
	{
		// Populate the array with each piece type in the dictionary, duplicated according to its frequency
		for (NSInteger i = 0; i < [[[gameConfiguration pieceFrequencies] objectForKey:piece] integerValue]; i++)
		{
			[pieces addObject:piece];
		}
	}
	
	// Choose a piece at random from the list
	PetriPiece* nextPiece = [pieces objectAtIndex:(random() % [pieces count])];
	
	// Choose at random a number of times to rotate the piece
	NSInteger numRotations = random() % 4; // FIXME: hardcoded value; should be based on number of possible rotations
	
	// Rotate the piece
	while (numRotations > 0)
	{
		nextPiece = [nextPiece pieceRotatedClockwise];
		numRotations--;
	}
	
	return nextPiece;
}

- (PetriPlayer*)nextPlayer
{
	//N.B. Assumes that there are no duplicate player objects.
	NSUInteger index = [players indexOfObject:currentPlayer];
	return [players objectAtIndex:((index + 1) % [players count])];
}

@synthesize players;
@synthesize currentPlayer;
@synthesize board;
@synthesize gameConfiguration;
@synthesize currentPiece;

@end
