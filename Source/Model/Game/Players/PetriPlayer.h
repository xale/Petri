//
//  PetriPlayer.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardCell;
@class PetriItem;

/*!
 \brief Object representing a player in a Petri game.
 
 PetriPlayer is an abstract class representing a participant in a Petri game, storing the player's items and other status information.
 */
@interface PetriPlayer : NSObject <NSCoding>
{
	NSInteger playerID;				/*!< A unique per-game identifier. */
	NSMutableDictionary* items;		/*!< The items currently possessed by the player. Maps PetriItem to NSNumber; i.e., item type to quantity. */
	NSMutableSet* controlledCells;	/*!< The set of cells curently controlled by the player. */
	NSUInteger controlPercentage;	/*!< The percentage of the board that this player controls, rounded to the nearest integer. */
	NSColor* color;					/*!< The player's color. */
}

/*!
 Initializes a PetriPlayer object with the specified unique identifier and color.
 \warning Do not invoke directly; instantiate a subclass instead.
 @param ID The new player's unique identifier.
 @param playerColor The new player's color.
 */
- (id)initWithPlayerID:(NSInteger)ID
				 color:(NSColor*)playerColor;

/*!
 Compares two players based on \c playerID.
 */
- (BOOL)isEqualToPlayer:(PetriPlayer*)otherPlayer;

/*!
 Gives the player the item.
 */
- (void)addItemsObject:(PetriItem*)item;

/*!
 Takes the players item; e.g. after use.
 */
- (void)removeItemsObject:(PetriItem*)item;

/*!
 Adds a cell to the list of cells controlled by the player.

 @param cell the PetriBoardCell that the player now controls
 */
- (void)addControlledCellsObject:(PetriBoardCell*)cell;

/*!
 Adds a set of cells to the list of cells controlled by the player.
 
 @param cells the set of cells that the player now controls
 */
- (void)addControlledCells:(NSSet*)cells;

/*!
 Removes a cell from the list of cells controlled by the player.
 
 @param cell the PetriBoardCell that the player no longer controls
 */
- (void)removeControlledCellsObject:(PetriBoardCell*)cell;

/*!
 Remove a set of cells to the list of cells controlled by the player.
 
 @param cells the set of cells that the player does not control
 */
- (void)removeControlledCells:(NSSet*)cells;

/*!
 Returns an enumerator for the cells controlled by the player.
 */
- (NSEnumerator*)enumeratorOfControlledCells;

/*!
 Checks whether the player controlls a given cell. Returns the cell if s/he does and nil otherwise.
 @param cell the cell to check membership of
 */
- (PetriBoardCell*)memberOfControlledCells:(PetriBoardCell*)cell;

/*!
 Returns the number of cells controlled by player.
 */
- (NSUInteger)countOfControlledCells;

@property (readonly) NSInteger playerID;

/*!
 Returns immutable copy of items dictionary.
 */
@property (readonly) NSDictionary* items;
/*!
 Returns immutable copy of controlledCells set.
 */
@property (readonly) NSSet* controlledCells;
@property (readwrite, assign) NSUInteger controlPercentage;
@property (readwrite, copy) NSColor* color;

@end
