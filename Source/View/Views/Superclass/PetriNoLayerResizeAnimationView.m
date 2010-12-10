//
//  PetriNoLayerResizeAnimationView.m
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"


@implementation PetriNoLayerResizeAnimationView

#pragma mark -
#pragma mark Accessors

- (void)setFrame:(NSRect)frameRect
{
	// Batch CALayer resize operations into a non-animating transaction
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	[super setFrame:frameRect];
	
	// End the transaction
	[CATransaction commit];
}

@end
