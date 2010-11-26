//
//  PetriPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPiece.h"
#import "Petri2DCoordinates.h"

/*!
 Private methods on PetriPiece.
 */
@interface PetriPiece(Private)

/*!
 Takes a set of Petri2DCoordinates, and shifts them so that they maintain their positions relative to one another, but their bounding rect has its origin at (0,0).
 */
- (NSSet*)normalizeCoordinates:(NSSet*)coordinates;

@end

@implementation PetriPiece

+ (NSDictionary*)defaultPieceFrequencies
{
	NSArray* pieceTypes = [NSArray arrayWithObjects:
						   [PetriPiece unitPiece],
						   [PetriPiece line2Piece],
						   [PetriPiece line3Piece],
						   [PetriPiece l3Piece],
						   [PetriPiece line4Piece],
						   [PetriPiece sPiece],
						   [PetriPiece zPiece],
						   [PetriPiece lPiece],
						   [PetriPiece jPiece],
						   [PetriPiece squarePiece],
						   [PetriPiece line5Piece],
						   nil];
	
	NSMutableDictionary* pieceFrequencies = [NSMutableDictionary dictionaryWithCapacity:[pieceTypes count]];
	for (PetriPiece* pieceType in pieceTypes)
	{
		[pieceFrequencies setObject:[NSNumber numberWithInteger:1]
							 forKey:pieceType];
	}
	
	return [pieceFrequencies copy];
}

+ (id)unitPiece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0]]];
}

+ (id)line2Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 nil]];
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

+ (id)l3Piece
{
	return [PetriPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
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

/*!
 Override. Throws an exception.
 */
- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithCellCoordinates:(NSSet*)coordinates
{
	cellCoordinates = [self normalizeCoordinates:coordinates];
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
#pragma mark Coordinate Normalization

- (NSSet*)normalizeCoordinates:(NSSet*)coordinates
{
	NSInteger minX = NSIntegerMax, minY = NSIntegerMax;
	for (Petri2DCoordinates* coord in coordinates)
	{
		if ([coord xCoordinate] < minX)
			minX = [coord xCoordinate];
		if ([coord yCoordinate] < minY)
			minY = [coord yCoordinate];
	}
	
	NSMutableSet* normalizedCoordinates = [NSMutableSet setWithCapacity:[coordinates count]];
	for (Petri2DCoordinates* coord in coordinates)
	{
		[normalizedCoordinates addObject:[coord offsetCoordinatesByX:-minX
																   Y:-minY]];
	}
	
	return [normalizedCoordinates copy];
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
	
	return [[self class] pieceWithCellCoordinates:[newCoordinates copy]];
}

- (PetriPiece*)pieceRotatedCounterclockwise
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[cellCoordinates count]];
	for (Petri2DCoordinates* coord in cellCoordinates)
	{
		[newCoordinates addObject:[coord rotatedCounterclockwiseAboutOrigin]];
	}
	
	return [[self class] pieceWithCellCoordinates:[newCoordinates copy]];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToPiece:(PetriPiece*)object];
}

- (BOOL)isEqualToPiece:(PetriPiece*)piece
{
	return [[self cellCoordinates] isEqualToSet:[piece cellCoordinates]];
}

- (NSUInteger)hash
{
	return [[self cellCoordinates] hash];
}

#pragma mark -
#pragma mark Accessors

- (NSInteger)width
{
	NSInteger maxX = NSIntegerMin;
	
	for (Petri2DCoordinates* cell in cellCoordinates)
	{
		if ([cell xCoordinate] > maxX)
			maxX = [cell xCoordinate];
	}
	
	return (maxX + 1);
}

- (NSInteger)height
{
	NSInteger maxY = NSIntegerMin;

	for (Petri2DCoordinates* cell in cellCoordinates)
	{
		if ([cell yCoordinate] > maxY)
			maxY = [cell yCoordinate];
	}
	
	return (maxY + 1);
}

@synthesize cellCoordinates;

@end
