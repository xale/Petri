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

- (void)setUp
{
	testItem = [[PetriItem alloc] init];
	STAssertNotNil(testItem, @"Test PetriItem object creation unsuccessful");
}

- (void)tearDown
{
	testItem = nil;
}

- (void)testItemEquality
{
	STAssertEqualObjects(testItem, testItem, @"Test PetriItem not equal to itself");
	
	// FIXME: test comparison of two separate items
}

- (void)testCopyItem
{
	PetriItem* itemCopy = [testItem copy];
	STAssertNotNil(itemCopy, @"Test PetriItem copy unsuccessful");
	STAssertEqualObjects(testItem, itemCopy, @"Test PetriItem copy differs from original");
}

@end
