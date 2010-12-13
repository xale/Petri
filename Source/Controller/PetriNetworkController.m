//
//  PetriNetworkController.m
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNetworkController.h"
#import "PetriPlayer.h"
#import "PetriGameGroup.h"
#import "PetriGame.h"
#import "PetriBoard.h"
#import "PetriBoardCell.h"

@implementation PetriNetworkController

- (void)updateCellId:(NSInteger)cellId
	  withNewOwnerId:(NSInteger)ownerId
{
	PetriGame* myGame = [[self gameGroup] game];
	[[[myGame board] cellById:cellId] setOwner:[myGame playerById:ownerId]];
}

- (void)updateCellId:(NSInteger)cellId
		 withNewItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	NSLog(@"FIXME: not implemented.");
	//[[[myGame board] cellById:cellId] setItem:item];
}

- (void)updateCellId:(NSInteger)cellId
	 withNewCellType:(PetriCellType)cellType
{
	PetriGame* myGame = [[self gameGroup] game];
	[[[myGame board] cellById:cellId] setCellType:cellType];
}

- (void)updatePlayerWithId:(NSInteger)playerId
		  withAcquiredItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	[[myGame playerById:playerId] addItemsObject:item];
}

- (void)updatePlayerWithId:(NSInteger)playerId
			  withLostItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	[[myGame playerById:playerId] removeItemsObject:item];
}

- (void)changeTurnToNewPlayerWithId:(NSInteger)playerId
{
	PetriGame* myGame = [[self gameGroup] game];
	[myGame setCurrentPlayer:[myGame playerById:playerId]];
}
@end
