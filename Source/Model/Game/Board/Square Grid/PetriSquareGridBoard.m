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

NSString* const PetriSquareGridBoardWidthParameterKey =		@"width";
NSString* const PetriSquareGridBoardHeightParameterKey =	@"height";

NSString* const PetriSquareGridBoardWidthParameterName =	@"Width";
NSString* const PetriSquareGridBoardHeightParameterName =	@"Height";

#define PetriSquareGridBoardMinimumDimension	10
#define PetriSquareGridBoardMaximumDimension	40
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
- (BOOL)captureStartingWithXCoordinate:(NSInteger)x
						   yCoordinate:(NSInteger)y
								player:(PetriPlayer*)player;


- (BOOL)isValidXCoordinate:(NSInteger)xCoordinate;

- (BOOL)isValidYCoordinate:(NSInteger)yCoordinate;

@end

@implementation PetriSquareGridBoard

+ (id)boardWithParameters:(NSDictionary*)parameters
{
	return [[self alloc] initWithParameters:parameters];
}

- (id)initWithParameters:(NSDictionary*)parameters
{
	return [self initWithWidth:(NSInteger)[[parameters objectForKey:PetriSquareGridBoardWidthParameterKey] parameterValue]
						height:(NSInteger)[[parameters objectForKey:PetriSquareGridBoardHeightParameterKey] parameterValue]];
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
	if (yCoordinate >= [self width])
	{
		return NO;
	}
	return YES;
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
	
	while (![currentCoordinates isEqual:endCoordinates])
	{
		currentCell = [self cellAtCoordinates:currentCoordinates];
		if ([currentCell cellType] == headCell)
		{
			PetriPlayer* otherPlayer = [currentCell owner];
			[player addControlledCells:[otherPlayer controlledCells]];
			for (PetriBoardCell* tempCell in [otherPlayer controlledCells])
			{
				[tempCell setOwner:player];
			}
			[otherPlayer removeControlledCells:[otherPlayer controlledCells]];
			[currentCell setCellType:bodyCell];
		}
		[[currentCell owner] removeControlledCellsObject:currentCell];
		[currentCell setOwner:player];
		[player addControlledCellsObject:currentCell];
		currentCoordinates = [Petri2DCoordinates coordinatesWithXCoordinate:[currentCoordinates xCoordinate] + xOffset yCoordinate:[currentCoordinates yCoordinate] + yOffset];
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
		if ([currentCell owner] == nil)
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
	NSMutableSet* offsets = [[NSMutableSet alloc] initWithCapacity:4];
	
	//Add the cells to the right, top and diagonals to a set that we can then use to calculate the offsets from
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0]];
	[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:-1]];
	
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


- (void)performCapturesForPlayer:(PetriPlayer*)player
{
	BOOL didPerformCaptures;
	Petri2DCoordinates* currentCoordinates;
	do
	{
		// We have not performed any captures on this iteration of capturing
		didPerformCaptures = NO;
		
		for (PetriBoardCell* currentCell in [[player controlledCells] copy])
		{
			currentCoordinates = [self coordinatesOfCell:currentCell];
			didPerformCaptures = [self captureStartingWithXCoordinate:[currentCoordinates xCoordinate]
														  yCoordinate:[currentCoordinates yCoordinate]
															   player:player
								  ] || didPerformCaptures;
		}
	} while (didPerformCaptures);
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
	[parameters setObject:[PetriBoardParameter boardParameterWithName:PetriSquareGridBoardWidthParameterName
																value:(double)PetriSquareGridBoardDefaultDimension
															  minimum:(double)PetriSquareGridBoardMinimumDimension
															  maximum:(double)PetriSquareGridBoardMaximumDimension]
				   forKey:PetriSquareGridBoardWidthParameterKey];
	[parameters setObject:[PetriBoardParameter boardParameterWithName:PetriSquareGridBoardHeightParameterName
																value:(double)PetriSquareGridBoardDefaultDimension
															  minimum:(double)PetriSquareGridBoardMinimumDimension
															  maximum:(double)PetriSquareGridBoardMaximumDimension]
				   forKey:PetriSquareGridBoardHeightParameterKey];
	return [parameters copy];
}

@end
