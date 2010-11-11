//
//  PetriBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief a CALayer subclass used to display a PetriBoard.
 
 A PetriBoardLayer is resposible for the layout and display of a collection of PetriBoardCellLayer sublayers, which in turn display the state of cells on the board during a game.
 */
@interface PetriBoardLayer : CALayer
{
	NSArray* cellSublayers;	/*!< A two-dimensional array used to organize the PetriBoardCellLayer sublayers which this object is resposible for laying out. Note that theser layers can also be accessed via the CALayer's \c sublayers property, but with less-useful positional information. */
}

@end
