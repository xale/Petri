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

- (void)setUp
{
	coordinates = [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:3];
	STAssertNotNil(coordinates, @"Petri2DCoordinates failed to allocate.");
	STAssertTrue(2 == [coordinates xCoordinate], @"x coordinate set incorrectly");
	STAssertTrue(3 == [coordinates yCoordinate], @"y coordinate set incorrectly");
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

- (void)testRotateIdentities
{
	Petri2DCoordinates* coordinates2 = [coordinates rotatedClockwiseAboutOrigin];
	STAssertEqualObjects(coordinates, [coordinates2 rotatedCounterclockwiseAboutOrigin], @"Rotating clockwise then counterclockwise should result in identity.");
	Petri2DCoordinates* coordinates3 = [coordinates2 rotatedClockwiseAboutOrigin];
	Petri2DCoordinates* coordinates4 = [coordinates3 rotatedClockwiseAboutOrigin];
	STAssertEqualObjects(coordinates, [coordinates4 rotatedClockwiseAboutOrigin], @"Rotating clockwise 4 times should result in identity.");
}

@end
