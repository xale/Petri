//
//  PetriUserTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserTestCases.h"
#import "PetriUser.h"

@implementation PetriUserTestCases

NSString* const PetriUserTestNickname =	@"test nickname";

- (void)testCreatePetriUser
{
	// Create an instance
	PetriUser* testUser = [[PetriUser alloc] init];
	STAssertNotNil(testUser, @"User object not created successfully");
	
	// Test setting nickname
	[testUser setNickname:PetriUserTestNickname];
	STAssertNotNil([testUser nickname], @"Could not set user nickname");
	STAssertEqualObjects([testUser nickname], PetriUserTestNickname, @"User nickname did not set correctly");
}

@end
