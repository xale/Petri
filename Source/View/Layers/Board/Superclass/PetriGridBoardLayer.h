//
//  PetriGridBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriGridBoard;

/*!
 \brief An abstract CALayer subclass used to display a PetriGridBoard.
 
 A PetriGridBoardLayer is resposible for the layout and display of a grid-based PetriBoard implementation.
 */
@interface PetriGridBoardLayer : CALayer
{
	PetriGridBoard* board;	/*!< A reference to the board this layer displays. */
}

/*!
 Initializes a new PetriGridBoardLayer with a reference to the specified board, and containing the specified two-dimensional array of PetriBoardCellLayer sublayers.
 
 \warning Do not invoke directly; instantiate a subclass instead.
 
 @param boardToDisplay The PetriGridBoard this layer will represent.
 */
- (id)initWithBoard:(PetriGridBoard*)boardToDisplay;

@property (readonly) PetriGridBoard* board;

@end
