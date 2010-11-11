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

- (void)testGameBoardNotNil
{
	PetriPlayer* testPlayer = [[PetriAIPlayer alloc] init];
	PetriGameRules* testGameRules = [[PetriGameRules alloc] init];
	PetriGame* testGame = [[PetriGame alloc] initWithPlayers:[NSArray arrayWithObject:testPlayer]
												   gameRules:testGameRules];
	STAssertNotNil([testGame board], @"The board should never be nil");
	
}

- (void)testGameBoardHandlesEmptyPlayersArray
{
	PetriGameRules* testGameRules = [[PetriGameRules alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:[NSArray array]
											gameRules:testGameRules],
				   @"An exception was not thrown when PetriGame was initialized with an empty array");
	
}

- (void)testGameBoardHandlesNilPlayersArray
{
	PetriGameRules* testGameRules = [[PetriGameRules alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:nil
											gameRules:testGameRules],
				   @"An exception was not thrown when PetriGame was initialized with a nil array");
	
}

@end
