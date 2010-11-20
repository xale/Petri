//
//  PetriSquareGridBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/18/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoardLayer.h"

#import "PetriGridBoard.h"

/*!
 Private methods on PetriSquareGridBoardLayer.
 */
@interface PetriSquareGridBoardLayer(Private)

/*!
 Generates the two-dimensional array of cell sublayers for the given board.
 
 @param boardForCells The board whose cells will be represented by the generated sublayers; sublayers' appearances will be bound to properties of this board's cells.
 */
- (NSArray*)cellSublayersForSquareBoard:(PetriGridBoard*)boardForCells;

@end

@implementation PetriSquareGridBoardLayer

- (id)initWithBoard:(PetriGridBoard*)boardToDisplay
{
	if (![super initWithBoard:boardToDisplay cellSublayers:[self cellSublayersForSquareBoard:boardToDisplay]])
		return nil;
	
	return self;
}

#pragma mark -
#pragma mark Sublayer Layout

NSString* const PetriBoardCellNameFormat =	@"cellAtX:%d Y:%d";
#define PETRI_SQUARE_BOARD_LAYER_CELL_SPACING		5.0

- (NSArray*)cellSublayersForSquareBoard:(PetriGridBoard*)boardForCells
{
	// Create a two-dimensional array of cell sublayers for the cells on the board
	NSMutableArray* newCells = [NSMutableArray arrayWithCapacity:[boardForCells width]];
	
	for (NSInteger x = 0; x < [boardForCells width]; x++)
	{
		NSMutableArray* newColumn = [NSMutableArray arrayWithCapacity:[boardForCells height]];
		
		for (NSInteger y = 0; y < [boardForCells height]; y++)
		{	
			// Create a new layer for each cell of the board, bound to properties of the appropriate cell of the board
			// FIXME: TESTING
			//PetriBoardCellLayer* newLayer = [PetriBoardCellLayer boardCellLayerBoundToCell:[boardForCells cellAtX:x Y:y]];
			CALayer* newLayer = [CALayer layer];
			
			// Name the layer based on its location, for reference by the layout manager
			[newLayer setName:[NSString stringWithFormat:PetriBoardCellNameFormat, x, y]];
			
			// FIXME: TESTING add a border so we can see the layer during testing
			[newLayer setBorderWidth:1.0];
			[newLayer setBorderColor:CGColorGetConstantColor(kCGColorWhite)];
			
			// Add the layer to the collection of cell layers
			[newColumn addObject:newLayer];
			
			// Add constraints on the layer's position and size
			// Size: divide board layer equally, leaving space between cells
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															   relativeTo:@"superlayer"
																attribute:kCAConstraintHeight
																	scale:(1.0 / [boardForCells height])
																   offset:-PETRI_SQUARE_BOARD_LAYER_CELL_SPACING]];
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															   relativeTo:@"superlayer"
																attribute:kCAConstraintWidth
																	scale:(1.0 / [boardForCells width])
																   offset:-PETRI_SQUARE_BOARD_LAYER_CELL_SPACING]];
			
			// Position: relative to previous neighbor in each direction
			if (x == 0)
			{
				// Leftmost cells constrained to follow left edge of board
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintMinX
																	   offset:(PETRI_SQUARE_BOARD_LAYER_CELL_SPACING / 2)]];
			}
			else
			{
				// All other cells are constrained by the edges of their neighbors
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																   relativeTo:[NSString stringWithFormat:PetriBoardCellNameFormat, (x - 1), y]
																	attribute:kCAConstraintMaxX
																	   offset:PETRI_SQUARE_BOARD_LAYER_CELL_SPACING]];
			}
			
			if (y == 0)
			{
				// Bottom cells constrained to follow bottom edge of board
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinY
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintMinY
																	   offset:(PETRI_SQUARE_BOARD_LAYER_CELL_SPACING / 2)]];
			}
			else
			{
				// All other cells are constrained by the edges of their neighbors
				[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinY
																   relativeTo:[NSString stringWithFormat:PetriBoardCellNameFormat, x, (y - 1)]
																	attribute:kCAConstraintMaxY
																	   offset:PETRI_SQUARE_BOARD_LAYER_CELL_SPACING]];
			}
		}
		
		// Add each column to the collection of cell layers
		[newCells addObject:[newColumn copy]];
	}
	
	return [newCells copy];
}

@end
