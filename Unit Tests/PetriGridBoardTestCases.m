//
//  PetriBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoardTestCases.h"

#import "PetriGridBoard.h"
#import "PetriBoardLocation.h"

@implementation PetriGridBoardTestCases

- (void)testCreatePetriGridBoard
{
	PetriGridBoard* testBoard = [[PetriGridBoard alloc] init];
	STAssertNotNil(testBoard, @"PetriBoard object creation unsuccessful");
}

- (void)testCellAtLocation
{
	PetriGridBoard* testBoard = [[PetriGridBoard alloc] init];
	STAssertNotNil([testBoard cellAtLocation:[PetriBoardLocation locationWithX:3 Y:2]], @"Could not retrieve a cell at location (3,2)");
}

@end
