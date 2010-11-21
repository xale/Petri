//
//  PetriSquareGridBoard.m
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCell.h"
#import "PetriCellType.h"
#import "PetriGridBoard.h"
#import "PetriPiece.h"
#import "PetriSquareGridBoard.h"


@implementation PetriSquareGridBoard

- (id)init
{
	return [super init];
}

- (id)initWithWidth:(NSInteger)boardWidth
			 Height:(NSInteger)boardHeight
{
	return [super initWithWidth:boardWidth height:boardHeight];
}

- (BOOL)isValidPlacementForPiece:(PetriPiece*)piece
					  atLocation:(PetriBoardLocation*)location
					  withPlayer:(PetriPlayer*)player
{
	NSSet* cellLocations = [piece cellLocations];
	
	//If any of the cells to be covered by the body are occupied, then we cannot place a piece there
	for (PetriBoardLocation* location in cellLocations)
	{
		PetriBoardCell* cell = [self cellAtLocation:location];
		
		if ([cell cellType] != unoccupiedCell)
		{
			return FALSE;
		}
	}
	
	//We now check the adjacency of each location and as long as we find one then we can return
	for (PetriBoardLocation* location in cellLocations)
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

@end
