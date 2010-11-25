//
//  PetriPieceTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceTestCases.h"
#import "PetriPiece.h"

#import "Petri2DCoordinates.h"

#define EXPECTED_WIDTH	2
#define EXPECTED_HEIGHT	3

@implementation PetriPieceTestCases

- (void)setUp
{
	// Create a test piece (shaped like a 'C')
	testPiece = [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
													  [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
													  [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
													  [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
													  nil]];
	STAssertNotNil(testPiece, @"Unable to create test PetriPiece.");
}

- (void)tearDown
{
	testPiece = nil;
}

- (void)testPieceDimensions
{
	STAssertTrue(([testPiece width] == EXPECTED_WIDTH), @"Test PetriPiece width differs from expected width.");
	STAssertTrue(([testPiece height] == EXPECTED_HEIGHT), @"Test PetriPiece height differs from expected height.");
}

- (void)testPieceIdempotentRotateRevert
{
	PetriPiece* rotatedPiece = [testPiece pieceRotatedClockwise];
	rotatedPiece = [rotatedPiece pieceRotatedCounterclockwise];
	STAssertEqualObjects(testPiece, rotatedPiece, @"Clockwise rotate followed by counterclockwise rotate should result in identity.");
}

- (void)testPieceIdempotentRepeatedRotate
{
	PetriPiece* rotatedPiece = [testPiece copy];
	for (NSInteger numRotations = 0; numRotations < 4; numRotations++) // FIXME: hardcoded value; should use number of orientations
	{
		rotatedPiece = [rotatedPiece pieceRotatedClockwise];
	}
	STAssertEqualObjects(testPiece, rotatedPiece, @"Rotating clockwise orientationCount (%d) times should result in identity.", 4); // FIXME: hardcoded value
	
	rotatedPiece = [testPiece copy];
	for (NSInteger numRotations = 0; numRotations < 4; numRotations++) // FIXME: hardcoded value; should use number of orientations
	{
		rotatedPiece = [rotatedPiece pieceRotatedCounterclockwise];
	}
	STAssertEqualObjects(testPiece, rotatedPiece, @"Rotating counterclockwise orientationCount (%d) times should result in identity.", 4); // FIXME: hardcoded value
}

@end
