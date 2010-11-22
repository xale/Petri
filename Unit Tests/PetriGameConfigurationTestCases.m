//
//  PetriGameConfigurationTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfigurationTestCases.h"
#import "PetriGameConfiguration.h"

@implementation PetriGameConfigurationTestCases

- (void)setUp
{
	testGameConfiguration = [[PetriGameConfiguration alloc] initWithMinPlayers:2
																	maxPlayers:4
															  pieceFrequencies:nil];	// FIXME: allow nil?
	STAssertNotNil(testGameConfiguration, @"PetriGameConfiguration object creation unsuccessful");
}

- (void)tearDown
{
	testGameConfiguration = nil;
}

- (void)testCreateInvalidGameConfiguration
{
	// Attempt to create an invalid game configuration, with greater maxPlayers than minPlayers
	STAssertThrows([[PetriGameConfiguration alloc] initWithMinPlayers:4 maxPlayers:3 pieceFrequencies:nil], @"Expected exception when creating game configuration with minPlayers > maxPlayers");	
}

@end
