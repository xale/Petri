//
//  PetriPieceTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridPieceTestCases.h"
#import "PetriSquareGridPiece.h"

#import "Petri2DCoordinates.h"

#define EXPECTED_WIDTH	2
#define EXPECTED_HEIGHT	3

@implementation PetriSquareGridPieceTestCases

- (void)setUp
{
	// Create a test piece (shaped like a 'C')
	testPiece = [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
													  [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
													  [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
													  nil]];
	
	STAssertNotNil(testPiece, @"Unable to create test PetriSquareGridPiece.");
}

- (void)tearDown
{
	testPiece = nil;
}

- (void)testPieceEquality
{
	STAssertEqualObjects(testPiece, testPiece, @"Test PetriSquareGridPiece is not equal to itself");
	
	// Create an identical piece
	PetriSquareGridPiece* identicalPiece = [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
																	   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
																	   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
																	   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
																	   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
																	   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
																	   nil]];
	STAssertEqualObjects(testPiece, identicalPiece, @"Test PetriSquareGridPiece is not equal to an identical piece");
}

- (void)testPieceDimensions
{
	STAssertTrue(([testPiece width] == EXPECTED_WIDTH), @"Test PetriSquareGridPiece width differs from expected width.");
	STAssertTrue(([testPiece height] == EXPECTED_HEIGHT), @"Test PetriSquareGridPiece height differs from expected height.");
}

- (void)testPieceCopy
{
	PetriSquareGridPiece* pieceCopy = [testPiece copy];
	STAssertNotNil(pieceCopy, @"Test PetriSquareGridPiece copy unsuccessful");
	STAssertEqualObjects(testPiece, pieceCopy, @"Test PetriSquareGridPiece copy differs from original");
}

- (void)testPieceIdempotentRepeatedRotate
{
	PetriSquareGridPiece* rotatedPiece = [testPiece copy];
	for (NSUInteger numRotations = 0; numRotations < [PetriSquareGridPiece orientationsCount]; numRotations++)
	{
		[rotatedPiece rotate];
	}
	STAssertEqualObjects(testPiece, rotatedPiece, @"Rotating a piece orientationCount (%d) times should result in identity.", [PetriSquareGridPiece orientationsCount]);
}

@end
