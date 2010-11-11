//
//  PetriBoard.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoard.h"
#import "PetriBoardCell.h"
#import "PetriBoardLocation.h"
#import "PetriPiece.h"

@implementation PetriBoard

- (id)init
{
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:10];
	for (int i = 0; i < 10; i++)
	{
		NSMutableArray* column = [NSMutableArray arrayWithCapacity:10];
		for (int j = 0; j < 10; j++)
		{
			[column addObject:[[PetriBoardCell alloc] init]];
		}
		[tempBoard addObject:[column copy]];
	}
	
	cells = [tempBoard copy];
	
	return self;
}

- (void)placePiece:(PetriPiece*)piece
		atLocation:(PetriBoardLocation*)cellLocation
		 withOwner:(PetriPlayer*)player
{
	for (PetriBoardLocation* pieceLocation in [piece cellLocations])
	{
		PetriBoardCell* cell = [[cells objectAtIndex:([pieceLocation x] + [cellLocation x])] objectAtIndex:([pieceLocation y] + [cellLocation y])];
		[cell setOwner:player];
		[cell setCellType:bodyCell];
	}
	
}

@end
