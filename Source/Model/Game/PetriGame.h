//
//  PetriGame.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriPlayer;
@class PetriGameConfiguration;

@protocol PetriBoard;
@protocol PetriPiece;

/*!
 \brief Top-level object encapusating a Petri game.
 
 The PetriGame class is a wrapper around all objects related to a game and to game state, including the players participating, the board, and the rules.
 */
@interface PetriGame : NSObject
{
	NSArray* players;	/*!< The players participating in the game. Contains PetriPlayer objects. */
	PetriPlayer* currentPlayer;	/*!< The player whose turn it is. */
	id<PetriBoard> board;			/*!< The game board. */
	PetriGameConfiguration* gameConfiguration;	/*!< The rules for the game. */
	id<PetriPiece> currentPiece; /*!< The piece available for use on the current player's move. */
}

/*!
 Creates a new game with the specified players and rules.
 @param playersInGame NSArray of player objects
 @param configuration The configuration specifying the layout of the game board, piece frequencies, etc.
 */
- (id)initWithPlayers:(NSArray*)playersInGame
	gameConfiguration:(PetriGameConfiguration*)configuration;

/*!
 Updates the value of the current piece and the current player.
 */
- (void)nextTurn;

/*!
 Rotates (clockwise) the current piece.
 */
- (void)rotateCurrentPiece;

/*!
 Tells the board to capture cells for the current player.
 Should be called after the player has placed a piece but before nextTurn is called.
 */
- (void)performCapturesForCurrentPlayer;

/*!
 Tells the board to capture cells for players other than the current player.
 Should be called after player has placed a piece and after his/her captures have occurred, but before nextTurn is called.
 */
- (void)performAdditionalCaptures;

/*!
 Tells the board to remove dead cells.
 Should be called after the piece has been placed and all captures have occurred, but before nextTurn is called.
 */
- (void)clearDeadCells;

@property (readonly) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readonly) id<PetriBoard>  board;
@property (readonly) PetriGameConfiguration* gameConfiguration;
@property (readonly) id<PetriPiece> currentPiece;

@end
