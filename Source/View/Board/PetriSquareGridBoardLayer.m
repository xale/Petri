//
//  PetriSquareGridBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/18/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoardLayer.h"

#import "PetriSquareGridBoard.h"

/*!
 Private methods on PetriSquareGridBoardLayer.
 */
@interface PetriSquareGridBoardLayer(Private)

/*!
 Generates the two-dimensional array of cell sublayers for the given board.
 
 @param boardForCells The board whose cells will be represented by the generated sublayers; sublayers' appearances will be bound to properties of this board's cells.
 */
- (NSArray*)cellSublayersForSquareBoard:(PetriSquareGridBoard*)boardForCells;

@end

@implementation PetriSquareGridBoardLayer

- (id)initWithBoard:(PetriSquareGridBoard*)boardToDisplay
{
	if (![super initWithBoard:boardToDisplay cellSublayers:[self cellSublayersForSquareBoard:boardToDisplay]])
		return nil;
	
	return self;
}

#pragma mark -
#pragma mark Sublayer Layout

NSString* const PetriBoardCellNameFormat =	@"cellAtX:%d Y:%d";

- (NSArray*)cellSublayersForSquareBoard:(PetriSquareGridBoard*)boardForCells
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
			
			// FIXME: TESTING: add a background for visibility
			[newLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.8)];
			
			// Add the layer to the collection of cell layers
			[newColumn addObject:newLayer];
			
			// Add constraints on the layer's position and size
			// Size: divide board layer equally, leaving space between cells
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															   relativeTo:@"superlayer"
																attribute:kCAConstraintWidth
																	scale:(0.9 / [boardForCells width])
																   offset:0]];
			[newLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															   relativeTo:@"superlayer"
																attribute:kCAConstraintHeight
																	scale:(0.9 / [boardForCells height])
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
		}
		
		// Add each column to the collection of cell layers
		[newCells addObject:[newColumn copy]];
	}
	
	return [newCells copy];
}

@end
