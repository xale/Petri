//
//  PetriGame.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriPlayer;
@class PetriGridBoard;
@class PetriGameConfiguration;

@protocol PetriBoard;

/*!
 \brief Top-level object encapusating a Petri game.
 
 The PetriGame class is a wrapper around all objects related to a game and to game state, including the players participating, the board, and the rules.
 */
@interface PetriGame : NSObject
{
	NSMutableArray* players;	/*!< The players participating in the game. Contains PetriPlayer objects. */
	PetriPlayer* currentPlayer;	/*!< The player whose turn it is. */
	id<PetriBoard> board;			/*!< The game board. */
	PetriGameConfiguration* gameConfiguration;	/*!< The rules for the game. */
}

/*!
 Creates a new game with the specified players and rules.

 @param playersInGame NSArray of player objects
 @param configuration The configuration specifying the layout of the game board, piece frequencies, etc.
 */
- (id)initWithPlayers:(NSArray*)playersInGame
			gameRules:(PetriGameConfiguration*)configuration;

/*!
 Adds a player object to a game.

 @param player PetriPlayer object
 */
- (void)addPlayersObject:(PetriPlayer*)player;

/*!
 Returns an immutable copy of players.
 */
@property (readonly) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readonly) id<PetriBoard>  board;
@property (readonly) PetriGameConfiguration* gameConfiguration;

@end
