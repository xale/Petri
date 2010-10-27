//
//  PetriGameTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameTestCases.h"
#import "PetriGame.h"
#import "PetriAIPlayer.h"
#import "PetriGameRules.h"

@implementation PetriGameTestCases

- (void)testCreatePetriGame
{
	PetriPlayer* testPlayer = [[PetriAIPlayer alloc] init];
	PetriGameRules* testGameRules = [[PetriGameRules alloc] init];
	PetriGame* testGame = [[PetriGame alloc] initWithPlayers:[NSArray arrayWithObject:testPlayer]
												   gameRules:testGameRules];
	STAssertNotNil(testGame, @"Game object not created successfully");
}

@end
