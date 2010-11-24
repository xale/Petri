//
//  PetriSquareGridBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/18/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoardLayer.h"

#import "PetriBoardCellLayer.h"

#import "PetriSquareGridBoard.h"

/*!
 Private methods on PetriSquareGridBoardLayer.
 */
@interface PetriSquareGridBoardLayer(Private)

/*!
 Returns an aspect ratio for the layer based on a Square Grid Board's dimensions.
 @param displayBoard The board this layer will display; the resulting aspect ratio will be the board's \c width divided by its \c height.
 */
- (CGFloat)aspectRatioForBoard:(PetriSquareGridBoard*)displayBoard;

/*!
 Generates the two-dimensional array of cell sublayers for the given board.
 @param boardForCells The board whose cells will be represented by the generated sublayers; sublayers' appearances will be bound to properties of this board's cells.
 */
- (void)createCellSublayersForSquareBoard:(PetriSquareGridBoard*)boardForCells;

@end

@implementation PetriSquareGridBoardLayer

- (id)initWithBoard:(PetriSquareGridBoard*)boardToDisplay
{
	if (![super initWithBoard:boardToDisplay aspectRatio:[self aspectRatioForBoard:boardToDisplay]])
		return nil;
	
	// Lay out the cells of the board
	[self createCellSublayersForSquareBoard:boardToDisplay];
	
	return self;
}

#pragma mark -
#pragma mark Layout

- (CGFloat)aspectRatioForBoard:(PetriSquareGridBoard*)displayBoard
{
	return ((CGFloat)[displayBoard width] / (CGFloat)[displayBoard height]);
}

- (void)createCellSublayersForSquareBoard:(PetriSquareGridBoard*)boardForCells
{
	// Create a grid of Board Cell Layer sublayers
	for (NSInteger x = 0; x < [boardForCells width]; x++)
	{
		for (NSInteger y = 0; y < [boardForCells height]; y++)
		{
			// Create a new layer for each cell of the board, bound to properties of the appropriate cell of the board
			PetriBoardCellLayer* newLayer = [PetriBoardCellLayer boardCellLayerBoundToCell:[boardForCells cellAtX:x Y:y]];
			
			// Add constraints on the layer's position and size
			// Size: divide board layer equally, leaving a small amount of space between cells
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															   relativeTo:@"superlayer"
																attribute:kCAConstraintWidth
																	scale:(0.95 / [boardForCells width])
																   offset:0]];
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															   relativeTo:@"superlayer"
																attribute:kCAConstraintHeight
																	scale:(0.95 / [boardForCells height])
																   offset:0]];
			
			// Position: spaced evenly across the board's width and height
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidX
															   relativeTo:@"superlayer"
																attribute:kCAConstraintWidth
																	scale:((x + 0.5) / [boardForCells width])
																   offset:0]];
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
															   relativeTo:@"superlayer"
																attribute:kCAConstraintHeight
																	scale:((y + 0.5) / [boardForCells height])
																   offset:0]];
			
			// Add the layer to this layer's sublayers
			[self addSublayer:newLayer];
		}
	}
}

@end
