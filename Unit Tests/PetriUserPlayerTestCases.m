//
//  PetriUserPlayerTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserPlayerTestCases.h"
#import "PetriUserPlayer.h"

@implementation PetriUserPlayerTestCases

- (void)testCreatePetriUserPlayer
{
	// Create a test instance
	PetriUserPlayer* testPlayer = [[PetriUserPlayer alloc] init];
	STAssertNotNil(testPlayer, @"PetriUserPlayer object creation unsuccessful");
	
	// Test accessors
	[testPlayer setCellsControlled:50];
	STAssertEquals([testPlayer cellsControlled], (NSInteger)50, @"PetriUserPlayer cellsControlled not set correctly");
	
	NSMutableDictionary* testItemDict = [NSMutableDictionary dictionary];
	[testPlayer setItems:testItemDict];
	STAssertEqualObjects([testPlayer items], testItemDict, @"PetriUserPlayer items not set correctly");
}

@end
