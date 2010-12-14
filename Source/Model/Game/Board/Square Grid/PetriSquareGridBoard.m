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

NSSet* placementOffsets = nil;
NSSet* captureOffsets = nil;

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

+ (NSSet*)placementOffsets
{
	@synchronized(self)
	{
		if (placementOffsets != nil)
		{
			return placementOffsets;
		}
		NSMutableSet* offsets = [[NSMutableSet alloc] initWithCapacity:4];
		
		// Up, Down, Left, Right
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:-1]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:-1 yCoordinate:0]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0]];
		placementOffsets = [offsets copy];
	}
	
	return placementOffsets;
}

+ (NSSet*)captureOffsets
{
	@synchronized(self)
	{
		if (captureOffsets != nil)
		{
			return captureOffsets;
		}
		NSMutableSet* offsets = [[NSMutableSet alloc] initWithCapacity:4];
		
		// UR, DR, UL, DL
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:-1]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:-1 yCoordinate:1]];
		[offsets addObject:[Petri2DCoordinates coordinatesWithXCoordinate:-1 yCoordinate:-1]];
		
		[offsets unionSet:[self placementOffsets]];
		captureOffsets = [offsets copy];
	}
	
	return captureOffsets;
}

@end
