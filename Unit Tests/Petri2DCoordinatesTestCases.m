//
//  Petri2DCoordinatesTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "Petri2DCoordinatesTestCases.h"
#import "Petri2DCoordinates.h"

@implementation Petri2DCoordinatesTestCases

#define XCOORD 2
#define YCOORD 3

- (void)setUp
{
	coordinates = [Petri2DCoordinates coordinatesWithXCoordinate:XCOORD yCoordinate:YCOORD];
	STAssertNotNil(coordinates, @"Petri2DCoordinates failed to allocate.");
	STAssertTrue(XCOORD == [coordinates xCoordinate], @"x coordinate set incorrectly");
	STAssertTrue(YCOORD == [coordinates yCoordinate], @"y coordinate set incorrectly");
}

- (void)tearDown
{
	coordinates = nil;
}

- (void)testIdentityComparison
{
	STAssertTrue([coordinates isEqualToCoordinates:coordinates], @"Comparison with self returned false");
	STAssertTrue([coordinates isEqual:coordinates], @"Comparison with self returned false");
}

#define NUM_OFFSET_TESTS 9

- (void)testOffsetIdentities
{
	NSInteger offsets[NUM_OFFSET_TESTS][2] = {
		{-1,  1}, { 0,  1}, { 1,  1},
		{-1,  0}, { 0,  0}, { 0,  1},
		{-1, -1}, { 0, -1}, {-1,  1}
	};
	
	Petri2DCoordinates* forwardOffset = nil, * reverseOffset = nil;
	for (NSUInteger offsetIndex = 0; offsetIndex < NUM_OFFSET_TESTS; offsetIndex++)
	{
		forwardOffset = [coordinates offsetCoordinatesByX:(offsets[offsetIndex][0])
														Y:(offsets[offsetIndex][1])];
		reverseOffset = [forwardOffset offsetCoordinatesByX:(0 - offsets[offsetIndex][0])
														  Y:(0 - offsets[offsetIndex][1])];
		STAssertEqualObjects(coordinates, reverseOffset, @"Offsetting by (%d, %d) did not revert to original coordinates after reverse offset", offsets[offsetIndex][0], offsets[offsetIndex][1]);
	}
}

- (void)testRotateIdentities
{
	Petri2DCoordinates* coordinates2 = [coordinates rotatedClockwiseAboutOrigin];
	STAssertEqualObjects(coordinates, [coordinates2 rotatedCounterclockwiseAboutOrigin], @"Rotating clockwise then counterclockwise should result in identity.");
	Petri2DCoordinates* coordinates3 = [coordinates2 rotatedClockwiseAboutOrigin];
	Petri2DCoordinates* coordinates4 = [coordinates3 rotatedClockwiseAboutOrigin];
	STAssertEqualObjects(coordinates, [coordinates4 rotatedClockwiseAboutOrigin], @"Rotating clockwise 4 times should result in identity.");
}

- (void)testEquality
{
	Petri2DCoordinates* coordinates2 = [Petri2DCoordinates coordinatesWithXCoordinate:XCOORD yCoordinate:YCOORD];
	
	STAssertEqualObjects(coordinates, coordinates, @"Object should certainly be equal to itself");
	STAssertEqualObjects(coordinates, coordinates2, @"Object should be equal to another object created with the same parameters");
}

@end
