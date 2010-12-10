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
					rotations:(NSUInteger)rotations
{
	// Check that we are not instantiating an abstract class
	if ([self isMemberOfClass:[PetriGridPiece class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	cellCoordinates = [self normalizeCoordinates:coordinates];
	orientation = 0;
	//TODO optimization: if rotations is big, reduce to smaller than orientationsCount
	for (NSUInteger i = rotations; i > 0; i--)
	{
		cellCoordinates = [self normalizeCoordinates:[self rotateCoordinatesClockwise:cellCoordinates]];
	}
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
	
	return [self initWithCellCoordinates:[(PetriGridPiece*)piece cellCoordinates]
							   rotations:numRotations];
}

- (id)initWithCellCoordinates:(NSSet*)coordinates
{
	return [self initWithCellCoordinates:coordinates
							   rotations:0];
}

+ (id)pieceWithCellCoordinates:(NSSet*)coordinates
{
	return [[self alloc] initWithCellCoordinates:coordinates];
}

- (id)copyWithZone:(NSZone*)zone
{
	return [[[self class] allocWithZone:zone] initWithCellCoordinates:[self cellCoordinates]
															rotations:0];
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
	[self willChangeValueForKey:@"cellCoordinates"];
	orientation = (orientation + 1) % [[self class] orientationsCount];
	cellCoordinates = [self normalizeCoordinates:[self rotateCoordinatesClockwise:[self cellCoordinates]]];
	[self didChangeValueForKey:@"cellCoordinates"];
	[self didChangeValueForKey:@"orientation"];
}

#pragma mark -
#pragma mark Comparators

- (BOOL)isEqual:(id)object
{
	if (![object isKindOfClass:[self class]])
		return NO;
	
	return [self isEqualToGridPiece:(PetriGridPiece*)object];
}

- (BOOL)isEqualToGridPiece:(PetriGridPiece*)piece
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
@synthesize orientation;

NSString* const PetriGridPieceAbstractMethodExceptionFormat =	@"Attempt to invoke abstract class method %@";

+ (NSUInteger)orientationsCount
{
	NSString* exceptionDesc = [NSString stringWithFormat:PetriGridPieceAbstractMethodExceptionFormat, NSStringFromSelector(_cmd)];
	NSException* abstractMethodException = [NSException exceptionWithName:NSInternalInconsistencyException
																   reason:exceptionDesc
																 userInfo:nil];
	@throw abstractMethodException;
}

+ (NSDictionary*)defaultPieceFrequencies
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

@end
