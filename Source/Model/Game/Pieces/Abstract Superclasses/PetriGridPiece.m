//
//  PetriGridPiece.m
//  Petri
//
//  Created by Alex Heinz on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridPiece.h"

#import "Petri2DCoordinates.h"

@implementation PetriGridPiece

/*!
 Override. Throws an exception.
 */
- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithCellCoordinates:(NSSet*)coordinates
				  orientation:(NSUInteger)initialOrientation
{
	// Check that we are not instantiating an abstract class
	if ([self isMemberOfClass:[PetriGridPiece class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	baseCellCoordinates = [self normalizeCoordinates:coordinates];
	orientation = (initialOrientation % [[self class] orientationsCount]);
	
	return self;
}

NSString* const PetriGridPieceInvalidPieceTypeExceptionFormat =	@"Invalid piece type in PetriGridPiece -initWithPiece: %@";

- (id)initWithPiece:(id<PetriPiece>)piece
		  rotations:(NSUInteger)numRotations
{
	// Check that the piece being copied uses some type of grid-based representation
	if (![piece isKindOfClass:[self class]])
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriGridPieceInvalidPieceTypeExceptionFormat, [piece class]];
		NSException* invalidPieceTypeException = [NSException exceptionWithName:NSInternalInconsistencyException
																		 reason:exceptionDesc
																	   userInfo:nil];
		@throw invalidPieceTypeException;
	}
	
	return [self initWithCellCoordinates:[(PetriGridPiece*)piece baseCellCoordinates]
							 orientation:([piece orientation] + numRotations)];
}

- (id)initWithCellCoordinates:(NSSet*)coordinates
{
	return [self initWithCellCoordinates:coordinates
							 orientation:0];
}

+ (id)pieceWithCellCoordinates:(NSSet*)coordinates
{
	return [[self alloc] initWithCellCoordinates:coordinates];
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithCellCoordinates:[self baseCellCoordinates]
														  orientation:[self orientation]];
}

#pragma mark -
#pragma mark Coordinate Manipulation

- (NSSet*)rotateCoordinatesClockwise:(NSSet*)coordinates
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

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
#pragma mark Rotation

- (void)rotate
{
	[self willChangeValueForKey:@"orientation"];
	orientation = (orientation + 1) % [[self class] orientationsCount];
	[self didChangeValueForKey:@"orientation"];
}

#pragma mark -
#pragma mark Accessors

- (NSInteger)baseWidth
{
	NSInteger maxX = NSIntegerMin;
	
	for (Petri2DCoordinates* cell in baseCellCoordinates)
	{
		if ([cell xCoordinate] > maxX)
			maxX = [cell xCoordinate];
	}
	
	return (maxX + 1);
}

- (NSInteger)baseHeight
{
	NSInteger maxY = NSIntegerMin;
	
	for (Petri2DCoordinates* cell in baseCellCoordinates)
	{
		if ([cell yCoordinate] > maxY)
			maxY = [cell yCoordinate];
	}
	
	return (maxY + 1);
}

@synthesize baseCellCoordinates;
@synthesize orientation;

- (NSSet*)currentCellCoordinates
{
	// Start with the base coordinates
	NSSet* currentCoords = [self baseCellCoordinates];
	
	// Rotate the coordinates according to the piece's orientation
	for (NSUInteger rotations = 0; rotations < [self orientation]; rotations++)
	{
		currentCoords = [self rotateCoordinatesClockwise:currentCoords];
	}
	
	// Return to the rotated coordinate set
	return currentCoords;
}
+ (NSSet*)keyPathsForValuesAffectingCurrentCellCoordinates
{
	return [NSSet setWithObjects:@"baseCellCoordinates", @"orientation", nil];
}

+ (NSUInteger)orientationsCount
{
	[self doesNotRecognizeSelector:_cmd];
	return 0;
}

+ (NSDictionary*)defaultPieceFrequencies
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

@end
