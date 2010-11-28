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

/*!
 Override. Throws an exception.
 */
- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
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
	NSMutableArray* column = nil;
	for (NSInteger x = 0; x < boardWidth; x++)
	{
		column = [NSMutableArray arrayWithCapacity:boardHeight];
		
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

- (id)initWithGridBoard:(PetriGridBoard*)board
{
	// Check that we aren't instantiating an abstract class
	if ([self isMemberOfClass:[PetriGridBoard class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// Copy the other board's size
	width = [board width];
	height = [board height];
	
	// Copy cells from the other board
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:width];
	NSMutableArray* column = nil;
	for (NSInteger x = 0; x < width; x++)
	{
		// Fill the board column-by-column
		column = [NSMutableArray arrayWithCapacity:height];
		for (NSInteger y = 0; y < height; y++)
		{
			[column addObject:[[board cellAtX:x Y:y] copy]];
		}
		[tempBoard addObject:column];
	}
	cells = [tempBoard copy]; // Shallow copy, does not copy cells redundantly
	
	return self;
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithGridBoard:self];
}

#pragma mark -
#pragma mark Piece Placement

- (void)placePiece:(PetriPiece*)piece
		 withOwner:(PetriPlayer*)owner
			onCell:(PetriBoardCell*)cell
{
	return [self placePiece:piece
				  withOwner:owner
			  atCoordinates:[self coordinatesOfCell:cell]];
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
					   withOwner:(PetriPlayer*)owner
						  onCell:(PetriBoardCell*)cell
{
	return [self validatePlacementOfPiece:piece
								withOwner:owner
							atCoordinates:[self coordinatesOfCell:cell]];
}

- (BOOL)validatePlacementOfPiece:(PetriPiece*)piece
					   withOwner:(PetriPlayer*)pieceOwner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin
{
	[self doesNotRecognizeSelector:_cmd];
	return FALSE;
}

#pragma mark -
#pragma mark Captures

- (void)capture
{
	[self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Cell Accessors

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
			// Check if this is the specified cell; uses a literal pointer comparison, since comparing cell attributes is not useful (too many cells are similar)
			if ([self cellAtX:i Y:j] == cell)
			{
				return [Petri2DCoordinates coordinatesWithXCoordinate:i
														  yCoordinate:j];
			}
		}
	}
	
	return nil;
}

- (NSSet*)placementCellsAdjacentToCell:(PetriBoardCell*)cell
{
	return [self placementCellsAdjacentToCoordinates:[self coordinatesOfCell:cell]];
}

- (NSSet*)placementCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (NSSet*)capturableCellsAdjacentToCell:(PetriBoardCell*)cell
{
	return [self capturableCellsAdjacentToCoordinates:[self coordinatesOfCell:cell]];
}

- (NSSet*)capturableCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

#pragma mark -
#pragma mark Other Accessors

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
