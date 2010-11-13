//
//  PetriBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardTestCases.h"
#import "PetriBoard.h"

@implementation PetriBoardTestCases

- (id)testCreatePetriBoard
{
	PetriBoard* testBoard = [[PetriBoard alloc] init];
	STAssertNotNil(testBoard, @"PetriBoard object creation unsuccessful");
}

- (id) testCellAtLocation
{
	PetriBoard* testBoard = [[PetriBoard alloc] init];
	STAssertNotNil([cellAtLocation:[[PetriBoardLocation alloc] initWithX:3 Y:2]], @"Could not retrieve a cell at location (3,2)";

}

@end
