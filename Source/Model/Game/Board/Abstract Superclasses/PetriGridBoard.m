//
//  PetriGridBoard.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoard.h"
#import "PetriBoardCell.h"
#import "Petri2DCoordinates.h"
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
	// Check that we aren't instantiating an abstract class
	if ([self isMemberOfClass:[PetriGridBoard class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// Create the two-dimensional array of board cells
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:boardWidth];
	
	for (NSInteger x = 0; x < boardWidth; x++)
	{
		NSMutableArray* column = [NSMutableArray arrayWithCapacity:boardHeight];
		
		for (NSInteger y = 0; y < boardHeight; y++)
		{
			[column addObject:[[PetriBoardCell alloc] init]];
		}
		
		[tempBoard addObject:[column copy]];
	}
	
	// Assign to local ivar
	cells = [tempBoard copy];
	
	width = boardWidth;
	height = boardHeight;
	
	return self;
}

- (void)placePiece:(PetriPiece*)piece
		 withOwner:(PetriPlayer*)player
	 atCoordinates:(Petri2DCoordinates*)pieceOrigin
{
	// Iterate over cell-offsets in the piece
	for (Petri2DCoordinates* cellOffset in [piece cellCoordinates])
	{
		// Find the cell located at (piece origin) + (cell offset)
		PetriBoardCell* cell = [self cellAtCoordinates:[pieceOrigin offsetCoordinates:cellOffset]];
		
		// Create a body cell for the piece's owner
		[cell setOwner:player];
		[cell setCellType:bodyCell];
	}
}

- (BOOL)validatePlacementOfPiece:(PetriPiece*)piece
					   withOwner:(PetriPlayer*)pieceOwner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin
{
	[self doesNotRecognizeSelector:_cmd];
	return FALSE;
}

- (PetriBoardCell*)cellAtCoordinates:(Petri2DCoordinates*)coordinates
{
	return [self cellAtX:[coordinates xCoordinate]
					   Y:[coordinates yCoordinate]];
}

- (PetriBoardCell*)cellAtX:(NSInteger)x
						 Y:(NSInteger)y
{
	return [[cells objectAtIndex:x] objectAtIndex:y];
}

- (Petri2DCoordinates*)coordinatesOfCell:(PetriBoardCell*)cell
{
	for (int i = 0; i < width; i++)
	{
		for (int j = 0; j < height; j++)
		{
			if ([[self cellAtX:i Y:j] isEqual:cell])
			{
				return [Petri2DCoordinates coordinatesWithXCoordinate:i
														  yCoordinate:j];
			}
		}
	}
	
	return nil;
}

- (NSSet*)placementCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (NSSet*)capturableCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (void)capture
{
	[self doesNotRecognizeSelector:_cmd];
}

+ (NSString*)boardType
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

+ (NSInteger)absoluteMinPlayers
{
	[self doesNotRecognizeSelector:_cmd];
	return -1;
}

+ (NSInteger)absoluteMaxPlayers
{
	[self doesNotRecognizeSelector:_cmd];
	return -1;
}

@synthesize width;
@synthesize height;

@end
