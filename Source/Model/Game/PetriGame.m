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
	NSDictionary* pieceFrequencies = [gameConfiguration pieceFrequencies];
	long accum = 0;
	for (NSNumber* num in [pieceFrequencies objectEnumerator])
	{
		accum += [num longValue];
	}
	NSMutableArray* pieces = [NSMutableArray arrayWithCapacity:accum]; // there is technically a signedness type error
	for (PetriPiece* piece in pieceFrequencies)
	{
		for (int i = 0; i < [[pieceFrequencies objectForKey:piece] intValue]; i++)
		{
			[pieces addObject:piece];
		}
	}
	return [pieces objectAtIndex:(random() % accum)];
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
