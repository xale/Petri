//
//  PetriGameRulesTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameRulesTestCases.h"
#import "PetriGameRules.h"

@implementation PetriGameRulesTestCases

- (id)testCreatePetriGameRules
{
	PetriGameRules* testGameRules = [[PetriGameRules alloc] init];
	STAssertNotNil(testGameRules, @"PetriGameRules object creation unsuccessful");
}

@end
