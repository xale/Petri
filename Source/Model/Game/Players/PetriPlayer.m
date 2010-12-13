//
//  PetriPlayer.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer.h"
@class PetriItem;

@implementation PetriPlayer

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithPlayerID:(NSInteger)ID
				 color:(NSColor*)playerColor
{
	if ([self isMemberOfClass:[PetriPlayer class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	playerID = ID;
	items = [NSMutableDictionary dictionary];
	controlledCells = [NSMutableSet set];
	color = [playerColor copy];
	return self;
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeInteger:playerID forKey:@"playerID"];
	[coder encodeObject:color forKey: @"color"];
}

- (id)initWithCoder:(NSCoder *)coder
{
	return [self initWithPlayerID:[coder decodeIntegerForKey:@"playerID"]
							color:[coder decodeObjectForKey:@"color"]];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)otherObject
{
	if ([otherObject isKindOfClass:[self class]])
	{
		return [self isEqualToPlayer:(PetriPlayer*)otherObject];
	}
	
	return NO;
}

- (NSUInteger)hash
{
	return (NSUInteger)[self playerID];
}

- (BOOL)isEqualToPlayer:(PetriPlayer*)otherPlayer
{
	return ([self playerID] == [otherPlayer playerID]);
}

#pragma mark -
#pragma mark Accessors

#pragma mark Cells

- (void)addControlledCellsObject:(PetriBoardCell*)cell
{
	[self willChangeValueForKey:@"controlledCells"];
	[controlledCells addObject:cell];
	[self didChangeValueForKey:@"controlledCells"];
}

- (void)addControlledCells:(NSSet*)cells
{
	[self willChangeValueForKey:@"controlledCells"];
	[controlledCells unionSet:cells];
	[self didChangeValueForKey:@"controlledCells"];
}

- (void)removeControlledCellsObject:(PetriBoardCell*)cell
{
	[self willChangeValueForKey:@"controlledCells"];
	[controlledCells removeObject:cell];
	[self didChangeValueForKey:@"controlledCells"];
}

- (void)removeControlledCells:(NSSet*)cells;
{
	[self willChangeValueForKey:@"controlledCells"];
	[controlledCells minusSet:cells];
	[self didChangeValueForKey:@"controlledCells"];
}
- (NSUInteger)countOfControlledCells
{
	return [controlledCells count];
}

- (NSEnumerator*)enumeratorOfControlledCells
{
	return [controlledCells objectEnumerator];
}

- (PetriBoardCell*)memberOfControlledCells:(PetriBoardCell*)cell
{
    return [controlledCells member:cell];
}

- (NSSet*)controlledCells
{
	return [controlledCells copy];
}

#pragma mark Items

- (NSDictionary*)items
{
	return [items copy];
}

- (void)addItemsObject:(PetriItem*)item
{
	[self willChangeValueForKey:@"items"];
	
	NSNumber* count = [items objectForKey:item];
	if (count == nil)
	{
		[items setObject:[NSNumber numberWithInt:1] forKey:item];
	}
	[items setObject:[NSNumber numberWithInt:([count intValue] + 1)] forKey:item];
	
	[self didChangeValueForKey:@"items"];
}

- (void)removeItemsObject:(PetriItem*)item
{
	[self willChangeValueForKey:@"items"];
	
	NSNumber* count = [items objectForKey:item];
	if (count == nil)
	{
		@throw [NSException exceptionWithName:@"ItemRemoveException"
									   reason:@"Attempt to remove item not in dictionary."
									 userInfo:nil];
	}
	
	if ([count intValue] == 1)
	{
		[items removeObjectForKey:item];
		return;
	}
	[items setObject:[NSNumber numberWithInt:([count intValue] - 1)] forKey:item];

	[self didChangeValueForKey:@"items"];
}

#pragma mark Others

@synthesize color;
@synthesize playerID;

@end
