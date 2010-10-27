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

@synthesize players;
@synthesize currentPlayer;
@synthesize board;
@synthesize gameRules;

@end
