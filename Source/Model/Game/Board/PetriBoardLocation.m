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


@synthesize x;
@synthesize y;

@end
