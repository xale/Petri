//
//  PetriGridBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoardLayer.h"

#import "PetriBoardCellLayer.h"

#import "PetriGridBoard.h"
#import "PetriBoardCell.h"

@implementation PetriGridBoardLayer

- (id)initWithBoard:(PetriGridBoard*)boardToDisplay
{
	// Check that we're not attempting to instantiate an abstract class
	if ([self isMemberOfClass:[PetriGridBoardLayer class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// Call CALayer -init
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Hold a reference to the board
	board = boardToDisplay;
	
	return self;
}

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

#pragma mark -
#pragma mark Accessors

@synthesize board;

@end
