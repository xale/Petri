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
	testSet = [NSSet setWithObjects:
			   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
			   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
			   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
			   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
			   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
			   nil];
	testPiece = [PetriSquareGridPiece pieceWithCellCoordinates:testSet];
	
	// Create a set of coordinates equivalent to the above but rotated once (clockwise)
	rotatedSet = [NSSet setWithObjects:
				  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
				  [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
				  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
				  [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
				  [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:0],
				  nil];
	
	// Create a set of coordinates equivalent to testSet but shifted so that normalization must take place
	denormalizedSet = [NSSet setWithObjects:
					   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:-1],
					   [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:-1],
					   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
					   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
					   [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
					   nil];
	STAssertNotNil(testPiece, @"Unable to create test PetriSquareGridPiece.");
}

- (void)tearDown
{
	testSet = nil;
	rotatedSet = nil;
	denormalizedSet = nil;
	testPiece = nil;
}

- (void)testPieceEquality
{
	STAssertEqualObjects(testPiece, testPiece, @"Test PetriSquareGridPiece is not equal to itself");
	
	// Create an identical piece
	PetriSquareGridPiece* identicalPiece = [PetriSquareGridPiece pieceWithCellCoordinates:[testSet copy]];
	STAssertEqualObjects(testPiece, identicalPiece, @"Test PetriSquareGridPiece is not equal to an identical piece");
	
	// The rotated piece is distinct; make sure that -isEqual: sees it our way
	STAssertFalse([testPiece isEqual:[PetriSquareGridPiece pieceWithCellCoordinates:rotatedSet]], @"Test PetriSquareridPiece is equal to a distinct piece");
}

- (void)testNormalization
{
	// The piece being tested should be equivalent up to a shift, which the normalization should take care of
	STAssertEqualObjects(testPiece, [PetriSquareGridPiece pieceWithCellCoordinates:denormalizedSet], @"Normalization function doing something wrong");
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
