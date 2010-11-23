//
//  PetriGameTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameTestCases.h"
#import "PetriGame.h"
#import "PetriMockPlayer.h"
#import "PetriGameConfiguration.h"

@implementation PetriGameTestCases

- (void)testCreatePetriGame
{
	PetriPlayer* testPlayer = [[PetriMockPlayer alloc] init];
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	PetriGame* testGame = [[PetriGame alloc] initWithPlayers:[NSArray arrayWithObject:testPlayer]
										   gameConfiguration:testGameRules];
	STAssertNotNil(testGame, @"Game object not created successfully");
}

- (void)testGameBoardNotNil
{
	PetriPlayer* testPlayer = [[PetriMockPlayer alloc] init];
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	PetriGame* testGame = [[PetriGame alloc] initWithPlayers:[NSArray arrayWithObject:testPlayer]
										   gameConfiguration:testGameRules];
	STAssertNotNil([testGame board], @"The board should never be nil");
	
}

- (void)testGameBoardHandlesEmptyPlayersArray
{
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:[NSArray array] gameConfiguration:testGameRules], @"An exception was not thrown when PetriGame was initialized with an empty array");
	
}

- (void)testGameBoardHandlesNilPlayersArray
{
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:nil gameConfiguration:testGameRules], @"An exception was not thrown when PetriGame was initialized with a nil array");
	
}

@end
