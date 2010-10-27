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

NSString* const PetriUserTestNicknameOne =	@"test nickname";
NSString* const PetriUserTestNicknameTwo =	@"foobar #897";

- (void)testCreatePetriUser
{
	// Test creating an instance
	PetriUser* testUser = [[PetriUser alloc] initWithNickname:PetriUserTestNicknameOne];
	STAssertNotNil(testUser, @"PetriUser object not created successfully");
	
	// Test initial nickname
	STAssertEqualObjects([testUser nickname], PetriUserTestNicknameOne, @"PetriUser nickname not set correctly by initializer");
	
	// Test setting nickname
	[testUser setNickname:PetriUserTestNicknameTwo];
	STAssertEqualObjects([testUser nickname], PetriUserTestNicknameTwo, @"PetriUser nickname not set correctly by accessor");
}

@end
