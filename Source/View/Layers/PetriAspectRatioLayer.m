//
//  PetriSquareLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"


@implementation PetriAspectRatioLayer

- (id)initWithAspectRatio:(CGFloat)ratio
{
	if (![super init])
		return nil;
	
	aspectRatio = ratio;
	
	return self;
}

+ (id)layerWithAspectRatio:(CGFloat)ratio
{
	return [[self alloc] initWithAspectRatio:ratio];
}

- (id)initWithSquareAspectRatio
{
	return [self initWithAspectRatio:1.0];
}

+ (id)squareLayer
{
	return [[self alloc] initWithSquareAspectRatio];
}

#pragma mark -
#pragma mark Accessors

- (void)setBounds:(CGRect)newBounds
{
	if (newBounds.size.width > (newBounds.size.height * [self aspectRatio]))
	{
		newBounds.size.width = (newBounds.size.height * [self aspectRatio]);
	}
	else if (newBounds.size.width < (newBounds.size.height * [self aspectRatio]))
	{
		newBounds.size.height = (newBounds.size.width / [self aspectRatio]);
	}
	
	[super setBounds:newBounds];
}

@synthesize aspectRatio;

@end
