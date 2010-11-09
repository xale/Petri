//
//  PetriGameGroupTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroupTestCases.h"
#import "PetriGameGroup.h"

@implementation PetriGameGroupTestCases

- (id)testCreatePetriGameGroup
{
	PetriGameGroup* testGameRules = [[PetriGameGroup alloc] init];
	STAssertNotNil(testGameRules, @"PetriGameGroup object creation unsuccessful");
}

@end
