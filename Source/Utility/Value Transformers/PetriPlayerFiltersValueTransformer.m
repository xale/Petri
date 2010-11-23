//
//  PetriPlayerFiltersValueTransformer.m
//  Petri
//
//  Created by Alex Heinz on 11/22/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayerFiltersValueTransformer.h"

#import "PetriPlayer.h"

@implementation PetriPlayerFiltersValueTransformer

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
	return [NSArray class];
}

- (id)transformedValue:(id)value
{
	// Check that the value to transform is a valid player
	if (![value isKindOfClass:[PetriPlayer class]])
		return nil;
	
	PetriPlayer* playerValue = (PetriPlayer*)value;
	
	// Create a colorizing filter based on the player's color
	NSColor* playerColor = [playerValue color];
	
	// Convert to a CIColor (this is just silly...)
	// FIXME: color spaces? e.g., CGColorCreateWithName([playerColor colorSpaceName])
	CIColor* filterColor = [CIColor colorWithRed:[playerColor redComponent]
										   green:[playerColor greenComponent]
											blue:[playerColor blueComponent]
										   alpha:[playerColor alphaComponent]];
	
	// Create the filter
	CIFilter* filter = [CIFilter filterWithName:@"CIColorMonochrome"];
	[filter setDefaults];
	[filter setValue:filterColor
			  forKey:@"inputColor"];
	
	return [NSArray arrayWithObject:filter];
}

@end
