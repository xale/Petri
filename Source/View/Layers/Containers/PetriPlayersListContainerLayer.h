//
//  PetriPlayersListContainerLayer.h
//  Petri
//
//  Created by Alex Heinz on 12/1/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriPlayer;

/*!
 \brief A CALayer subclass that displays the list of players on the gameplay view.
 */
@interface PetriPlayersListContainerLayer : CALayer
{
	NSArray* playersList;			/*!< The list of players whose status-info layers are displayed in this container. */
	PetriPlayer* selectedPlayer;	/*!< The player (in the list) whose turn it is. */
}

/*!
 Initializes a PetriPlayersListContainerLayer with the given list of players and starting current player.
 @param players The list of players displayed in this container.
 @param playerSlots The number total number of slots that the players in the list can occupy, which determines how much of the total space in the container that each status box occupies.
 @param startingPlayer The first player (in the list) to play; i.e., the current player on the first turn.
 */
- (id)initWithPlayersList:(NSArray*)players
			  playerSlots:(NSUInteger)playerSlots
		   selectedPlayer:(PetriPlayer*)startingPlayer;

@property (readonly) NSArray* playersList;
@property (readwrite, assign) PetriPlayer* selectedPlayer;

@end
