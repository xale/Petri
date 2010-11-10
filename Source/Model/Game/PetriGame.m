//
//  PetriGame.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGame.h"


@implementation PetriGame

#pragma mark -
#pragma mark Accessors

- (id)initWithPlayers:(NSArray*)playersInGame
			gameRules:(PetriGameRules*)rules
{
	players = [playersInGame mutableCopy];
	currentPlayer = [players objectAtIndex:0];
	gameRules = rules;
	board = nil; // FIXME: generate board from game rules
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

@synthesize currentPlayer;
@synthesize board;
@synthesize gameRules;

@end
