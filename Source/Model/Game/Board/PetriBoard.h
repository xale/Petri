//
//  PetriBoard.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief Object representing a Petri game board.
 
 The PetriBoard class is a container for a collection of PetriBoardCell objects, representing the contents of the board during a game.
 */
@interface PetriBoard : NSObject
{
	NSArray* cells;	/*!< Two-dimensional grid of PetriBoardCell objects representing the contents of the board. */
}

@end
