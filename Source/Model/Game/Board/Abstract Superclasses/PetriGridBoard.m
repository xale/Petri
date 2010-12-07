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
#import "PetriGridPiece.h"
#import "PetriPlayer.h"

@interface NSMutableSet(Pop)
- (id)pop;
@end

/*!
 Adds a pop method to mutable set.
 */
@implementation NSMutableSet(Pop)
/*!
 Return an arbitrary element and remove it from the set.
 */
- (id)pop;
{
	id any = [self anyObject];
	[self removeObject:any];
	return any;
}
@end

/*!
 Private methods for PetriGridBoard
 */
@interface PetriGridBoard(Private)
/*!
 Make the cell passed in owned by noone and of empty type
 
 @param cell the cell to clear
 */
- (void)forceClearCell:(PetriBoardCell*)cell;
@end

@implementation PetriGridBoard

/*!
 Override. Throws an exception.
 */
- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

+ (id)boardWithParameters:(NSDictionary*)parameters
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithParameters:(NSDictionary*)parameters
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
	heads = [NSMutableSet set];
	
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

NSString* const PetriGridBoardInvalidPieceTypeExceptionDescriptionFormat =	@"Attempting to place or validate piece of invalid type on PetriGridBoard: %@";

- (void)placePiece:(id<PetriPiece>)piece
		 withOwner:(PetriPlayer*)owner
			onCell:(PetriBoardCell*)cell
{
	// Check that the piece type is valid for placement on this board
	if (![piece isKindOfClass:[[self class] pieceClass]])
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriGridBoardInvalidPieceTypeExceptionDescriptionFormat, [piece class]];
		NSException* invalidPieceTypeException = [NSException exceptionWithName:NSInternalInconsistencyException
																		 reason:exceptionDesc
																	   userInfo:nil];
		@throw invalidPieceTypeException;
	}
	
	return [self placePiece:(PetriGridPiece*)piece
				  withOwner:owner
			  atCoordinates:[self coordinatesOfCell:cell]];
}

- (void)placePiece:(PetriGridPiece*)piece
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
		
		// Add the cell to the player's controlled cells
		[player addControlledCellsObject:cell];
	}
}

- (BOOL)validatePlacementOfPiece:(id<PetriPiece>)piece
					   withOwner:(PetriPlayer*)owner
						  onCell:(PetriBoardCell*)cell
{
	// Check that the piece type is valid for placement on this board
	if (![piece isKindOfClass:[[self class] pieceClass]])
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriGridBoardInvalidPieceTypeExceptionDescriptionFormat, [piece class]];
		NSException* invalidPieceTypeException = [NSException exceptionWithName:NSInternalInconsistencyException
																		 reason:exceptionDesc
																	   userInfo:nil];
		@throw invalidPieceTypeException;
	}
	
	return [self validatePlacementOfPiece:(PetriGridPiece*)piece
								withOwner:owner
							atCoordinates:[self coordinatesOfCell:cell]];
}

- (BOOL)validatePlacementOfPiece:(PetriGridPiece*)piece
					   withOwner:(PetriPlayer*)pieceOwner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin
{
	// Create the actual set of coordinates where the piece will lie
	NSMutableSet* placementCoords = [NSMutableSet setWithCapacity:[[piece cellCoordinates] count]];
	for (Petri2DCoordinates* cellCoord in [piece cellCoordinates])
	{
		[placementCoords addObject:[cellCoord offsetCoordinates:pieceOrigin]];
	}
	
	// Test that all coordinates are valid, and the cells are empty
	NSInteger x, y;
	for (Petri2DCoordinates* coord in placementCoords)
	{
		// Check that the coordinates are on the board
		x = [coord xCoordinate];
		y = [coord yCoordinate];
		if ((x < 0) || (x >= [self width]) || (y < 0) || (y >= [self height]))
			return NO;
		
		// Check that the cell at the coordinates is empty
		if ([[self cellAtCoordinates:coord] cellType] != unoccupiedCell)
			return NO;
	}
	
	// Get the cells that will be claimed by the piece
	NSMutableSet* placementCells = [NSMutableSet setWithCapacity:[placementCoords count]];
	for (Petri2DCoordinates* cellCoord in placementCoords)
	{
		[placementCells addObject:[self cellAtCoordinates:cellCoord]];
	}
	
	// Check that at least one of the cells is adjacent to a cell owned by the player placing the piece
	for (PetriBoardCell* playerCell in [pieceOwner enumeratorOfControlledCells])
	{
		NSSet* adjacentCells = [self placementCellsAdjacentToCell:playerCell];
		if ([adjacentCells intersectsSet:placementCells])
			return YES;
	}
	
	return NO;
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
			// Check if this is the specified cell
			if ([[self cellAtX:i Y:j] isEqual:cell])
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

+ (Class<PetriPiece>)pieceClass
{
	return [PetriGridPiece class];
}

+ (NSUInteger)absoluteMinPlayers
{
	[self doesNotRecognizeSelector:_cmd];
	return -1;
}

+ (NSUInteger)absoluteMaxPlayers
{
	[self doesNotRecognizeSelector:_cmd];
	return -1;
}

- (NSSet*)heads
{
	return [heads copy];
}

- (PetriBoardCell*)headForPlayer:(PetriPlayer*)player
{
	for (PetriBoardCell* cell in heads)
	{
		if ([cell owner] == player)
		{
			return cell;
		}
	}
	return nil;
}

// Implemented using only interface methods.
// Why don't we have default implementations for interface methods?
- (NSSet*)findLivingCellsForPlayer:(PetriPlayer*)player
{
	PetriBoardCell* head = [self headForPlayer:player];
	
	// If the player has no head, s/he has no living cells
	if (head == nil)
	{
		return [NSSet set];
	}
	NSMutableSet* visited = [NSMutableSet set];
	NSMutableSet* unvisited = [NSMutableSet setWithObject:head];
	
	PetriBoardCell* cell;
	NSMutableSet* visiting;
	while ([unvisited count] > 0) // as long as there are cells whose neighbors we haven't checked
	{
		// Take an arbitrary unvisited cell
		cell = [unvisited pop];
		// Get all its neighbors
		visiting = [[self placementCellsAdjacentToCell:cell] mutableCopy];
		// Remove the ones we've already visited
		[visiting minusSet:visited];
		// Mark them for later visitation
		[unvisited unionSet:visiting];
	}
	return [visited copy];
}

- (void)forceClearCell:(PetriBoardCell*)cell
{
	[cell setOwner:nil];
	[cell setCellType:unoccupiedCell];
}

- (void)clearDeadCells
{
	PetriPlayer* player;
	NSMutableSet* owned;
	for (PetriBoardCell* head in [self heads])
	{
		// Get the player who owns this particular head
		player = [head owner];
		// Get all cells the player owns
		owned = [[player controlledCells] mutableCopy];
		// Remove all living cells the player owns
		[owned minusSet:[self findLivingCellsForPlayer:player]];
		// Clear all the rest
		for (PetriBoardCell* cell in owned)
		{
			[self forceClearCell:cell];
		}
	}
}

- (void)performCapturesForPlayer:(PetriPlayer*)player
{
	[self doesNotRecognizeSelector:_cmd];
}


- (void)setHeadsForPlayers:(NSArray*)players
{
	[self doesNotRecognizeSelector:_cmd];
}

+ (NSDictionary*)setupParameters
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

@synthesize width;
@synthesize height;

@end
