//
//  PetriNetworkController.m
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNetworkController.h"


@implementation PetriNetworkController

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}


/*!
 Changes the owner on the cell with the given ID
 
 @param cellId id of cell to update owner on
 @param ownerId id of new owner of cell
 */
- (void)updateCellId:(NSInteger)cellId
	  withNewOwnerId:(NSInteger)ownerId
{
}

/*!
 Changes the item on the cell with the given ID
 
 @param cellId id of cell to change pickup on
 @param item serialized item to add as a pickup on the given cell, or nil to clear pickup
 */
- (void)updateCellId:(NSInteger)cellId
		 withNewItem:(PetriItem*)item
{
}

/*!
 Changes the type of the cell with the given ID
 
 @param cellId id of cell to change type of
 @param cellType new celltype
 */
- (void)updateCellId:(NSInteger)cellId
	 withNewCellType:(PetriCellType)cellType
{
}

/*!
 Gives an item to the player with the given ID
 
 @param playerId id of player to give item to
 @param item serialized item to give to player
 */
- (void)updatePlayerWithId:(NSInteger)playerId
		  withAcquiredItem:(PetriItem*)item
{
}

/*!
 Takes an item from the player with the given ID
 
 @param playerId id of player to take item from
 @param item serialized item to take from player
 */
- (void)updatePlayerWithId:(NSInteger)playerId
			  withLostItem:(PetriItem*)item
{
}

/*!
 Changes the turn to the player with a given playerId
 
 @param playerId playerId of player whose turn it is
 */
- (void)changeTurnToNewPlayerWithId:(NSInteger)playerId
{
}

@synthesize gameGroup;
@end
