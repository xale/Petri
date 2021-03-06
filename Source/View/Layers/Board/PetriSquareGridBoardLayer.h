//
//  PetriSquareGridBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/18/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardLayer.h"

#define PetriSquareGridBoardLayerCellSpacing	0.08
#define PetriSquareGridBoardLayerCellScale		(1.0 - PetriSquareGridBoardLayerCellSpacing)

@class PetriSquareGridBoard;

/*!
 \brief A concrete subclass of PetriBoardLayer for displaying a square-cell grid.
 
 The PetriSquareGridBoardLayer class is a CALayer subclass designed to display a PetriBoard laid out as a grid with square cells (note that the grid dimensions need not be square, this simply refers to the inter-cell arrangement; i.e., each cell borders exactly four neighbors.)
 */
@interface PetriSquareGridBoardLayer : PetriBoardLayer
{
	
}

/*!
 Override (with specialization.) Creates a new PetriSquareGridBoardLayer, displaying the specified board.
 
 @param boardToDisplay The PetriSquareGridBoard to display on this layer.
 */
- (id)initWithBoard:(PetriSquareGridBoard*)boardToDisplay;

@end
