//
//  PetriBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardTestCases.h"

#import "PetriBoard.h"
#import "PetriBoardLocation.h"

@implementation PetriBoardTestCases

- (void)testCreatePetriBoard
{
	PetriBoard* testBoard = [[PetriBoard alloc] init];
	STAssertNotNil(testBoard, @"PetriBoard object creation unsuccessful");
}

- (void)testCellAtLocation
{
	PetriBoard* testBoard = [[PetriBoard alloc] init];
	STAssertNotNil([testBoard cellAtLocation:[PetriBoardLocation locationWithX:3 Y:2]], @"Could not retrieve a cell at location (3,2)");
}

@end
