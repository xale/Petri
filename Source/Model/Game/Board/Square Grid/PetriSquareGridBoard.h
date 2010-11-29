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
 Override. Checks if a piece can be placed on the board.
 @param piece piece to place
 @param owner player placing the piece
 @param pieceOrigin the coordinates to place the piece's origin
 @return true if the piece can be placed
 */
- (BOOL)validatePlacementOfPiece:(PetriGridPiece*)piece
					   withOwner:(PetriPlayer*)owner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin;

/*!
 Override. Runs every time a piece is placed and performs all captures that are possible
 recursively until no more captures are available
 */
- (void)capture;

@end
