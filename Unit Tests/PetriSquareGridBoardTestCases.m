//
//  PetriSquareGridBoardTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/11/22.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoardTestCases.h"
#import "PetriBoard.h"
#import "PetriGridBoard.h"
#import "PetriSquareGridBoard.h"
#import "PetriPlayer.h"
#import "PetriMockPlayer.h"
#import "Petri2DCoordinates.h"
#import "PetriPiece.h"
#import "PetriCellType.h"

#define WIDTH 20
#define HEIGHT 25

@implementation PetriSquareGridBoardTestCases

- (void)setUp
{
	board = [[PetriSquareGridBoard alloc] initWithWidth:WIDTH height:HEIGHT];
	STAssertNotNil(board, @"Initializing PetriSquareGridBoard failed.");
}

- (void)tearDown
{
	board = nil;
}

- (void)testInitUsesCorrectDimensions
{
	STAssertTrue([board width]==WIDTH && [board height]==HEIGHT, @"Board width or height not assigned correctly.");
}

- (void)testValidatePlacement
{
	PetriPlayer* player = [[PetriMockPlayer alloc] init];
	NSSet* set = [NSSet setWithObjects:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0], [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1], nil];
	PetriPiece* piece = [PetriPiece pieceWithCellCoordinates:set];
	int headx = 3;
	int heady = 3;
	
	PetriBoardCell* cell = [board cellAtX:headx Y:heady];
	[cell setCellType:headCell];
	[cell setOwner:player];
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:headx yCoordinate:heady]], @"Overlapping placement should be invalid.");
	STAssertTrue([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headx-1) yCoordinate:heady]], @"Adjacent placement should be valid.");
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headx-2) yCoordinate:heady]], @"Non-adjacent placement should be invalid.");
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headx-1) yCoordinate:(heady+1)]], @"Diagonal adjacency placement should be invalid.");
}

@end
