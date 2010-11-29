//
//  PetriPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridPiece.h"
#import "Petri2DCoordinates.h"

/*!
 Private methods on PetriPiece.
 */
@interface PetriSquareGridPiece(Private)

/*!
 Takes a set of Petri2DCoordinates, and shifts them so that they maintain their positions relative to one another, but their bounding rect has its origin at (0,0).
 */
- (NSSet*)normalizeCoordinates:(NSSet*)coordinates;

@end

@implementation PetriSquareGridPiece

+ (NSDictionary*)defaultPieceFrequencies
{
	NSArray* pieceTypes = [NSArray arrayWithObjects:
						   [PetriSquareGridPiece unitPiece],
						   [PetriSquareGridPiece line2Piece],
						   [PetriSquareGridPiece line3Piece],
						   [PetriSquareGridPiece l3Piece],
						   [PetriSquareGridPiece line4Piece],
						   [PetriSquareGridPiece sPiece],
						   [PetriSquareGridPiece zPiece],
						   [PetriSquareGridPiece lPiece],
						   [PetriSquareGridPiece jPiece],
						   [PetriSquareGridPiece squarePiece],
						   [PetriSquareGridPiece line5Piece],
						   nil];
	
	NSMutableDictionary* pieceFrequencies = [NSMutableDictionary dictionaryWithCapacity:[pieceTypes count]];
	for (PetriSquareGridPiece* pieceType in pieceTypes)
	{
		[pieceFrequencies setObject:[NSNumber numberWithInteger:1]
							 forKey:pieceType];
	}
	
	return [pieceFrequencies copy];
}

+ (id)unitPiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObject:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0]]];
}

+ (id)line2Piece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 nil]];
}

+ (id)jPiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}

+ (id)lPiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}


+ (id)zPiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:2],
												 nil]];
}

+ (id)sPiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:2 yCoordinate:1],
												 nil]];
}

+ (id)line4Piece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:3],
												 nil]];
}

+ (id)line5Piece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:2],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:3],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:4],
												 nil]];
}

+ (id)squarePiece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:0],
												 nil]];
}

+ (id)l3Piece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0],
												 [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1],
												 [Petri2DCoordinates coordinatesWithXCoordinate:1 yCoordinate:1],
												 nil]];
}

+ (id)line3Piece
{
	return [PetriSquareGridPiece pieceWithCellCoordinates:[NSSet setWithObjects:
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

- (PetriSquareGridPiece*)pieceRotatedClockwise
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[cellCoordinates count]];
	for (Petri2DCoordinates* coord in cellCoordinates)
	{
		[newCoordinates addObject:[coord rotatedClockwiseAboutOrigin]];
	}
	
	return [[self class] pieceWithCellCoordinates:[newCoordinates copy]];
}

- (PetriSquareGridPiece*)pieceRotatedCounterclockwise
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[cellCoordinates count]];
	for (Petri2DCoordinates* coord in cellCoordinates)
	{
		[newCoordinates addObject:[coord rotatedCounterclockwiseAboutOrigin]];
	}
	
	return [[self class] pieceWithCellCoordinates:[newCoordinates copy]];
}

+ (NSUInteger)orientationsCount
{
	return 4;
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToPiece:(PetriSquareGridPiece*)object];
}

- (BOOL)isEqualToPiece:(PetriSquareGridPiece*)piece
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

- (NSString*)description
{
	NSMutableString* description = [NSMutableString stringWithFormat:@"%@: {%C", [super description], NSLineSeparatorCharacter];
	for (NSInteger y = ([self height] - 1); y >= 0; y--)
	{
		for (NSInteger x = 0; x < [self width]; x++)
		{
			if ([[self cellCoordinates] containsObject:[Petri2DCoordinates coordinatesWithXCoordinate:x yCoordinate:y]])
				[description appendString:@"o "];
			else
				[description appendString:@"  "];
		}
		[description appendFormat:@"%C", NSLineSeparatorCharacter];
	}
	
	[description appendString:@"}"];
	
	return [description copy];
}

@end
