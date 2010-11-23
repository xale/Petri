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
	NSInteger x = [location xCoordinate];
	NSInteger y = [location yCoordinate];
	
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
	NSInteger x = [location xCoordinate];
	NSInteger y = [location yCoordinate];
	
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
	BOOL captures;
	
	do
	{
		captures = FALSE;
		//Check all rows
		for (int i = 0; i < height; i++)
		{
			for (int j = 0; i < width; j++)
			{
				Petri2DCoordinates* currentCoordinates = [Petri2DCoordinates coordinatesWithXCoordinate:i
																				   yCoordinate:j];
				PetriBoardCell* current = [self cellAtX:i Y:j];
				if ([current cellType] != unoccupiedCell)
				{
					//Iterate over all adjacent cells
					for (PetriBoardCell* cell in [self capturableCellsAdjacentToLocation:currentCoordinates])
					{
						//If we find an adjacent cell with a different player's piece
						if ([cell cellType] != unoccupiedCell && [cell owner] != [current owner])
						{
							NSMutableSet* capturableCells = [[NSMutableSet alloc] init];
							
							NSInteger currentX = [[self coordinatesOfCell:current] xCoordinate];
							NSInteger cellX = [[self coordinatesOfCell:cell] xCoordinate];
							
							NSInteger currentY = [[self coordinatesOfCell:current] yCoordinate];
							NSInteger cellY = [[self coordinatesOfCell:cell] yCoordinate];
							
							NSInteger deltaX = currentX - cellX;
							NSInteger deltaY = currentY - cellY;
							
							for (int q = currentX; (q >= 0 && q < width); q += deltaX)
							{
								for (int r = currentY; (r >= 0 && r < height); r += deltaY)
								{
									PetriBoardCell* iteratedCell = [self cellAtX:q Y:r];
									
									//If we run into our own piece again in the same direction before hitting a null cell
									if ([iteratedCell cellType] == [current cellType])
									{
										//Delete cells in between
										for (PetriBoardCell* cell in capturableCells)
										{
											[cell setOwner:nil];
											[cell setCellType:unoccupiedCell];
										}
										//Set captures to true
										captures = TRUE;
										
										//clear board
										[self clearBoard];
									}
									else if ([iteratedCell cellType] != unoccupiedCell)
									{
										//Add to set
										[capturableCells addObject:iteratedCell];
									}
									else //break out of these loops, we didn't find a capture
									{
										goto emptyCellFound;
									}
								}
							}
						}
						emptyCellFound:;
					}
				}
			}
		}
	} while (captures == TRUE);
}

- (void)clearBoard
{
	
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
