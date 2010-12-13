//
//  PetriNetworkController.h
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PetriItem.h"
#import "PetriCellType.h"
#import "PetriGameGroup.h"

/*!
 Abstract superclass for RPC interface on network controller objects
 */
@interface PetriNetworkController : NSObject
{
	PetriGameGroup* gameGroup;
}

/*!
 Constructor throws an exception.  Don't use it.
 */
- (id)init;

/*!
 Changes the owner on the cell with the given ID
 
 @param cellID id of cell to update owner on
 @param ownerID id of new owner of cell
 */
- (void)updateCellID:(NSInteger)cellID
	  withNewOwnerID:(NSInteger)ownerID;

/*!
 Changes the item on the cell with the given ID
 
 @param cellID id of cell to change pickup on
 @param item serialized item to add as a pickup on the given cell, or nil to clear pickup
 */
- (void)updateCellID:(NSInteger)cellID
		 withNewItem:(PetriItem*)item;

/*!
 Changes the type of the cell with the given ID
 
 @param cellID id of cell to change type of
 @param cellType new celltype
 */
- (void)updateCellID:(NSInteger)cellID
	 withNewCellType:(PetriCellType)cellType;

/*!
 Gives an item to the player with the given ID
 
 @param playerID id of player to give item to
 @param item serialized item to give to player
 */
- (void)updatePlayerWithID:(NSInteger)playerID
		  withAcquiredItem:(PetriItem*)item;

/*!
 Takes an item from the player with the given ID
 
 @param playerID id of player to take item from
 @param item serialized item to take from player
 */
- (void)updatePlayerWithID:(NSInteger)playerID
			  withLostItem:(PetriItem*)item;

/*!
 Changes the turn to the player with a given playerID
 
 @param playerID playerID of player whose turn it is
 */
- (void)changeTurnToNewPlayerWithID:(NSInteger)playerID;

@property (readonly) PetriGameGroup* gameGroup;

@end
