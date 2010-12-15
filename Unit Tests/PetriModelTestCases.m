//
//  PetriModelTestCases.m
//  Petri
//
//  Created by Alex Heinz on 11/21/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriModelTestCases.h"

#import "PetriModel.h"

@implementation PetriModelTestCases

- (void)setUp
{
	testModel = [[PetriModel alloc] init];
	STAssertNotNil(testModel, @"PetriModel object creation unsuccessful");
}

- (void)tearDown
{
	testModel = nil;
}

- (void)testCreateLocalGameGroup
{
	[testModel createLocalGameGroup];
	STAssertNotNil([testModel gameGroup], @"Creation of local Game Group by PetriModel unsuccessful");
	
	// FIXED: test that created group is a "local" group
	STAssertTrue([[testModel gameGroup] isLocalGameGroup], @"Created game group is not local");
}

@end
