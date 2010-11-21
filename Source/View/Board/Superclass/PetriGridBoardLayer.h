//
//  PetriGridBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@class PetriGridBoard;

/*!
 \brief An abstract CALayer subclass used to display a PetriGridBoard.
 
 A PetriGridBoardLayer is resposible for the layout and display of a grid-based PetriBoard implementation.
 */
@interface PetriGridBoardLayer : PetriAspectRatioLayer
{
	PetriGridBoard* board;	/*!< A reference to the board this layer displays. */
	NSArray* cellSublayers;	/*!< A two-dimensional array used to organize the PetriBoardCellLayer sublayers which this object is resposible for laying out. Note that theser layers can also be accessed via the CALayer's \c sublayers property, but with less-useful positional information. */
}

/*!
 Initializes a new PetriGridBoardLayer with a reference to the specified board, and containing the specified two-dimensional array of PetriBoardCellLayer sublayers.
 
 \warning Do not invoke directly; instantiate a subclass instead.
 
 @param boardToDisplay The PetriGridBoard this layer will represent.
 @param cellLayers A two-dimensional array of PetriBoardCellLayers, to be added as sublayers of this layer.
 */
- (id)initWithBoard:(PetriGridBoard*)boardToDisplay
	  cellSublayers:(NSArray*)cellLayers;

@property (readonly) PetriGridBoard* board;
@property (readwrite, copy) NSArray* cellSublayers;

@end
