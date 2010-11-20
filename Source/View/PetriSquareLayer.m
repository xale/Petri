//
//  PetriSquareLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareLayer.h"


@implementation PetriSquareLayer

#pragma mark -
#pragma mark Accessors

- (void)setBounds:(CGRect)newBounds
{
	// Keep the board square
	CGFloat newSize = MIN(newBounds.size.width, newBounds.size.height);
	newBounds.size.width = newSize;
	newBounds.size.height = newSize;
	
	[super setBounds:newBounds];
}

@end
