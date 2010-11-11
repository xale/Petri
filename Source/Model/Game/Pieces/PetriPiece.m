//
//  PetriPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPiece.h"
#import "PetriBoardLocation.h"

@implementation PetriPiece

- (id)init
{
	cellLocations = [NSSet setWithObjects:
					 [PetriBoardLocation locationWithX:0 Y:0],
					 [PetriBoardLocation locationWithX:0 Y:1],
					 [PetriBoardLocation locationWithX:1 Y:1],
					 [PetriBoardLocation locationWithX:1 Y:2],
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
	for (PetriBoardLocation* location in cellLocations)
	{
		[newLocations addObject:[location locationRotatedClockwiseAboutOrigin]];
	}
	
	return [[PetriPiece alloc] initWithCellLocations:[newLocations copy]];
}

- (PetriPiece*)pieceRotatedCounterclockwise
{
	NSMutableSet* newLocations = [NSMutableSet setWithCapacity:[cellLocations count]];
	for (PetriBoardLocation* location in cellLocations)
	{
		[newLocations addObject:[location locationRotatedCounterclockwiseAboutOrigin]];
	}
	
	return [[PetriPiece alloc] initWithCellLocations:[newLocations copy]];
}

#pragma mark -
#pragma mark Accessors

@synthesize cellLocations;

@end
