//
//  PetriPlayer.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardCell;

/*!
 \brief Object representing a player in a Petri game.
 
 PetriPlayer is an abstract class representing a participant in a Petri game, storing the player's items and other status information.
 */
@interface PetriPlayer : NSObject
{
	NSMutableDictionary* items;		/*!< The items currently possessed by the player. Maps PetriItem to NSNumber; i.e., item type to quantity. */
	NSMutableSet* controlledCells;	/*!< The set of cells curently controlled by the player. */
}

/*!
 Adds a cell to the list of cells controlled by the player.

 @param cell the PetriBoardCell that the player now controls
 */
- (void)addControlledCellsObject:(PetriBoardCell*)cell;

/*!
 Returns the number of cells controlled by player.
 */
- (NSInteger)countOfControlledCells;

/*!
 Returns immutable copy of items dictionary.
 */
@property (readonly, copy) NSDictionary* items;

@end
