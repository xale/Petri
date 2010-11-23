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

@synthesize cellCoordinates;

@end
