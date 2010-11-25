//
//  Petri2DCoordinates.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "Petri2DCoordinates.h"


@implementation Petri2DCoordinates

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

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

#pragma mark -
#pragma mark Offsets

- (Petri2DCoordinates*)offsetCoordinates:(Petri2DCoordinates*)offset
{
	return [self offsetCoordinatesByX:[offset xCoordinate]
									Y:[offset yCoordinate]];
}

- (Petri2DCoordinates*)offsetCoordinatesByX:(NSInteger)xOffset Y:(NSInteger)yOffset
{
	return [[self class] coordinatesWithXCoordinate:([self xCoordinate] + xOffset)
										yCoordinate:([self yCoordinate] + yOffset)];
}

#pragma mark -
#pragma mark Rotations

- (Petri2DCoordinates*)rotatedClockwiseAboutOrigin
{
	return [[self class] coordinatesWithXCoordinate:[self yCoordinate] yCoordinate:-[self xCoordinate]];
}
- (Petri2DCoordinates*)rotatedCounterclockwiseAboutOrigin
{
	return [[self class] coordinatesWithXCoordinate:-[self yCoordinate] yCoordinate:[self xCoordinate]];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToCoordinates:(Petri2DCoordinates*)object];
}

- (BOOL)isEqualToCoordinates:(Petri2DCoordinates*)coordinates
{
	return (([self xCoordinate] == [coordinates xCoordinate]) &&
			([self yCoordinate] == [coordinates yCoordinate]));
}

- (NSUInteger)hash
{
	return [[self description] hash];
}

#pragma mark -
#pragma mark Accessors

@synthesize yCoordinate;
@synthesize xCoordinate;

- (NSString*)description
{
	return [NSString stringWithFormat:@"(%d, %d)", [self xCoordinate], [self yCoordinate]];
}

@end
