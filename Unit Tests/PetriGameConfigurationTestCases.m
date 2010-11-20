//
//  PetriGameRulesTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfigurationTestCases.h"
#import "PetriGameConfiguration.h"

@implementation PetriGameConfigurationTestCases

- (id)testCreatePetriGameConfiguration
{
	PetriGameConfiguration* testGameConfiguration = [[PetriGameConfiguration alloc] init];
	STAssertNotNil(testGameConfiguration, @"PetriGameRules object creation unsuccessful");
}

@end
