//
//  PetriItemIconDisplayTransformer.m
//  Petri
//
//  Created by Alex Heinz on 12/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriItemIconDisplayTransformer.h"

#import "PetriItem.h"

@implementation PetriItemIconDisplayTransformer

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
	return [NSImage class];
}

- (id)transformedValue:(id)value
{
	// Check for nil value (i.e., no item)
	if (value == nil)
		return nil;
	
	// Check that the value to transform is a valid item
	if (![value isKindOfClass:[PetriItem class]])
		return nil;
	
	// Return the item's icon
	return [(PetriItem*)value icon];
}

@end
