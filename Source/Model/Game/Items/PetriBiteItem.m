//
//  PetriBiteItem.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/11/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBiteItem.h"
#import "PetriBoardCell.h"
#import "PetriBoard.h"
#import "NSArray+Subranges.h"

@implementation PetriBiteItem

- (id)init
{
	itemName = @"Bite";
	allowsCaptures = NO;
}

- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer
			   onBoard:(id<PetriBoard>)board
{
	for (PetriBoardCell* cell in cells)
	{
		[usingPlayer removeControlledCellsObject:cell];
		[cell clearCell];
	}
}

- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer
			   onBoard:(id<PetriBoard>)board
{
	if (cells == nil || [cells count] == 0)
	{
		return NO;
	}
	// FIXME: this bite hardcodes values
	
	NSUInteger cellsBitten = 1;
	if ([[usingPlayer controlledCells] count] > 20)
	{
		cellsBitten = 2;
	}
	else if ([[usingPlayer controlledCells] count] > 35)
	{
		cellsBitten = 3;
	}
	if ([cells count] > cellsBitten)
	{
		return NO;
	}
	
	for (NSUInteger i = 0; i < [cells count]; i++)
	{
		PetriBoardCell* cell = [cells objectAtIndex:i];

		if ([[cell owner] isEqual:usingPlayer])
		{
			return NO;
		}
		
		if (![board placementCellsAdjacentToCell:cell] intersectsSet:[[usingPlayer controlledCells] unionSet:[NSSet setWithArray:[cells subarrayToIndex:i]]])
		{
			return NO;
		}
	}
	return YES;
}

@end
