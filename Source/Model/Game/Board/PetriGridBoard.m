//
//  PetriGridBoard.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoard.h"
#import "PetriGridBoard.h"
#import "PetriBoardCell.h"
#import "PetriBoardLocation.h"
#import "PetriPiece.h"

@implementation PetriGridBoard

- (id)init
{
	return [self initWithWidth:10
						height:10];
}

- (id)initWithWidth:(NSInteger)boardWidth
			 height:(NSInteger)boardHeight
{
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:boardWidth];
	for (int i = 0; i < boardWidth; i++)
	{
		NSMutableArray* column = [NSMutableArray arrayWithCapacity:boardHeight];
		for (int j = 0; j < boardHeight; j++)
		{
			[column addObject:[[PetriBoardCell alloc] init]];
		}
		[tempBoard addObject:[column copy]];
	}
	
	cells = [tempBoard copy];
	
	width = boardWidth;
	height = boardHeight;
	
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

@synthesize width;
@synthesize height;

@end
