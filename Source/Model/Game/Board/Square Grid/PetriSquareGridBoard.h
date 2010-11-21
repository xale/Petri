//
//  PetriSquareGridBoard.h
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridBoard.h"

@interface PetriSquareGridBoard : PetriGridBoard

/*!
 Override. Returns the cells laterally adjacent to (i.e., above, below, and to the left and right of) the specified location.
 
 @param location A location on the board around which to look for valid placement cells.
 */
- (NSSet*)placementCellsAdjacentToLocation:(PetriBoardLocation*)location;

/*!
 Override. Returns the cells laterally or diagonally adjacent to the specified location.
 
 @param location A location on the board around which to look for capturable cells.
 */
- (NSSet*)capturableCellsAdjacentToLocation:(PetriBoardLocation*)location;

@end
