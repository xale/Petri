//
//  PetriGridPieceTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridPieceTestCases.h"

#import "PetriMockGridPiece.h"
#import "Petri2DCoordinates.h"

#define EXPECTED_WIDTH	2
#define EXPECTED_HEIGHT	3

@implementation PetriGridPieceTestCases

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
	testPiece = [PetriMockGridPiece pieceWithCellCoordinates:testSet];
	
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
	STAssertNotNil(testPiece, @"Unable to create test PetriMockGridPiece.");
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
	STAssertEqualObjects(testPiece, testPiece, @"Test PetriMockGridPiece is not equal to itself");
	
	// Create an identical piece
	PetriMockGridPiece* identicalPiece = [PetriMockGridPiece pieceWithCellCoordinates:[testSet copy]];
	STAssertEqualObjects(testPiece, identicalPiece, @"Test PetriMockGridPiece is not equal to an identical piece");
	
	// The rotated piece is distinct; make sure that -isEqual: sees it our way
	STAssertFalse([testPiece isEqual:[PetriMockGridPiece pieceWithCellCoordinates:rotatedSet]], @"Test PetriSquareridPiece is equal to a distinct piece");
}

- (void)testNormalization
{
	// The piece being tested should be equivalent up to a shift, which the normalization should take care of
	STAssertEqualObjects(testPiece, [PetriMockGridPiece pieceWithCellCoordinates:denormalizedSet], @"Normalization function doing something wrong");
}

- (void)testPieceDimensions
{
	STAssertTrue(([testPiece width] == EXPECTED_WIDTH), @"Test PetriMockGridPiece width differs from expected width.");
	STAssertTrue(([testPiece height] == EXPECTED_HEIGHT), @"Test PetriMockGridPiece height differs from expected height.");
}

- (void)testPieceCopy
{
	PetriMockGridPiece* pieceCopy = [testPiece copy];
	STAssertNotNil(pieceCopy, @"Test PetriMockGridPiece copy unsuccessful");
	STAssertEqualObjects(testPiece, pieceCopy, @"Test PetriMockGridPiece copy differs from original");
}
@end
