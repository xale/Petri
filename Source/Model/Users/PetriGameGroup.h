//
//  PetriGameGroup.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriUser;
@class PetriGameRules;
@class PetriGame;

/*!
 \brief Group of users gathered for a game.
 
 The PetriGameGroup class manages a group of human users who are preparing to play, are playing, or have finished playing a Petri game. PetriGameGroup instances are created when a player begins the process of starting a new game, either for local or network play (instances are not created for players joining remote games; these players are added to the group created by the game host.)
 
 Note that PetriGameGroup instances will never contain AI players as members: only human users are listed in the groups' users collection. AI players are added to games based on the game rules, which contains a "minimum players" value. If the number of human players in the group does not meet the required minumum players when a game is started, AI players are added to fill slots.
 */
@interface PetriGameGroup : NSObject
{
	NSArray* users;				/*!< List of (human) users who will participate in the game; may be local or remote. Contains PetriUser objects. */
	PetriUser* host;			/*!< User that created and manages this group. */
	PetriGameRules*	gameRules;	/*!< Rules used for games played by this group. May be changed by the host. */
	PetriGame* game;			/*!< Game in progress, if any. */
}

@property (readwrite, assign) NSArray* users;
@property (readwrite, assign) PetriUser* host;
@property (readwrite, assign) PetriGameRules* gameRules;
@property (readwrite, assign) PetriGame* game;

@end