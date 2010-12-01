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
	
	/* FIXME: TESTING
	// Create a filter for the cell's color
	CIFilter* playerColorFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
	[playerColorFilter setDefaults];
	[playerColorFilter setValue:[CIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]
						 forKey:kCIInputColorKey];
	[playerColorFilter setName:@"playerColor"];
	[playerColorFilter setEnabled:YES];
	
	// Add the filter to the background
	[self setBackgroundFilters:[NSArray arrayWithObject:playerColorFilter]];
	
	// Bind the color of the filter to the cell's owner's color
	[self bind:[NSString stringWithFormat:@"backgroundFilters.%@.%@", [playerColorFilter name], kCIInputColorKey]
	  toObject:displayedCell
   withKeyPath:@"owner"
	   options:[NSDictionary dictionaryWithObject:[PetriPlayerColorValueTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	*/
	
	// FIXME: additional bindings
	
	// FIXME: TESTING: add a background for visibility
	[self setBackgroundColor:CGColorCreateGenericRGB(0.8, 0.8, 0.8, 1.0)];
	
	cell = displayedCell;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

// FIXME: testing purposes only
- (void)setValue:(id)value
		  forKey:(NSString*)key
{
	if ([key isEqualToString:@"backgroundColor"] && [value isKindOfClass:[CIColor class]])
	{
		CIColor* colorValue = (CIColor*)value;
		CGColorRef color = CGColorCreateGenericRGB([colorValue red], [colorValue green], [colorValue blue], [colorValue alpha]);
		[self setBackgroundColor:color];
		return;
	}
	
	[super setValue:value
			 forKey:key];
}

@synthesize cell;

@end
