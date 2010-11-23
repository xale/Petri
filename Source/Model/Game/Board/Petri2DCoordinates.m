//
//  Petri2DCoordinates.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "Petri2DCoordinates.h"


@implementation Petri2DCoordinates

- (id)initWithXCoordinate:(NSInteger)x
			  yCoordinate:(NSInteger)y
{
	xCoordinate = x;
	yCoordinate = y;
	return self;
}

+ (id)coordinatesWithXCoordinate:(NSInteger)x
					 yCoordinate:(NSInteger)y
{
	return [[self alloc] initWithXCoordinate:x yCoordinate:y];
}

- (Petri2DCoordinates*)rotatedClockwise
{
	return [Petri2DCoordinates coordinatesWithXCoordinate:[self yCoordinate] yCoordinate:-[self xCoordinate]];
}
- (Petri2DCoordinates*)rotatedCounterClockwise
{
	return [Petri2DCoordinates coordinatesWithXCoordinate:-[self yCoordinate] yCoordinate:[self xCoordinate]];
}

@synthesize yCoordinate;
@synthesize xCoordinate;

@end