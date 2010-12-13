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

@interface PetriNetworkController : NSObject
{

}

- (void)updateCellId:(NSInteger)cellId
	  withNewOwnerId:(NSInteger)ownerId;

- (void)updateCellId:(NSInteger)cellId
		 withNewItem:(PetriItem*)item;

- (void)updateCellId:(NSInteger)cellId
	 withNewCellType:(PetriCellType)cellType;

- (void)updatePlayerWithId:(NSInteger)playerId
		  withAcquiredItem:(PetriItem*)item;

- (void)updatePlayerWithId:(NSInteger)playerId
			  withLostItem:(PetriItem*)item;

- (void)changeTurnToNewPlayerWithId:(NSInteger)playerId;

@end
