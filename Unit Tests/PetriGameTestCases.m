//
//  PetriGameTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameTestCases.h"
#import "PetriGame.h"

@implementation PetriGameTestCases

- (void)testCreatePetriGame
{
	PetriGame* testGame = [[PetriGame alloc] init];
	STAssertNotNil(testGame, @"Game object not created successfully");
//	PetriPlayer* testPlayer = [[PetriPlayer alloc] init];
//	PetriBoard* testBoard = [[PetriBoard alloc] init];
//	PetriGameRules* testGameRules [[PetriGameRules alloc] init];
}

@end
