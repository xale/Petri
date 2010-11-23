//
//  PetriBoardCellLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCellLayer.h"

#import "PetriBoardCell.h"

#import "PetriPlayerFiltersValueTransformer.h"

@implementation PetriBoardCellLayer

+ (id)boardCellLayerBoundToCell:(PetriBoardCell*)displayedCell
{
	return [[self alloc] initBoundToCell:displayedCell];
}

- (id)initBoundToCell:(PetriBoardCell*)displayedCell
{
	if (![super init])
		return nil;
	
	// Bind the color of the layer to the cell's owner, using filters
	[self bind:@"filters"
	  toObject:displayedCell
   withKeyPath:@"owner"
	   options:[NSDictionary dictionaryWithObject:[PetriPlayerFiltersValueTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	
	// FIXME: additional bindings
	
	// FIXME: TESTING: add a background for visibility
	[self setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize cell;

@end
