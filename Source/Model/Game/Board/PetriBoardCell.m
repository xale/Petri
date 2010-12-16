//
//  PetriBoardCell.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCell.h"
#import "PetriPlayer.h"

@implementation PetriBoardCell

- (id)initWithCellID:(NSInteger)ID;
{
	return [self initWithCellType:unoccupiedCell
							owner:nil
						   pickUp:nil
						   cellID:ID];
}

- (id)initWithCellType:(PetriCellType)type
				 owner:(PetriPlayer*)player
				pickUp:(PetriItem*)item
				cellID:(NSInteger)ID
{
	cellType = type;
	owner = player;
	pickUp = [item copy];
	cellID = ID;
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithCellType:[self cellType]
														 owner:[self owner]
														pickUp:[self pickUp]
														cellID:[self cellID]];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)otherObject
{
	if ([otherObject isKindOfClass:[self class]])
	{
		return [self isEqualToCell:(PetriBoardCell*)otherObject];
	}
	
	return NO;
}

- (NSUInteger)hash
{
	return (NSUInteger)[self cellID];
}

- (BOOL)isEqualToCell:(PetriBoardCell*)otherCell
{
	return ([self cellID] == [otherCell cellID]);
}

- (BOOL)hasSamePropertiesAsCell:(PetriBoardCell*)otherCell
{
	return (([self cellType] == [otherCell cellType]) &&
			(([self owner] == [otherCell owner]) || [[self owner] isEqual:[otherCell owner]]) &&
			(([self pickUp] == [otherCell pickUp]) || [[self pickUp] isEqual:[otherCell pickUp]]));
}

#pragma mark -
#pragma mark Accessors

- (void)clearCell
{
	[self setCellType:unoccupiedCell];
	[self setOwner:nil];
	[self setPickUp:nil];
}

- (void)takeCellForPlayer:(PetriPlayer*)player
{
	if ([self pickUp] != nil)
	{
		[player addItemsObject:[self pickUp]];
		NSLog(@"Taking item %@ for player %@.", pickUp, player);
	}
	[self setCellType:bodyCell];
	[self setOwner:player];
	[self setPickUp:nil];
}

- (BOOL)isEmpty
{
	if ([self cellType] == unoccupiedCell && [self owner] == nil)
	{
		return YES;
	}
	if ([self cellType] != unoccupiedCell && [self owner] != nil)
	{
		return NO;
	}
	@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Schrodinger's cell: it is both empty and not empty." userInfo:nil];
}

@synthesize cellType;
@synthesize owner;
@synthesize pickUp;
@synthesize cellID;

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@: type %d; owner: %@; pickup: %@", [super description], [self cellType], [self owner], [self pickUp]];
}

- (void)encodeWithCoder:(NSCoder*)coder
{
	[coder encodeInteger:[self cellID]
				  forKey:@"cellID"];
}

- (id)initWithCoder:(NSCoder*)coder
{
	return [self initWithCellID:[coder decodeIntegerForKey:@"cellID"]];
}

@end
