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

- (BOOL)hasSamePropertiesAsCell:(PetriBoardCell*)otherCell
{
	return (([self cellType] == [otherCell cellType]) &&
			(([self owner] == [otherCell owner]) || [[self owner] isEqual:[otherCell owner]]) &&
			(([self pickUp] == [otherCell pickUp]) || [[self pickUp] isEqual:[otherCell pickUp]]));
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
