//
//  PetriBoardCell.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCell.h"

@implementation PetriBoardCell

- (id)init
{
	cellType = unoccupiedCell;
	owner = nil;
	pickUp = nil;
	return self;
}

- (id)initWithCellType:(PetriCellType)type
				 owner:(PetriPlayer*)player
				pickUp:(PetriItem*)item
{
	cellType = type;
	owner = player;
	pickUp = item;
	return self;
}


#pragma mark -
#pragma mark Accessors

@synthesize cellType;
@synthesize owner;
@synthesize pickUp;

@end
