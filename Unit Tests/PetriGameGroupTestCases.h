//
//  PetriGameGroupTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriGameGroup;
@class PetriUser;

@interface PetriGameGroupTestCases : SenTestCase
{
	PetriGameGroup* testGameGroup;
	PetriUser* user1;
	PetriUser* user2;
	PetriUser* user3;
}

- (void)testIdempotentAddRemove;
- (void)testAdd;
- (void)testRemove;

@end
