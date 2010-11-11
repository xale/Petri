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

@end
