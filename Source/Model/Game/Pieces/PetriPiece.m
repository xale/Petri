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
	cellLocations = [NSSet setWithObjects:
					 [Petri2DCoordinates coordinatesWithHorizontalCoordinate:0 verticalCoordinate:0],
					 [Petri2DCoordinates coordinatesWithHorizontalCoordinate:0 verticalCoordinate:1],
					 [Petri2DCoordinates coordinatesWithHorizontalCoordinate:1 verticalCoordinate:1],
					 [Petri2DCoordinates coordinatesWithHorizontalCoordinate:1 verticalCoordinate:2],
					 nil];
	return self;
}

- (id)initWithCellLocations:(NSSet*)locations
{
	cellLocations = locations;
	return self;
}

- (PetriPiece*)pieceRotatedClockwise
{
	NSMutableSet* newLocations = [NSMutableSet setWithCapacity:[cellLocations count]];
	for (Petri2DCoordinates* location in cellLocations)
	{
		[newLocations addObject:[location rotatedClockwise]];
	}
	
	return [[PetriPiece alloc] initWithCellLocations:[newLocations copy]];
}

- (PetriPiece*)pieceRotatedCounterclockwise
{
	NSMutableSet* newLocations = [NSMutableSet setWithCapacity:[cellLocations count]];
	for (Petri2DCoordinates* location in cellLocations)
	{
		[newLocations addObject:[location rotatedCounterClockwise]];
	}
	
	return [[PetriPiece alloc] initWithCellLocations:[newLocations copy]];
}

#pragma mark -
#pragma mark Accessors

@synthesize cellLocations;

@end
