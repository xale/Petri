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
	return [[[self class] allocWithZone:zone] initWithName:[self name]
												 validator:validator
												 performer:performer
										  allowingCaptures:allowingCaptures];
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
	return [[self itemName] isEqual:[item itemName]];
}

- (NSUInteger)hash
{
	return [[self itemName] hash];
}

@end
