//
//  PetriBoardCell.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCell.h"

@implementation PetriBoardCell

- (id)init
{
	cellType = unoccupiedCell;
	owner = nil;
	pickUp = nil;
	return self;
}

- (id)initWithCellType:(PetriCellType)type
				 owner:(PetriPlayer*)player
				pickUp:(PetriItem*)item
{
	cellType = type;
	owner = player;
	pickUp = [item copy];
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithCellType:[self cellType]
														 owner:[self owner]
														pickUp:[self pickUp]];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToCell:(PetriBoardCell*)object];
}

- (BOOL)isEqualToCell:(PetriBoardCell*)cell
{
	// Compare the type of cell
	if ([self cellType] != [cell cellType])
		return NO;
	
	// Compare owners
	if ((([self owner] != nil) || ([cell owner] != nil)) && ![[self owner] isEqual:[cell owner]])
		return NO;
	
	// Compare items
	if ((([self pickUp] != nil) || ([cell pickUp] != nil)) && ![[self pickUp] isEqual:[cell pickUp]])
		return NO;
	
	return YES;
}

- (NSUInteger)hash
{
	return (cellType * 7) + ([owner hash] * 5) + ([pickUp hash] * 3);
}

#pragma mark -
#pragma mark Accessors

@synthesize cellType;
@synthesize owner;
@synthesize pickUp;

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@: type %d; owner: %@; pickup: %@", [super description], [self cellType], [self owner], [self pickUp]];
}

@end
