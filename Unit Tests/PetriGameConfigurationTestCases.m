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

- (void)testCreateInvalidGameConfigurations
{
	// Attempt to create a game configuration with minPlayers too small
	STAssertThrows([[PetriGameConfiguration alloc] initWithMinPlayers:0 maxPlayers:2 pieceFrequencies:nil], @"Expected exception when initializing game configuration with minPlayers too small");
	
	// Attempt to create a game configuration with maxPlayers too large
	STAssertThrows([[PetriGameConfiguration alloc] initWithMinPlayers:2 maxPlayers:7 pieceFrequencies:nil], @"Expected exception when initializing game configuration with maxPlayers too large");
	
	// Attempt to create an invalid game configuration, with greater maxPlayers than minPlayers
	STAssertThrows([[PetriGameConfiguration alloc] initWithMinPlayers:4 maxPlayers:3 pieceFrequencies:nil], @"Expected exception when initializing game configuration with minPlayers > maxPlayers");	
}

@end
