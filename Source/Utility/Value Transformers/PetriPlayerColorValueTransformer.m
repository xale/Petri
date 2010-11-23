//
//  PetriPlayerFiltersValueTransformer.m
//  Petri
//
//  Created by Alex Heinz on 11/22/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayerColorValueTransformer.h"

#import "PetriPlayer.h"

@implementation PetriPlayerColorValueTransformer

+ (id)valueTransformer
{
	return [[self alloc] init];
}

+ (BOOL)allowsReverseTransformation
{
	return NO;
}

+ (Class)transformedValueClass
{
	return [CIColor class];
}

- (id)transformedValue:(id)value
{
	// Check that the value to transform is a valid player
	if (![value isKindOfClass:[PetriPlayer class]])
		return [CIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	
	PetriPlayer* playerValue = (PetriPlayer*)value;
	
	// Get the player's color
	NSColor* playerColor = [playerValue color];
	
	// Convert to a CIColor (this is just silly...)
	// FIXME: color spaces? e.g., CGColorCreateWithName([playerColor colorSpaceName])
	return [CIColor colorWithRed:[playerColor redComponent]
						   green:[playerColor greenComponent]
							blue:[playerColor blueComponent]
						   alpha:[playerColor alphaComponent]];
}

@end
