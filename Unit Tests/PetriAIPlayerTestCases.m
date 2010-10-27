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
	STAssertNotNil(testPlayer, @"PetriAIPlayer object creation unsuccessful");
	
	// Test accessors
	[testPlayer setCellsControlled:50];
	STAssertEquals([testPlayer cellsControlled], (NSInteger)50, @"PetriAIPlayer cellsControlled not set correctly by accessor");
	
	NSMutableDictionary* testItemDict = [NSMutableDictionary dictionary];
	[testPlayer setItems:testItemDict];
	STAssertEqualObjects([testPlayer items], testItemDict, @"PetriAIPlayer items not set correctly by accessor");
}

@end
