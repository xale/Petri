//
//  PetriUserTestCases.h
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriUser;

@interface PetriUserTestCases : SenTestCase
{
	PetriUser* testUser;
}

- (void)testCreatePetriUserWithName;
- (void)testSetUserName;

@end
