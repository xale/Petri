//
//  PeteriNetworkServerController.h
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PeteriNetworkServerController : NSObject
{

}

- (void)listenOnPort(NSInteger port);

- (void)startGameWithSerializedBoard:(NSData*)serializedBoard;

- (void)onCellWithId:(NSInteger)cellId
		 updateOwner:(NSInteger)newOwnerId
		  updateItem:(PetriItem*)item
	  updateCellType:(PetriCellType)type;

- (void)forPlayerWithId:(NSInteger)playerId
		   acquiredItem:(PetriItem*)itemAcquired
			   lostItem:(PetriItem*)itemLost;

- (void)changeTurnToPlayerWithId:(NSInteger)playerId;

@end
