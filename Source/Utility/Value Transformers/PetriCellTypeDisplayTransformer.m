//
//  PetriCellTypeDisplayTransformer.m
//  Petri
//
//  Created by Alex Heinz on 12/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriCellTypeDisplayTransformer.h"

#import "PetriCellType.h"

@implementation PetriCellTypeDisplayTransformer

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
	return [NSNumber class];
}

- (id)transformedValue:(id)value
{
	// Check for nil value (i.e., no cell)
	if (value == nil)
		return [NSNumber numberWithFloat:0.0f];
	
	// Check that the value to transform is a valid cell type
	if (![value isKindOfClass:[NSNumber class]])
		return [NSNumber numberWithFloat:0.0f];
	
	// Determine the type of cell
	switch ([value intValue])
	{
		case unoccupiedCell:
		case bodyCell:
			return [NSNumber numberWithFloat:1.0f];
			
		case headCell:
			return [NSNumber numberWithFloat:0.5f];
			
		case invalidCell:
			break;
	}
	
	return [NSNumber numberWithFloat:0.0f];
}

@end
