//
//  PetriItem.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriItem.h"

@implementation PetriItem

- (id)copyWithZone:(NSZone*)zone
{
	// FIXME: needs a proper override
	return [[[self class] allocWithZone:zone] init];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToItem:(PetriItem*)object];
}

- (BOOL)isEqualToItem:(PetriItem*)item
{
	// FIXME: needs a proper implementation
	return YES;
}

- (NSUInteger)hash
{
	// FIXME: needs a proper implementation
	return 0;
}

@end
