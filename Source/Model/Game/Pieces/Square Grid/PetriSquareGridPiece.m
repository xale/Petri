//
//  PetriSquareGridPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridPiece.h"
#import "Petri2DCoordinates.h"

/*!
 Private methods on PetriSquareGridPiece.
 */
@interface PetriSquareGridPiece(Private)

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

#pragma mark -
#pragma mark Rotation

/*!
 Override. Rotates all coordinates in the piece's set 90° about the pieces origin, and normalizes them. Also updates the piece's \c orientation.
 */
- (void)rotate
{
	[self willChangeValueForKey:@"orientation"];
	[self willChangeValueForKey:@"cellCoordinates"];
	orientation = (orientation + 1) % [[self class] orientationsCount];
	cellCoordinates = [self normalizeCoordinates:[self rotateCoordinatesClockwise:[self cellCoordinates]]];
	[self didChangeValueForKey:@"cellCoordinates"];
	[self didChangeValueForKey:@"orientation"];
}

- (NSSet*)rotateCoordinatesClockwise:(NSSet*)coordinates
{
	NSMutableSet* newCoordinates = [NSMutableSet setWithCapacity:[coordinates count]];
	for (Petri2DCoordinates* coord in coordinates)
	{
		[newCoordinates addObject:[coord rotatedClockwiseAboutOrigin]];
	}
	
	return [newCoordinates copy];
}

#pragma mark -
#pragma mark Accessors

/*!
 Override. In the case of pieces to be placed on a square grid, this method returns 4.
 */
+ (NSUInteger)orientationsCount
{
	return 4;
}

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
