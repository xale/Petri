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

NSInteger nextCellId = 0;

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

- (void)queueCellForCapture:(PetriBoardCell*)cell;

- (void)queueCellForCapture:(PetriBoardCell*)cell
					atIndex:(NSUInteger)index;

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
	
	// Set width and height first
	// They are used by convenience methods to verify validity of coordinates
	width = boardWidth;
	height = boardHeight;

	// Create the two-dimensional array of board cells
	NSMutableArray* tempBoard = [NSMutableArray arrayWithCapacity:width];
	NSMutableArray* column = nil;
	for (NSInteger x = 0; [self isValidXCoordinate:x]; x++)
	{
		column = [NSMutableArray arrayWithCapacity:height];
		
		for (NSInteger y = 0; [self isValidYCoordinate:y]; y++)
		{
			[column addObject:[[PetriBoardCell alloc] initWithCellID:nextCellId++]];
		}
		
		[tempBoard addObject:[column copy]];
	}
	
	// Assign to local ivar
	cells = [tempBoard copy];
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
	for (NSInteger x = 0; [self isValidXCoordinate:x]; x++)
	{
		// Fill the board column-by-column
		column = [NSMutableArray arrayWithCapacity:height];
		for (NSInteger y = 0; [self isValidYCoordinate:y]; y++)
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
	NSMutableSet* coveredCells = [NSMutableSet set];
	for (Petri2DCoordinates* cellOffset in [piece currentCellCoordinates])
	{
		// Find the cell located at (piece origin) + (cell offset)
		PetriBoardCell* cell = [self cellAtCoordinates:[pieceOrigin offsetCoordinates:cellOffset]];
		[coveredCells addObject:cell];
	}
	
	// Queue up the first cells to capture
	for (PetriBoardCell* cell in [coveredCells copy])
	{
		if ([[[self placementCellsAdjacentToCell:cell] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"owner == %@", player]] count] > 0)
		{
			[self queueCellForCapture:cell];
			[coveredCells removeObject:cell];
		}
	}
	
	// Queue up the rest
	NSUInteger offset = 0;
	while ([coveredCells count] > 0)
	{
		for (PetriBoardCell* cell in [coveredCells copy])
		{
			if ([[stagedCaptures objectAtIndex:offset] intersectsSet:[self placementCellsAdjacentToCell:cell]])
			{
				[self queueCellForCapture:cell atIndex:offset + 1];
				[coveredCells removeObject:cell];
			}
		}
		offset++;
	}
}

- (NSSet*)cellsCoveredByPlacingPiece:(PetriGridPiece*)piece
							  onCell:(PetriBoardCell*)cell
{
	Petri2DCoordinates* pieceOrigin = [self coordinatesOfCell:cell];

	NSMutableSet* placementCells = [NSMutableSet setWithCapacity:[[piece currentCellCoordinates] count]];

	for (Petri2DCoordinates* cellCoord in [piece currentCellCoordinates])
	{
		if ([self isValidXCoordinate:[[cellCoord offsetCoordinates:pieceOrigin] xCoordinate]] &&
			[self isValidYCoordinate:[[cellCoord offsetCoordinates:pieceOrigin] yCoordinate]])
		{
			[placementCells addObject:[self cellAtCoordinates:[cellCoord offsetCoordinates:pieceOrigin]]];
		}
	}
	return [placementCells copy];
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
	NSMutableSet* placementCoords = [NSMutableSet setWithCapacity:[[piece currentCellCoordinates] count]];
	for (Petri2DCoordinates* cellCoord in [piece currentCellCoordinates])
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
		if (![self isValidXCoordinate:x] || ![self isValidYCoordinate:y])
			return NO;
		
		// Check that the cell at the coordinates is empty
		if (![[self cellAtCoordinates:coord] isEmpty])
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
	for (int x = 0; [self isValidXCoordinate:x]; x++)
	{
		for (int y = 0; [self isValidYCoordinate:y]; y++)
		{
			// Check if this is the specified cell
			if ([[self cellAtX:x Y:y] isEqual:cell])
			{
				return [Petri2DCoordinates coordinatesWithXCoordinate:x
														  yCoordinate:y];
			}
		}
	}
	
	return nil;
}

- (NSSet*)cellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
						 withOffsets:(NSSet*)offsets
{
	NSMutableSet* adjacentCells = [NSMutableSet set];
	
	NSInteger x = [cellCoordinates xCoordinate];
	NSInteger y = [cellCoordinates yCoordinate];
	
	for (Petri2DCoordinates* offset in offsets)
	{
		NSInteger xCoordinate = [offset xCoordinate] + x;
		NSInteger yCoordinate = [offset yCoordinate] + y;
		
		if ([self isValidXCoordinate:xCoordinate] && [self isValidYCoordinate:yCoordinate])
		{
			[adjacentCells addObject:[self cellAtX:xCoordinate Y:yCoordinate]];
		}
	}
	
	return [adjacentCells copy];
}

- (NSSet*)placementCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	return [self cellsAdjacentToCoordinates:cellCoordinates withOffsets:[[self class] placementOffsets]];
}

- (NSSet*)capturableCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	return [self cellsAdjacentToCoordinates:cellCoordinates withOffsets:[[self class] captureOffsets]];
}

- (NSSet*)placementCellsAdjacentToCell:(PetriBoardCell*)cell
{
	return [self placementCellsAdjacentToCoordinates:[self coordinatesOfCell:cell]];
}

- (NSSet*)capturableCellsAdjacentToCell:(PetriBoardCell*)cell
{
	return [self capturableCellsAdjacentToCoordinates:[self coordinatesOfCell:cell]];
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
		// Mark it as visited
		[visited addObject:cell];
		// Get all its neighbors
		visiting = [[self placementCellsAdjacentToCell:cell] mutableCopy];
		// Remove the ones we've already visited
		[visiting minusSet:visited];
		[visiting filterUsingPredicate:[NSPredicate predicateWithFormat:@"(owner == %@)", player]];
		// Mark them for later visitation
		[unvisited unionSet:visiting];
	}
	return [visited copy];
}

- (void)forceTakeCell:(PetriBoardCell*)cell
			forPlayer:(PetriPlayer*)player
{
	[[cell owner] removeControlledCellsObject:cell];
	[player addControlledCellsObject:cell];
	[cell takeCellForPlayer:player];
}

- (void)forceClearCell:(PetriBoardCell*)cell
{
	[[cell owner] removeControlledCellsObject:cell];
	[cell clearCell];
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

- (void)setHeadsForPlayers:(NSArray*)players
{
	[self doesNotRecognizeSelector:_cmd];
}

+ (NSDictionary*)setupParameters
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (BOOL)isValidXCoordinate:(NSInteger)xCoordinate
{
	if (xCoordinate < 0)
	{
		return NO;
	}
	if (xCoordinate >= [self width])
	{
		return NO;
	}
	return YES;
}

- (BOOL)isValidYCoordinate:(NSInteger)yCoordinate
{
	if (yCoordinate < 0)
	{
		return NO;
	}
	if (yCoordinate >= [self height])
	{
		return NO;
	}
	return YES;
}

+ (NSSet*)placementOffsets
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

+ (NSSet*)captureOffsets
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

#pragma mark -
#pragma mark Captures

- (BOOL)performQueuedCapturesForPlayer:(PetriPlayer*)player
{
	NSMutableSet* set = [stagedCaptures objectAtIndex:0];
	[stagedCaptures removeObjectAtIndex:0];
	BOOL didPerformCaptures = NO;
	for (PetriBoardCell* cell in set)
	{
		[self forceTakeCell:cell forPlayer:player];
		didPerformCaptures = YES;
	}
	return didPerformCaptures;
}

- (void)queueCellForCapture:(PetriBoardCell*)cell
{
	if (stagedCaptures == nil)
	{
		stagedCaptures = [NSMutableArray array];
	}
	
	if ([stagedCaptures count] == 0)
	{
		[stagedCaptures addObject:[NSMutableSet set]];
	}
	[[stagedCaptures objectAtIndex:0] addObject:cell];
}

- (void)queueCellForCapture:(PetriBoardCell*)cell
					atIndex:(NSUInteger)index
{
	while ([stagedCaptures count] <= index)
	{
		[stagedCaptures addObject:[NSMutableSet set]];
	}
	[[stagedCaptures objectAtIndex:index] addObject:cell];
}

// \warning this function does _no_ validation
- (void)forceCaptureCellsFrom:(Petri2DCoordinates*)startCoordinates
						   to:(Petri2DCoordinates*)endCoordinates
				 usingXOffset:(NSInteger)xOffset
					  yOffset:(NSInteger)yOffset
					forPlayer:(PetriPlayer*)player
{
	Petri2DCoordinates* currentCoordinates = startCoordinates;
	PetriBoardCell* currentCell;
	NSMutableArray* cellsToCapture = [NSMutableArray array];
	
	while (![currentCoordinates isEqual:endCoordinates])
	{
		currentCell = [self cellAtCoordinates:currentCoordinates];
		if ([currentCell cellType] == headCell)
		{
			PetriPlayer* otherPlayer = [currentCell owner];
			[player addControlledCells:[otherPlayer controlledCells]];
			for (PetriBoardCell* tempCell in [otherPlayer controlledCells])
			{
				[self queueCellForCapture:tempCell atIndex:1];
			}
		}
		
		[cellsToCapture addObject:currentCell];
		
		// Iterate
		currentCoordinates = [Petri2DCoordinates coordinatesWithXCoordinate:[currentCoordinates xCoordinate] + xOffset yCoordinate:[currentCoordinates yCoordinate] + yOffset];
	}
	
	// properly queue captures
	for (NSUInteger i = 0; i < [cellsToCapture count] - i; i++)
	{
		[self queueCellForCapture:[cellsToCapture objectAtIndex:i] atIndex:i];
		[self queueCellForCapture:[cellsToCapture objectAtIndex:[cellsToCapture count] - 1 - i] atIndex:i];
	}
}
- (BOOL)captureStartingWithXCoordinate:(NSInteger)startingX
						   yCoordinate:(NSInteger)startingY
							   xOffset:(NSInteger)xOffset
							   yOffset:(NSInteger)yOffset
								player:(PetriPlayer*)player
{
	// Initialize the coordinate values
	NSInteger currentX = startingX + xOffset;
	NSInteger currentY = startingY + yOffset;
	
	// Declare the current cell
	PetriBoardCell* currentCell = nil;
	
	// as long as x and y are valid, keep going
	while ([self isValidYCoordinate:currentY] && [self isValidXCoordinate:currentX])
	{
		currentCell = [self cellAtCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:currentX yCoordinate:currentY]];
		
		// The cell is empty
		if ([currentCell isEmpty])
		{
			// We have encountered an empty cell before encountering our own cell
			// No capture in this direction at this time
			return NO;
		}
		
		// The cell is ours
		if ([currentCell owner] == player)
		{
			// Check that there's at least one cell between this and the start
			if (currentX == (startingX + xOffset) && currentY == (startingY + yOffset))
			{
				// There isn't; nothing interesting happens
				return NO;
			}
			
			// Since this cell is ours and we haven't encountered any empty cells between this one and the starting one, we capture
			[self forceCaptureCellsFrom:[Petri2DCoordinates coordinatesWithXCoordinate:startingX + xOffset yCoordinate:startingY + yOffset]
									 to:[Petri2DCoordinates coordinatesWithXCoordinate:currentX yCoordinate:currentY]
						   usingXOffset:xOffset
								yOffset:yOffset
							  forPlayer:player
			 ];
			return YES;
		}
		// Iteration
		currentX += xOffset;
		currentY += yOffset;
	}
	// We reached the end of the board without finding a capture
	return NO;
}
- (BOOL)captureStartingWithXCoordinate:(NSInteger)startingX
						   yCoordinate:(NSInteger)startingY
								player:(PetriPlayer*)player
{
	NSSet* offsets = [[self class] captureOffsets];
	
	BOOL didPerformCaptures = NO;
	for (Petri2DCoordinates* offset in offsets)
	{
		didPerformCaptures = [self captureStartingWithXCoordinate:startingX
													  yCoordinate:startingY
														  xOffset:[offset xCoordinate]
														  yOffset:[offset yCoordinate]
														   player:player
							  ] || didPerformCaptures;
	}
	return didPerformCaptures;
}


- (BOOL)stepCapturesForPlayer:(PetriPlayer*)player
{
	Petri2DCoordinates* currentCoordinates;
	
	if (stagedCaptures == nil)
	{
		stagedCaptures = [NSMutableArray array];
	}
	if ([stagedCaptures count] == 0)
	{
		return NO;
	}
	NSSet* cellsToCapture = [[stagedCaptures objectAtIndex:0] copy];
	BOOL didPerformCaptures = [self performQueuedCapturesForPlayer:player];
	for (PetriBoardCell* currentCell in cellsToCapture)
	{
		currentCoordinates = [self coordinatesOfCell:currentCell];
		[self captureStartingWithXCoordinate:[currentCoordinates xCoordinate]
								 yCoordinate:[currentCoordinates yCoordinate]
									  player:player];
	}
	return didPerformCaptures;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:cells forKey: @"cells"];
}

- (id)initWithCoder:(NSCoder *)coder
{
	if((self = [self init]))
	{
		cells = [coder decodeObjectForKey:@"cells"];
	}
	return self;	
}

@synthesize width;
@synthesize height;

@end
