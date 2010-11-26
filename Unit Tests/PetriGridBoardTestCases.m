//
//  PetriBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoardTestCases.h"

#import "PetriMockGridBoard.h"

#import "Petri2DCoordinates.h"

#import "PetriPiece.h"

#import "PetriMockPlayer.h"

#define WIDTH	20
#define HEIGHT	25

@implementation PetriGridBoardTestCases

- (void)setUp
{
	testGridBoard = [[PetriMockGridBoard alloc] initWithWidth:WIDTH height:HEIGHT];
	STAssertNotNil(testGridBoard, @"Initializing PetriMockGridBoard failed.");
}

- (void)tearDown
{
	testGridBoard = nil;
}

- (void)testInitUsesCorrectDimensions
{
	STAssertTrue([testGridBoard width]==WIDTH && [testGridBoard height]==HEIGHT, @"Board width or height not assigned correctly.");
}

- (void)testPlacePiece
{
	NSInteger x = 3;
	NSInteger y = 3;
	PetriPlayer* player = [[PetriMockPlayer alloc] init];
	PetriPiece* piece = [PetriPiece pieceWithCellCoordinates:[NSSet setWithObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0]]];
	[testGridBoard placePiece:piece withOwner:player onCell:[testGridBoard cellAtX:x Y:y]];
	
	STAssertEqualObjects([[testGridBoard cellAtX:x Y:y] owner], player, @"Cell at this location should have been covered in the placement.");
}

@end
