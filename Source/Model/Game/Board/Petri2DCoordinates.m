//
//  Petri2DCoordinates.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "Petri2DCoordinates.h"


@implementation Petri2DCoordinates

- (id)initWithHorizontalCoordinate:(NSInteger)x
				verticalCoordinate:(NSInteger)y
{
	horizontalCoordinate = x;
	verticalCoordinate = y;
	return self;
}

+ (id)coordinatesWithHorizontalCoordinate:(NSInteger)x
					   verticalCoordinate:(NSInteger)y
{
	return [[Petri2DCoordinates alloc] initWithHorizontalCoordinate:x verticalCoordinate:y];
}

- (Petri2DCoordinates*)rotatedClockwise
{
	return [Petri2DCoordinates coordinatesWithHorizontalCoordinate:[self verticalCoordinate] verticalCoordinate:-[self horizontalCoordinate]];
}
- (Petri2DCoordinates*)rotatedCounterClockwise
{
	return [Petri2DCoordinates coordinatesWithHorizontalCoordinate:-[self verticalCoordinate] verticalCoordinate:[self horizontalCoordinate]];
}

@synthesize verticalCoordinate;
@synthesize horizontalCoordinate;

@end
