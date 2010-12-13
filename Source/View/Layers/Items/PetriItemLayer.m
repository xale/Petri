//
//  PetriItemLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriItemLayer.h"

#import "PetriItem.h"

#define PetriItemLayerBorderWidth	1.5
#define PetriItemLayerOpacity		0.80

@implementation PetriItemLayer

+ (id)itemLayerForItem:(PetriItem*)displayedItem
{
	return [[self alloc] initWithItem:displayedItem];
}

- (id)initWithItem:(PetriItem*)displayedItem
{
	// Initialize the layer with a square aspect ratio
	if (![super initWithSquareAspectRatio])
		return nil;
	
	// Get the image to display from the item
	[self setContents:[displayedItem icon]];
	[self setContentsGravity:kCAGravityResizeAspect];
	
	// Create a thin white border
	[self setBorderColor:CGColorGetConstantColor(kCGColorWhite)];
	[self setBorderWidth:PetriItemLayerBorderWidth];
	
	// Make the layer semitransparent black
	[self setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];
	[self setOpacity:PetriItemLayerOpacity];
	
	// Maintain a reference to the item
	item = displayedItem;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize item;

- (void)setHighlighted:(BOOL)isHighlighted
{
	// If the item is highlighted, draw a highlight
	if (isHighlighted)
	{
		CGColorRef highlightColor = CGColorCreateGenericRGB(0.0, 0.6, 0.0, 1.0);
		[self setBackgroundColor:highlightColor];
		CGColorRelease(highlightColor);
	}
	else
	{
		[self setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];
	}
	
	highlighted = isHighlighted;
}
@synthesize highlighted;

@end
