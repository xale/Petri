//
//  PetriPlayer.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief Object representing a player in a Petri game.
 
 PetriPlayer is an abstract class representing a participant in a Petri game, storing the player's items and other status information.
 */
@interface PetriPlayer : NSObject
{
	NSInteger cellsControlled;	/*!< The number of cells on the board that the player currently controls. */
	NSMutableDictionary* items;	/*!< The items currently possessed by the player. Maps PetriItem to NSNumber; i.e., item type to quantity. */
}

@property (readwrite) NSInteger cellsControlled;
@property (readwrite, copy) NSMutableDictionary* items;

@end
