//
//  PetriGameConfigurationTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriGameConfiguration;

@interface PetriGameConfigurationTestCases : SenTestCase
{
	PetriGameConfiguration* testGameConfiguration;
}

- (void)testCreateInvalidGameConfiguration;

@end
