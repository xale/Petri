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

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (void)updateCellID:(NSInteger)cellID
	  withNewOwnerID:(NSInteger)ownerID
{
	PetriGame* myGame = [[self gameGroup] game];
	[[[myGame board] cellByID:cellID] setOwner:[myGame playerByID:ownerID]];
}

- (void)updateCellID:(NSInteger)cellID
		 withNewItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	NSLog(@"FIXME: not implemented.");
	//[[[myGame board] cellByID:cellID] setItem:item];
}

- (void)updateCellID:(NSInteger)cellID
	 withNewCellType:(PetriCellType)cellType
{
	PetriGame* myGame = [[self gameGroup] game];
	[[[myGame board] cellByID:cellID] setCellType:cellType];
}

- (void)updatePlayerWithID:(NSInteger)playerID
		  withAcquiredItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	[[myGame playerByID:playerID] addItemsObject:item];
}

- (void)updatePlayerWithID:(NSInteger)playerID
			  withLostItem:(PetriItem*)item
{
	PetriGame* myGame = [[self gameGroup] game];
	[[myGame playerByID:playerID] removeItemsObject:item];
}

- (void)changeTurnToNewPlayerWithID:(NSInteger)playerID
{
	PetriGame* myGame = [[self gameGroup] game];
	[myGame setCurrentPlayer:[myGame playerByID:playerID]];
}

@synthesize gameGroup;
@end
