//
//  PetriGame.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriPlayer;
@class PetriBoard;
@class PetriGameRules;

/*!
 \brief Top-level object encapusating a Petri game.
 
 The PetriGame class is a wrapper around all objects related to a game and to game state, including the players participating, the board, and the rules.
 */
@interface PetriGame : NSObject
{
	NSArray* players;			/*!< The players participating in the game. Contains PetriPlayer objects. */
	PetriPlayer* currentPlayer;	/*!< The player whose turn it is. */
	PetriBoard* board;			/*!< The game board. */
	PetriGameRules* gameRules;	/*!< The rules for the game. */
}

/*!
 Creates a new game with the specified players and rules.
 
 @param playersInGame NSArray of player objects
 @param rules PetriGameRules object
 */
- (id)initWithPlayers:(NSArray*)playersInGame
			gameRules:(PetriGameRules*)rules;

@property (readonly) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readonly) PetriBoard* board;
@property (readonly) PetriGameRules* gameRules;

@end
