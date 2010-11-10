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
	players = playersInGame;
	currentPlayer = [players objectAtIndex:0];
	gameRules = rules;
	board = nil; // FIXME: generate board from game rules
	return self;
}

- (void)addPlayersObject:(PetriPlayer*)player
{
	//FIXME: Should probably handle case where player is already in array
	//FIXME: Should players really be immutable?
	players = [NSArray arrayWithArray:[[players mutableCopy] arrayByAddingObject:player]];
}

@synthesize players;
@synthesize currentPlayer;
@synthesize board;
@synthesize gameRules;

@end
