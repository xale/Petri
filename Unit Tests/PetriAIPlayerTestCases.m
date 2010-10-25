//
//  PetriAIPlayerTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAIPlayerTestCases.h"
#import "PetriAIPlayer.h"

@implementation PetriAIPlayerTestCases

- (void)testCreatePetriAIPlayer
{
	// Create a test instance
	PetriAIPlayer* testPlayer = [[PetriAIPlayer alloc] init];
	STAssertNotNil(testPlayer, @"AI player object creation unsuccessful");
	
	// Test accessors
	[testPlayer setCellsControlled:50];
	STAssertEquals([testPlayer cellsControlled], (NSInteger)50, @"AI Player cellsControlled not set correctly");
	
	NSMutableDictionary* testItemDict = [NSMutableDictionary dictionary];
	[testPlayer setItems:testItemDict];
	STAssertEqualObjects([testPlayer items], testItemDict, @"AI Player items not set correctly");
}

@end
