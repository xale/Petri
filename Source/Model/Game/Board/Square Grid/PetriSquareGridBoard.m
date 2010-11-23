//
//  PetriSquareGridBoard.m
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoard.h"

#import "PetriBoardCell.h"
#import "PetriPiece.h"
#import "Petri2DCoordinates.h"

@implementation PetriSquareGridBoard

- (BOOL)isValidPlacementForPiece:(PetriPiece*)piece
					  atLocation:(Petri2DCoordinates*)location
					  withPlayer:(PetriPlayer*)player
{
	NSSet* cellLocations = [piece cellLocations];
	
	//If any of the cells to be covered by the body are occupied, then we cannot place a piece there
	for (Petri2DCoordinates* location in cellLocations)
	{
		PetriBoardCell* cell = [self cellAtLocation:location];
		
		if ([cell cellType] != unoccupiedCell)
		{
			return FALSE;
		}
	}
	
	//We now check the adjacency of each location and as long as we find one then we can return
	for (Petri2DCoordinates* location in cellLocations)
	{		
		NSSet* adjacencies = [self placementCellsAdjacentToLocation:location];
		
		for (PetriBoardCell* cell in adjacencies)
		{
			if ([cell owner] == player)
			{
				return TRUE;
			}
		}
	}
	
	return false;
}

- (NSSet*)placementCellsAdjacentToLocation:(Petri2DCoordinates*)location
{
	NSMutableSet* adjacentCells = [NSMutableSet set];
	
	//Add and subtract 1 to x and y
	//Throw out negatives or things outside of bounds
	NSInteger x = [location horizontalCoordinate];
	NSInteger y = [location verticalCoordinate];
	
	if ((x - 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:(x - 1) Y:y]];
	}
	if ((x + 1) < width)
	{
		[adjacentCells addObject:[self cellAtX:(x + 1) Y:y]];
	}
	if ((y - 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:x Y:(y - 1)]];
	}
	if ((y + 1) < height)
	{
		[adjacentCells addObject:[self cellAtX:x Y:(y + 1)]];
	}
	
	return [adjacentCells copy];
}

- (NSSet*)capturableCellsAdjacentToLocation:(Petri2DCoordinates*)location
{
	NSMutableSet* adjacentCells = [NSMutableSet set];
	
	//Add and subtract 1 to x and y
	//Throw out negatives or things outside of bounds
	NSInteger x = [location horizontalCoordinate];
	NSInteger y = [location verticalCoordinate];
	
	// Add laterally-adjacent cells
	[adjacentCells unionSet:[self placementCellsAdjacentToLocation:location]];
	
	// Add diagonally-adjacent cells
	if ((x - 1) >= 0 && (y - 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:(x - 1) Y:(y - 1)]];
	}
	if ((x - 1) >= 0 && (y + 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:(x - 1) Y:(y + 1)]];
	}
	if ((x + 1) >= 0 && (y - 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:(x + 1) Y:(y - 1)]];
	}
	if ((x + 1) >= 0 && (y + 1) >= 0)
	{
		[adjacentCells addObject:[self cellAtX:(x - 1) Y:(y - 1)]];
	}	
	
	return [adjacentCells copy];
}

- (void)capture
{
	//TODO: Implement this
}

+ (NSString*)boardType
{
	return @"Square grid";
}

+ (NSInteger)absoluteMinPlayers
{
	return 2;
}

+ (NSInteger)absoluteMaxPlayers
{
	return 4;
}


@end
