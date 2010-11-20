//
//  PetriNoLayerResizeAnimationView.m
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"


@implementation PetriNoLayerResizeAnimationView

- (void)setFrame:(NSRect)frameRect
{
	// Check if this resize is being performed while the view is visible
	if ([self inLiveResize])
	{
		// Batch CALayer resize operations into a non-animating transaction
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
	}
	
	[super setFrame:frameRect];
	
	if ([self inLiveResize])
	{
		// End the transaction
		[CATransaction commit];
	}
}

@end
