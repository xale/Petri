//
//  PetriMockGridBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMockGridBoardTestCases.h"
#import "PetriMockGridBoard.h"
#import "PetriMockPlayer.h"
#import "PetriPiece.h"
#import "PetriBoardCell.h"
#import "Petri2DCoordinates.h"

#define WIDTH 20
#define HEIGHT 25

@implementation PetriMockGridBoardTestCases

- (void)setUp
{
	board = [[PetriMockGridBoard alloc] initWithWidth:WIDTH height:HEIGHT];
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

- (void)testPlacePiece
{
	int x = 3;
	int y = 3;
	PetriPlayer* player = [[PetriMockPlayer alloc] init];
	PetriPiece* piece = [PetriPiece pieceWithCellCoordinates:[NSSet setWithObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0]]];
	[board placePiece:piece withOwner:player onCell:[board cellAtX:x Y:y]];
	
	STAssertEqualObjects([[board cellAtX:x Y:y] owner], player, @"Cell at this location should have been covered in the placement.");
}

@end
