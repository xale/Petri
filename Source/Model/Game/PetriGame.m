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

@implementation PetriGame

#pragma mark -
#pragma mark Accessors

- (id)initWithPlayers:(NSArray*)playersInGame
	gameConfiguration:(PetriGameConfiguration*)configuration
{
	players = [playersInGame mutableCopy];
	currentPlayer = [players objectAtIndex:0];
	gameConfiguration = configuration;
	board = [[PetriSquareGridBoard alloc] init]; // FIXME: generate board from game configuration
	return self;
}

- (void)addPlayersObject:(PetriPlayer*)player
{
	//FIXME: Should probably handle case where player is already in array
	[self willChangeValueForKey:@"player"];
	[players addObject:player];
	[self didChangeValueForKey:@"player"];
}

- (void)removePlayersObject:(PetriPlayer*)player
{
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
	NSUInteger index = [players indexOfObject:player];
	if (index == NSNotFound)
	{
		return nil;
	}
	return [players objectAtIndex:index];
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

- (NSArray*)players
{
	return [players copy];
}

@synthesize currentPlayer;
@synthesize board;
@synthesize gameConfiguration;
@synthesize currentPiece;

@end
