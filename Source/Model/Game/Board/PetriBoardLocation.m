//
//  PetriBoardLocation.m
//  Petri
//
//  Created by Paul Martin on 10/11/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardLocation.h"


@implementation PetriBoardLocation

- (id)initWithX:(NSInteger)locX
			  Y:(NSInteger)locY
{
	x = locX;
	y = locY;
	return self;
}

+ (PetriBoardLocation*)locationWithX:(NSInteger)x
								   Y:(NSInteger)y
{
	return [[self alloc] initWithX:x Y:y];
}

- (PetriBoardLocation*)locationRotatedClockwiseAboutOrigin
{
	return [[PetriBoardLocation alloc] initWithX:[self y] Y:-[self x]];
}

- (PetriBoardLocation*)locationRotatedCounterclockwiseAboutOrigin
{
	return [[PetriBoardLocation alloc] initWithX:-[self y] Y:[self x]];
}

@synthesize x;
@synthesize y;

@end
