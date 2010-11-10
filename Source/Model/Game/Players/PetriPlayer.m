//
//  PetriPlayer.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer.h"


@implementation PetriPlayer

/*!
 Throws an exception.
 */
- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

#pragma mark -
#pragma mark Accessors

- (void)addControlledCellsObject:(PetriBoardCell*)cell
{
	[controlledCells addObject:cell];
}

- (NSInteger)countOfControlledCells
{
	return [controlledCells count];
}

- (NSDictionary*)items
{
	return [items copy];
}

// TODO: write unit test for add/remove items

- (void)addItemsObject:(PetriItem*)item
{
	[self willChangeValueForKey:@"item"];
	
	NSNumber* count = [items objectForKey:item]
	if (count == nil)
	{
		[items setObject:item forKey:[NSNumber numberWithInt:1]];
	}
	[items setObject:item forKey:[NSNumber numberWithInt:[[count intValue] + 1]]];
	
	[self didChangeValueForKey:@"item"];
}

- (void)removeItemsObject:(PetriItem*)item
{
	[self willChangeValueForKey:@"item"];
	
	NSNumber* count = [items objectForKey:item]
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
	[items setObject:item forKey:[NSNumber numberWithInt:[[count intValue] - 1]]];

	[self didChangeValueForKey:@"item"];
}

@end
