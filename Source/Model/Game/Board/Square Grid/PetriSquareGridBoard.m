//
//  PetriSquareGridBoard.m
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoard.h"

#import "PetriBoardCell.h"
#import "PetriSquareGridPiece.h"
#import "Petri2DCoordinates.h"

#import "PetriBoardParameter.h"

#define MIN_DIMENSION 8
#define MAX_DIMENSION 100
#define DEFAULT_DIMENSION 10

/*!
 Private interface for PetriSquareGridBoard
 */
@interface PetriSquareGridBoard(Private)

/**
  Clears dead cells from the board after a capture
 */
- (void)clearDeadCells;

/**
 Recursive helper method for clearing dead cells from the board after a capture
 Yes, all the cool kids would probably make this a single recursive method
 but I'm sorry, I was very sleep deprived when I wrote it.
 At least it works, probably.
 
 @param start starting location to recursively check to see if connected
 @param visited set of visited cells, which well not be swept from the board
 */
- (void)clearDeadCellsHelperWithStart:(PetriBoardCell*)start
								  set:(NSMutableSet*)visited;
@end

@implementation PetriSquareGridBoard

+ (id)boardWithParameters:(NSDictionary*)parameters
{
	return [[self alloc] initWithParameters:parameters];
}

- (id)initWithParameters:(NSDictionary*)parameters
{
	return [self initWithWidth:(NSInteger)[[[parameters objectForKey:@"width"] parameterValue] unsignedIntegerValue]
						height:(NSInteger)[[[parameters objectForKey:@"height"] parameterValue] unsignedIntegerValue]
			];
}

- (id)initWithWidth:(NSInteger)boardWidth
			 height:(NSInteger)boardHeight
{
	if (boardWidth < MIN_DIMENSION || boardHeight < MIN_DIMENSION)
	{
		NSException* exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Board initialized with too small width or height." userInfo:nil];
		@throw exception;
	}
	return [super initWithWidth:boardWidth height:boardHeight];
}

- (BOOL)validatePlacementOfPiece:(PetriGridPiece*)piece
					   withOwner:(PetriPlayer*)pieceOwner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin
{
	//If any of the cells to be covered by the body are occupied, or not on the board then we cannot place a piece there
	for (Petri2DCoordinates* cellOffset in [piece cellCoordinates])
	{
		// FIXME check if coordinates are on board
		
		PetriBoardCell* cell = [self cellAtCoordinates:[pieceOrigin offsetCoordinates:cellOffset]];
		if ([cell cellType] != unoccupiedCell)
		{
			return FALSE;
		}
	}
	
	//We now check that at least one cell adjoins a cell owned by the player placing the piece
	for (Petri2DCoordinates* cellOffset in [piece cellCoordinates])
	{		
		NSSet* adjacencies = [self placementCellsAdjacentToCoordinates:[pieceOrigin offsetCoordinates:cellOffset]];
		
		for (PetriBoardCell* cell in adjacencies)
		{
			if ([cell owner] == pieceOwner)
			{
				return TRUE;
			}
		}
	}
	
	return FALSE;
}

- (NSSet*)placementCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	NSMutableSet* adjacentCells = [NSMutableSet set];
	
	//Add and subtract 1 to x and y
	//Throw out negatives or things outside of bounds
	NSInteger x = [cellCoordinates xCoordinate];
	NSInteger y = [cellCoordinates yCoordinate];
	
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

- (NSSet*)capturableCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates
{
	NSMutableSet* adjacentCells = [NSMutableSet set];
	
	//Add and subtract 1 to x and y
	//Throw out negatives or things outside of bounds
	NSInteger x = [cellCoordinates xCoordinate];
	NSInteger y = [cellCoordinates yCoordinate];
	
	// Add laterally-adjacent cells
	[adjacentCells unionSet:[self placementCellsAdjacentToCoordinates:cellCoordinates]];
	
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
					for (PetriBoardCell* cell in [self capturableCellsAdjacentToCoordinates:currentCoordinates])
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
										[self clearDeadCells];
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

- (void)clearDeadCellsHelperWithStart:(PetriBoardCell*) start
								  set:(NSMutableSet*) visited
{
	for (PetriBoardCell* cell in [self coordinatesOfCell:start])
	{
		if ([cell owner] == [start owner])
		{
			[visited addObject:cell];
			[self clearDeadCellsHelperWithStart:cell
											set:visited];
		}
	}
}

- (void)clearDeadCells
{
	for (int i = 0; i < width; i++)
	{
		for (int j = 0; j < height; j++)
		{
			PetriBoardCell* current = [self cellAtX:i Y:j];
			if ([current cellType] == headCell)
			{
				NSMutableSet* set = [[NSMutableSet alloc] init];
				[self clearDeadCellsHelperWithStart:current
												set: set];
				for (int q = 0; q < width; q++)
				{
					for (int r = 0; r < height; r++)
					{
						PetriBoardCell* cell = [self cellAtX:q Y:r];
						if (![set containsObject:cell])
						{
							[cell setOwner:nil];
							[cell setCellType:unoccupiedCell];
						}
					}
				}
			}
		}
	}
}

- (void)setHeadsForPlayers:(NSArray*)players
{
	if ([players count] > [[self class] absoluteMaxPlayers] || [players count] < [[self class] absoluteMinPlayers])
	{
		NSException* exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"The number of players passed in is too small or too large." userInfo:nil];
		@throw exception;
	}
	NSMutableArray* headCellsTemp = [NSMutableArray arrayWithCapacity:4];
	[headCellsTemp addObject:[self cellAtX:2 Y:2]];
	[headCellsTemp addObject:[self cellAtX:width - 3 Y:height - 3]];
	[headCellsTemp addObject:[self cellAtX:2 Y:height - 3]];
	[headCellsTemp addObject:[self cellAtX:width - 3 Y:2]];
	for (NSUInteger i = 0; i < [players count]; i++)
	{
		[[headCellsTemp objectAtIndex:i] setOwner:[players objectAtIndex:i]];
		[[headCellsTemp objectAtIndex:i] setCellType:headCell];
	}
}

+ (Class<PetriPiece>)pieceClass
{
	return [PetriSquareGridPiece class];
}

+ (NSUInteger)absoluteMinPlayers
{
	return 2;
}

+ (NSUInteger)absoluteMaxPlayers
{
	return 4;
}

+ (NSDictionary*)setupParameters
{
	NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithCapacity:2];
	NSMutableSet* values = [NSMutableSet setWithCapacity:92];
	for (NSUInteger i = MIN_DIMENSION; i < MAX_DIMENSION; i++)
	{
		[values addObject:[NSNumber numberWithUnsignedInt:i]];
	}
	[parameters setObject:[PetriBoardParameter boardParameterWithName:@"Height" value:[NSNumber numberWithUnsignedInt:DEFAULT_DIMENSION] validValues:[values copy]] forKey:@"height"];
	[parameters setObject:[PetriBoardParameter boardParameterWithName:@"Width" value:[NSNumber numberWithUnsignedInt:DEFAULT_DIMENSION] validValues:[values copy]] forKey:@"width"];
	return [parameters copy];
}

@end
