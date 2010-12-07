//
//  PetriGameConfigurationTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfigurationTestCases.h"
#import "PetriGameConfiguration.h"

@implementation PetriGameConfigurationTestCases

- (void)setUp
{
	testGameConfiguration = [PetriGameConfiguration defaultGameConfiguration];
	STAssertNotNil(testGameConfiguration, @"PetriGameConfiguration object creation unsuccessful");
}

- (void)tearDown
{
	testGameConfiguration = nil;
}

@end
