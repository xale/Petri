//
//  PetriBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoardTestCases.h"

#import "PetriGridBoard.h"
#import "PetriMockGridBoard.h"

#import "Petri2DCoordinates.h"

#import "PetriPiece.h"

#import "PetriPlayer.h"
#import "PetriMockPlayer.h"

@implementation PetriGridBoardTestCases

- (void)setUp
{
	testGridBoard = [[PetriMockGridBoard alloc] init];
	STAssertNotNil(testGridBoard, @"PetriMockGridBoard object creation unsuccessful");
}

- (void)tearDown
{
	testGridBoard = nil;
}

/*
- (void)testPlacePiece
{
	PetriGridBoard* testBoard = [[PetriGridBoard alloc] init];
	PetriPiece* piece = [[PetriPiece alloc] init];
	PetriPlayer* owner = [[PetriPlayer alloc] init];
	PetriBoardLocation* location = [[PetriBoardLocation alloc] initWithX:2 Y:3];
	
	BOOL success = [testBoard placePiece:piece atLocation:location withOwner:owner];
}*/

- (void)testCellAtLocation
{
	STAssertNotNil([testGridBoard cellAtLocation:[Petri2DCoordinates coordinatesWithXCoordinate:3 yCoordinate:2]], @"Could not retrieve a cell at coordinates (3,2)");
}

@end
