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

- (void)setUp
{
	PetriPlayer* testPlayer = [[PetriMockPlayer alloc] init];
	PetriGameConfiguration* testGameConfiguration = [PetriGameConfiguration defaultGameConfiguration];
	testGame = [[PetriGame alloc] initWithPlayers:[NSArray arrayWithObject:testPlayer]
								gameConfiguration:testGameConfiguration];
	STAssertNotNil(testGame, @"Game object not created successfully");
}

- (void)tearDown
{
	testGame = nil;
}

- (void)testGameBoardNotNil
{
	STAssertNotNil([testGame board], @"The board should never be nil");
}

- (void)testGameBoardHandlesEmptyPlayersArray
{
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:[NSArray array] gameConfiguration:testGameRules], @"An exception was not thrown when PetriGame was initialized with an empty players array");
}

- (void)testGameBoardHandlesNilPlayersArray
{
	PetriGameConfiguration* testGameRules = [[PetriGameConfiguration alloc] init];
	STAssertThrows([[PetriGame alloc] initWithPlayers:nil gameConfiguration:testGameRules], @"An exception was not thrown when PetriGame was initialized with a nil players array");
}

@end
