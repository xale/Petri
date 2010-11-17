//
//  PetriGridBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoardLayer.h"

#import "PetriBoardCellLayer.h"

#import "PetriBoard.h"
#import "PetriBoardCell.h"

@implementation PetriGridBoardLayer

+ (void)initialize
{
	// Expose a binding for the board property
	[self exposeBinding:@"board"];
}

- (id)init
{
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// FIXME: TESTING
	[self setBoard:[[PetriGridBoard alloc] initWithWidth:10
												  height:10]];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

NSString* const PetriBoardCellNameFormat =	@"cellAtX:%d Y:%d";

#define PETRI_BOARD_LAYER_CELL_SPACING		5.0

- (void)setBoard:(PetriGridBoard*)newBoard
{
	// Remove all current sublayers of the board
	[self setSublayers:nil];
	
	// Create the new sublayers for the cells on the board
	NSMutableArray* newCells = [NSMutableArray arrayWithCapacity:[newBoard width]];
	
	for (NSInteger x = 0; x < [newBoard width]; x++)
	{
		NSMutableArray* newColumn = [NSMutableArray arrayWithCapacity:[newBoard height]];
		
		for (NSInteger y = 0; y < [newBoard height]; y++)
		{	
			// Create a new layer for each cell of the board, bound to properties of the appropriate cell of the board
			// FIXME: TESTING
			//PetriBoardCellLayer* newLayer = [PetriBoardCellLayer boardCellLayerBoundToCell:[newBoard cellAtX:x Y:y]];
			CALayer* newLayer = [CALayer layer];
			
			// Name the layer based on its location, for reference by the layout manager
			[newLayer setName:[NSString stringWithFormat:PetriBoardCellNameFormat, x, y]];
			
			// FIXME: add a border so we can see the layer during testing
			[newLayer setBorderWidth:1.0];
			[newLayer setBorderColor:CGColorGetConstantColor(kCGColorWhite)];
			
			// Add the layer to the collection of cell layers
			[newColumn addObject:newLayer];
			
			// Add constraints on the layer's position and size
			// Size: divide board layer equally, leaving space between cells
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															   relativeTo:@"superlayer"
																attribute:kCAConstraintHeight
																	scale:(1.0 / [newBoard height])
																   offset:-PETRI_BOARD_LAYER_CELL_SPACING]];
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															   relativeTo:@"superlayer"
																attribute:kCAConstraintWidth
																	scale:(1.0 / [newBoard width])
																   offset:-PETRI_BOARD_LAYER_CELL_SPACING]];
			
			// Position: relative to previous neighbor in each directly
			if (x == 0)
			{
				// Leftmost cells constrained to follow left edge of board
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintMinX
																		scale:1.0
																	   offset:(PETRI_BOARD_LAYER_CELL_SPACING / 2)]];
			}
			else
			{
				// All other cells are constrained by the edges of their neighbors
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																   relativeTo:[NSString stringWithFormat:PetriBoardCellNameFormat, (x - 1), y]
																	attribute:kCAConstraintMaxX
																		scale:1.0
																	   offset:PETRI_BOARD_LAYER_CELL_SPACING]];
			}
			
			if (y == 0)
			{
				// Bottom cells constrained to follow bottom edge of board
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinY
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintMinY
																		scale:1.0
																	   offset:(PETRI_BOARD_LAYER_CELL_SPACING / 2)]];
			}
			else
			{
				// All other cells are constrained by the edges of their neighbors
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinY
																   relativeTo:[NSString stringWithFormat:PetriBoardCellNameFormat, x, (y - 1)]
																	attribute:kCAConstraintMaxY
																		scale:1.0
																	   offset:PETRI_BOARD_LAYER_CELL_SPACING]];
			}
			
			// Add the layer to the board's sublayers
			[self addSublayer:newLayer];
		}
		
		// Add each column to the collection of cell layers
		[newCells addObject:newColumn];
	}
	
	// Hold a reference to the new cells
	cellSublayers = newCells;
	
	// Mark the board layer for re-layout
	[self setNeedsLayout];
	 
	// Hold a reference to the new board
	board = newBoard;
}
@synthesize board;

@end
