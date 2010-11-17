//
//  PetriGridBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriBoard;

/*!
 \brief An abstract CALayer subclass used to display a PetriGridBoard.
 
 A PetriGridBoardLayer is resposible for the layout and display of a grid-based PetriBoard implementation.
 */
@interface PetriGridBoardLayer : CALayer
{
	PetriGridBoard* board;	/*!< A reference to the board this layer displays. */
	NSArray* cellSublayers;	/*!< A two-dimensional array used to organize the PetriBoardCellLayer sublayers which this object is resposible for laying out. Note that theser layers can also be accessed via the CALayer's \c sublayers property, but with less-useful positional information. */
}

@property (readwrite, assign) PetriGridBoard* board;

@end
