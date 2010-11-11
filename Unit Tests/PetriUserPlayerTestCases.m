//
//  PetriUserPlayerTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserPlayerTestCases.h"
#import "PetriUserPlayer.h"
#import "PetriUser.h"

@implementation PetriUserPlayerTestCases

- (void)testCreatePetriUserPlayer
{
	// Create a test instance
	PetriUser* testUser = [[PetriUser alloc] init];
	PetriUserPlayer* testPlayer = [[PetriUserPlayer alloc] initWithControllingUser:testUser];
	STAssertNotNil(testPlayer, @"PetriUserPlayer object creation unsuccessful");
	
	// Test accessors
	STAssertEqualObjects([testPlayer controllingUser], testUser, @"PetriUserPlayer controllingUser not set correctly by initializer");
	
	[testPlayer setCellsControlled:50];
	STAssertEquals([testPlayer cellsControlled], (NSInteger)50, @"PetriUserPlayer cellsControlled not set correctly by accessor");
	
	NSMutableDictionary* testItemDict = [NSMutableDictionary dictionary];
	[testPlayer setItems:testItemDict];
	STAssertEqualObjects([testPlayer items], testItemDict, @"PetriUserPlayer items not set correctly by accessor");
}

@end
