//
//  PetriSquareGridBoard.h
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoard.h"

/**
 * Concrete implementation of PetriGridBoard for boards with square grid layouts
 */
@interface PetriSquareGridBoard : PetriGridBoard

/*!
 Override. Sets up the board with heads as appropriate for a rectangular board.
 */
- (id)initWithWidth:(NSInteger)boardWidth
			 height:(NSInteger)boardHeight;

/*!
 Override. Returns the cells laterally adjacent to (i.e., above, below, and to the left and right of) the cell at the specified coordinates.
 @param cellCoordinates The coordinates of a cell on the board around which to look for valid placement cells.
 */
- (NSSet*)placementCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates;

/*!
 Override. Returns the cells laterally or diagonally adjacent to the cell at the specified coordinates.
 @param cellCoordinates The coordinates of a cell on the board around which to look for capturable cells.
 */
- (NSSet*)capturableCellsAdjacentToCoordinates:(Petri2DCoordinates*)cellCoordinates;

/*!
 Override. Runs every time a piece is placed and performs all captures that are possible
 recursively until no more captures are available
 */
- (void)capture;

@end
