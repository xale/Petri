//
//  PetriPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPiece.h"
#import "Petri2DCoordinates.h"

@implementation PetriPiece

+ (NSDictionary*)defaultPieceFrequencies
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithInteger:1],	[PetriPiece sPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece zPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece lPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece jPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece line3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece line4Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece line5Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece j3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece l3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece squarePiece],
			nil];
}

+ (id)jPiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}

+ (id)lPiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}


+ (id)zPiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}

+ (id)sPiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
												 nil]];
}

+ (id)line4Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:3],
												 nil]];
}

+ (id)line5Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:3],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:4],
												 nil]];
}

+ (id)squarePiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
												 nil]];
}

+ (id)j3Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 nil]];
}

+ (id)l3Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 nil]];
}

+ (id)line3Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 nil]];
}

- (id)init
{
	cellCoordinates = [NSSet setWithObjects:
					   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
					   [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
					   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
					   [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
					   nil];
	return self;
}

- (id)initWithCellCoordinates:(NSSet*)coordinates
{
	cellCoordinates = coordinates;
	return self;
}

+ (id)pieceWithCellCoordinates:(NSSet*)coordinates
{
	return [[self alloc] initWithCellCoordinates:coordinates];
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithCellCoordinates:[self cellCoordinates]];
}

#pragma mark -
#pragma mark Rotations

- (PetriPiece*)pieceRotatedClockwise
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[cellCoordinates count]];
	for (Petri2DCoordinates* coord in cellCoordinates)
	{
		[newCoordinates addObject:[coord rotatedClockwiseAboutOrigin]];
	}
	
	return [[PetriPiece alloc] initWithCellCoordinates:[newCoordinates copy]];
}

- (PetriPiece*)pieceRotatedCounterclockwise
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[cellCoordinates count]];
	for (Petri2DCoordinates* coord in cellCoordinates)
	{
		[newCoordinates addObject:[coord rotatedCounterclockwiseAboutOrigin]];
	}
	
	return [[PetriPiece alloc] initWithCellCoordinates:[newCoordinates copy]];
}

#pragma mark -
#pragma mark Accessors

- (NSInteger)width
{
	NSInteger max = INT_MIN;
	NSInteger min = INT_MAX;
	
	for (Petri2DCoordinates* cell in cellCoordinates)
	{
		if ([cell xCoordinate] > max)
		{
			max = [cell xCoordinate];
		}
		if ([cell xCoordinate] < min)
		{
			min = [cell xCoordinate];
		}
	}
	
	return (max - min) + 1;
}

- (NSInteger)height
{
	NSInteger max = INT_MIN;
	NSInteger min = INT_MAX;

	for (Petri2DCoordinates* cell in cellCoordinates)
	{
		if ([cell yCoordinate] > max)
		{
			max = [cell yCoordinate];
		}
		if ([cell yCoordinate] < min)
		{
			min = [cell yCoordinate];
		}
	}
	
	return (max - min) + 1;
}

@synthesize cellCoordinates;

@end
