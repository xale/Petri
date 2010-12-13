//
//  PetriPlayer.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer.h"
@class PetriItem;

// FIXME: TESTING
#import "PetriBiteItem.h"
// FIXME: TESTING

@implementation PetriPlayer

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithColor:(NSColor*)playerColor
{
	if ([self isMemberOfClass:[PetriPlayer class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// FIXME: TESTING
	items = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:4]
											   forKey:[PetriBiteItem item]];
	// FIXME: TESTING
	
	controlledCells = [NSMutableSet set];
	color = [playerColor copy];
	return self;
}

#pragma mark -
#pragma mark Accessors

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
		[items setObject:item forKey:[NSNumber numberWithInt:1]];
	}
	[items setObject:item forKey:[NSNumber numberWithInt:([count intValue] + 1)]];
	
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
		[items removeObjectForKey:count];
		return;
	}
	[items setObject:item forKey:[NSNumber numberWithInt:([count intValue] - 1)]];

	[self didChangeValueForKey:@"items"];
}

- (NSSet*)controlledCells
{
	return [controlledCells copy];
}

@synthesize color;

@end
