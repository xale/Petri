//
//  PetriPiece.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPiece.h"


@implementation PetriPiece

- (id)init
{
	cellLocations = [NSSet setWithObjects:
					 [PetriBoardLocation locationWithX:0 Y:0],
					 [PetriBoardLocation locationWithX:1 Y:0],
					 [PetriBoardLocation locationWithX:2 Y:0],
					 [PetriBoardLocation locationWithX:3 Y:0],
					 nil];
	return self;
}

- (id)initWithCellLocations:NSSet
{
	cellLocations = [NSSet setWithObjects:
					 [PetriBoardLocation locationWithX:0 Y:0],
					 [PetriBoardLocation locationWithX:1 Y:0],
					 [PetriBoardLocation locationWithX:2 Y:0],
					 [PetriBoardLocation locationWithX:3 Y:0],
					 nil];
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize cellLocations;

@end
