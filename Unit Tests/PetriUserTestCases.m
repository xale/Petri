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

- (void)testCreatePetriUser
{
	PetriUser* testUser = [[PetriUser alloc] init];
	
	STAssertNotNil(testUser, @"User object not created successfully");
}

@end
