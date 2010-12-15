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
#import "PetriPlayer.h"
#import "NSArray+Subranges.h"

@implementation PetriBiteItem

- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer
			   onBoard:(id<PetriBoard>)board
{
	[board forceClearCells:[NSSet setWithArray:cells]];
}

- (BOOL)validateItemOnCells:(NSArray*)cells
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
	NSUInteger numberOfCellsOnBoard = [board countOfCells];
	NSUInteger numberOfCellsControlledByPlayer = [[usingPlayer controlledCells] count];
	double boardProportion = (double)numberOfCellsControlledByPlayer / (double)numberOfCellsOnBoard;
	if (boardProportion >= .12)
	{
		cellsBitten = 2;
	}
	if (boardProportion >= .30)
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
		if ([cell isEmpty])
		{
			return NO;
		}
		
		// One of these cells must be adjacent to the current cell
		NSSet* adjacentCells;
		if (i == 0)
		{
			adjacentCells = [usingPlayer controlledCells];
		}
		else
		{
			adjacentCells = [NSSet setWithObject:[cells objectAtIndex:i - 1]];
		}

		if (![adjacentCells intersectsSet:[board placementCellsAdjacentToCell:cell]])
		{
			return NO;
		}
	}
	return YES;
}

#pragma mark -
#pragma mark Accessors

NSString* const PetriBiteItemName =	@"Bite";

- (NSString*)itemName
{
	return PetriBiteItemName;
}

NSString* const PetriBiteItemIconName =	@"BiteIcon";

- (NSImage*)icon
{
	return [NSImage imageNamed:PetriBiteItemIconName];
}

@end
