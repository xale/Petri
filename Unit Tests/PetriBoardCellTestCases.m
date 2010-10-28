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

- (id)testCreatePetriBoardCell
{
	PetriBoardCell* testBoardCell = [[PetriBoardCell alloc] init];
	STAssertNotNil(testBoardCell, @"PetriBoardCell object creation unsuccessful");
}


@end
