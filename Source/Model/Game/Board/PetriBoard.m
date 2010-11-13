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
	return [self initWithWidth:10
				  Height:10];
}

- (id)initWithWidth:(NSInteger)Width
			 Height:(NSInteger)Height
{
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:Width];
	for (int i = 0; i < Width; i++)
	{
		NSMutableArray* column = [NSMutableArray arrayWithCapacity:Height];
		for (int j = 0; j < Height; j++)
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
		PetriBoardCell* cell = [self cellAtX:([pieceLocation x] + [cellLocation x])
									 Y:([pieceLocation y] + [cellLocation y])];
		[cell setOwner:player];
		[cell setCellType:bodyCell];
	}
}

- (PetriBoardCell*)cellAtLocation:(PetriBoardLocation*)location
{
	return [self cellAtX:[location x]
                 Y:[location y]];
}

- (PetriBoardCell*)cellAtX:(NSInteger)x
						 Y:(NSInteger)y
{
	return [[cells objectAtIndex:x] objectAtIndex:y];
}

@end
