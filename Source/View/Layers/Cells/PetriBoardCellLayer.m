//
//  PetriBoardCellLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCellLayer.h"

#import "PetriBoardCell.h"

#import "PetriPlayerColorValueTransformer.h"
#import "PetriCellTypeDisplayTransformer.h"

@implementation PetriBoardCellLayer

+ (id)boardCellLayerForCell:(PetriBoardCell*)displayedCell
{
	return [[self alloc] initWithCell:displayedCell];
}

- (id)initWithCell:(PetriBoardCell*)displayedCell
{
	if (![super init])
		return nil;
	
	// FIXME: TESTING Bind the background color to the owner's color
	[self bind:@"backgroundColor"
	  toObject:displayedCell
   withKeyPath:@"owner"
	   options:[NSDictionary dictionaryWithObject:[PetriPlayerColorValueTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	
	// FIXME: TESTING: Bind the layer's opacity to the cell's type
	[self bind:@"opacity"
	  toObject:displayedCell
   withKeyPath:@"cellType"
	   options:[NSDictionary dictionaryWithObject:[PetriCellTypeDisplayTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	
	// FIXME: additional bindings
	
	// Disable edge antialiasing, since theses layers will abut one another, and antialiasing may create artifacts
	[self setEdgeAntialiasingMask:0];
	
	cell = displayedCell;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

// FIXME: testing purposes only
- (void)setValue:(id)value
		  forKey:(NSString*)key
{
	// Check for the backgroundColor key, since we need to convert from a CIColor to a CGColor
	if ([key isEqualToString:@"backgroundColor"] && [value isKindOfClass:[CIColor class]])
	{
		CIColor* colorValue = (CIColor*)value;
		CGColorRef color = CGColorCreateGenericRGB([colorValue red], [colorValue green], [colorValue blue], 1.0);
		[self setBackgroundColor:color];
		CGColorRelease(color);
		return;
	}
	
	[super setValue:value
			 forKey:key];
}

@synthesize cell;

@end
