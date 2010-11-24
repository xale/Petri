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
 Updates the value of current piece randomly based on the distribution provided at initialization.
 */
- (void)nextPiece;

/*!
 Updates the value of the player looping over the array;
 */
- (void)nextPlayer;

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
	players = [playersInGame mutableCopy];
	currentPlayer = [players objectAtIndex:0];
	gameConfiguration = configuration;
	board = [[PetriSquareGridBoard alloc] initWithWidth:20
												 height:20]; // FIXME: generate board from game configuration
	[self nextPiece];
	return self;
}

- (void)nextTurn
{
	[self willChangeValueForKey:@"currentPiece"];
	[self willChangeValueForKey:@"currentPlayer"];
	[self nextPlayer];
	[self nextPiece];
	[self didChangeValueForKey:@"currentPlayer"];
	[self didChangeValueForKey:@"currentPiece"];
}

#pragma mark -
#pragma mark Accessors

- (void)addPlayersObject:(PetriPlayer*)player
{
	if ([players containsObject:player])
	{
		NSString* reason = [NSString stringWithFormat:@"Attempted to add user %@ to %@.", player, players];
		[[NSException exceptionWithName:@"PlayerFoundWhenAddingException" reason:reason userInfo:nil] raise];
	}
	[self willChangeValueForKey:@"player"];
	[players addObject:player];
	[self didChangeValueForKey:@"player"];
}

- (void)removePlayersObject:(PetriPlayer*)player
{
	if (![players containsObject:player])
	{
		NSString* reason = [NSString stringWithFormat:@"Attempted to remove player %@ from %@.", player, players];
		[[NSException exceptionWithName:@"PlayerNotFoundWhenRemovingException" reason:reason userInfo:nil] raise];
	}
	[self willChangeValueForKey:@"player"];
	[players removeObject:player];
	[self didChangeValueForKey:@"player"];
}

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

- (void)nextPiece
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
	currentPiece = [pieces objectAtIndex:(random() % accum)];
}

- (void)nextPlayer
{
	//N.B. Assumes that there are no duplicate player objects.
	
	NSUInteger index = [players indexOfObject:currentPlayer];
	NSUInteger nextIndex = index + 1;
	if (nextIndex < [players count])
	{
		currentPlayer = [players objectAtIndex:nextIndex];
	}
	else
	{
		currentPlayer = [players objectAtIndex:0];
	}
}

- (NSArray*)players
{
	return [players copy];
}

@synthesize currentPlayer;
@synthesize board;
@synthesize gameConfiguration;
@synthesize currentPiece;

@end
