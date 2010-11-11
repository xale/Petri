//
//  PetriItemTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriItemTestCases.h"
#import "PetriItem.h"

@implementation PetriItemTestCases

- (id)testCreatePetriItem
{
	PetriItem* testItem = [[PetriItem alloc] init];
	STAssertNotNil(testItem, @"PetriItem object creation unsuccessful");
}

@end
