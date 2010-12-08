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
#import "PetriPlayer.h"
#import "Petri2DCoordinates.h"

#import "PetriBoardParameter.h"

#define PetriSquareGridBoardMinimumDimension	15
#define PetriSquareGridBoardMaximumDimension	50
#define PetriSquareGridBoardDefaultDimension	20

/*!
 Private interface for PetriSquareGridBoard
 */
@interface PetriSquareGridBoard(Private)

/**
 Capture cells in any possible direction around a given cell
 
 @param x x coordinate of cell to start at
 @param y y coordinate of cell to start at
 @param player player that we are having do the capturing
 */
- (BOOL)captureInAnyDirectionWithStartingX:(NSInteger)x
								 startingY:(NSInteger)y
						   capturingPlayer:(PetriPlayer*)player;

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
	if (boardWidth < PetriSquareGridBoardMinimumDimension || boardHeight < PetriSquareGridBoardMinimumDimension)
	{
		NSException* exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Board initialized with too small width or height." userInfo:nil];
		@throw exception;
	}
	return [super initWithWidth:boardWidth height:boardHeight];
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

- (void)performCapturesForPlayer:(PetriPlayer*)player
{
	for (int i = 0; i < width; i++)
	{
		for (int j = 0; j < height; j++)
		{
			PetriBoardCell* current = [self cellAtX:i Y:j];
			if ([current owner] == player)
			{
				while ([self captureInAnyDirectionWithStartingX:i
													  startingY:j
												capturingPlayer:player]);
			}
		}
	}
}

- (BOOL)captureInAnyDirectionWithStartingX:(NSInteger)x
								 startingY:(NSInteger)y
						   capturingPlayer:(PetriPlayer*)player
{
	NSMutableSet* offsets = [[NSMutableSet alloc] initWithCapacity:4];
	
	//Add the cells to the right, top and diagonals to a set that we can then use to calculate the offsets from
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:-1]];
	
	for (Petri2DCoordinates* offset in offsets)
	{
		//Iterate over each cell until we hit the edge (we'll break out first)
		for (int i = x; (i < width && i >= 0); i+= [offset xCoordinate])
		{
			for (int j = y; (j < height && j >= 0); j+= [offset yCoordinate])
			{
				PetriBoardCell* current = [self cellAtX:i Y:j];
				NSMutableSet* capturableCells = [[NSMutableSet alloc] init];
				
				//If we run into our own piece again in the same direction before hitting a null cell
				if ([current owner] == player)
				{
					//Delete cells in between
					for (PetriBoardCell* cell in capturableCells)
					{
						[cell setOwner:player];
						[cell setCellType:bodyCell];
					}
					
					//clear board
					[self clearDeadCells];
					
					return YES;
				}
				else if ([current cellType] != unoccupiedCell)
				{
					//Add to set
					[capturableCells addObject:current];
				}
				else //break out of these loops, we didn't find a capture
				{
					goto emptyCellFound;
				}			
			}
		}
	emptyCellFound:;
	}
	
	return NO;
}

- (void)setHeadsForPlayers:(NSArray*)players
{
	// Ensure that there are a sane number of players
	if ([players count] > [[self class] absoluteMaxPlayers] || [players count] < [[self class] absoluteMinPlayers])
	{
		NSException* exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"The number of players passed in is too small or too large." userInfo:nil];
		@throw exception;
	}
	
	NSMutableArray* headCellsTemp = [NSMutableArray arrayWithCapacity:4];
	
	// Up to four heads can exist; they are added in this order so that two players start diagonally across from each other.
	[headCellsTemp addObject:[self cellAtX:2 Y:2]];
	[headCellsTemp addObject:[self cellAtX:width - 3 Y:height - 3]];
	[headCellsTemp addObject:[self cellAtX:2 Y:height - 3]];
	[headCellsTemp addObject:[self cellAtX:width - 3 Y:2]];
	
	PetriBoardCell* cell = nil;
	PetriPlayer* owner = nil;
	for (NSUInteger i = 0; i < [players count]; i++)
	{
		cell = [headCellsTemp objectAtIndex:i];
		owner = [players objectAtIndex:i];
		[cell setOwner:owner];
		[cell setCellType:headCell];
		
		// Add the cell to the player's set of controlled cells
		[owner addControlledCellsObject:cell];
		[heads addObject:cell];
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
	NSMutableArray* values = [NSMutableArray arrayWithCapacity:
							  ((PetriSquareGridBoardMaximumDimension - PetriSquareGridBoardMinimumDimension) + 1)];
	for (NSUInteger i = PetriSquareGridBoardMinimumDimension; i <= PetriSquareGridBoardMaximumDimension; i++)
	{
		[values addObject:[NSNumber numberWithUnsignedInt:i]];
	}
	[parameters setObject:[PetriBoardParameter boardParameterWithName:@"Height"
																value:[NSNumber numberWithUnsignedInt:PetriSquareGridBoardDefaultDimension]
														  validValues:[values copy]]
				   forKey:@"height"];
	[parameters setObject:[PetriBoardParameter boardParameterWithName:@"Width"
																value:[NSNumber numberWithUnsignedInt:PetriSquareGridBoardDefaultDimension]
														  validValues:[values copy]]
				   forKey:@"width"];
	return [parameters copy];
}

@end
