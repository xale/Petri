//
//  PetriBoardCellTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCellTestCases.h"
#import "PetriBoardCell.h"

@implementation PetriBoardCellTestCases

- (void)setUp
{
	testCell = [[PetriBoardCell alloc] init];
	STAssertNotNil(testCell, @"Test PetriBoardCell creation unsuccessful");
}

- (void)tearDown
{
	testCell = nil;
}

- (void)testCellEquality
{
	STAssertEqualObjects(testCell, testCell, @"Test PetriBoardCell is not equal to itself");
	
	// Create an identical cell
	PetriBoardCell* identicalCell = [[PetriBoardCell alloc] init];
	STAssertEqualObjects(testCell, identicalCell, @"Test PetriBoardCell is not equal to identical cell object.");
}

- (void)testCellCopy
{
	// Copy the test cell
	PetriBoardCell* cellCopy = [testCell copy];
	STAssertNotNil(cellCopy, @"Test PetriBoardCell copy unsuccessful");
	STAssertEqualObjects(testCell, cellCopy, @"Test PetriBoardCell differs from copy");
}

@end
