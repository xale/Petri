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
@class PetriItem;

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
	BOOL inCaptureBatch;
	BOOL inClearBatch;
	BOOL gameOver;
}

/*!
 Retrns a player with a given id
 
 @param ID id of player to return
 */
- (PetriPlayer*)playerByID:(NSInteger)ID;


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
 Tells the game to perform all available captures on the board, batching each step of the captures in a capture transaction by raising and lowering the \c inCaptureBatch flag.
 Should be called after a piece is placed but before -clearDeadCells and -nextTurn.
 */
- (void)performCapturesForCurrentPlayer;

/*!
 Tells the board to remove dead cells.
 Should be called after the piece has been placed and all captures have occurred, but before nextTurn is called.
 */
- (void)clearDeadCells;

- (void)useItem:(PetriItem*)item
		onCells:(NSArray*)cells
		 pieces:(NSArray*)pieces
		players:(NSArray*)targetPlayers
	   byPlayer:(PetriPlayer*)usingPlayer;

@property (readonly) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readonly) id<PetriBoard>  board;
@property (readonly) PetriGameConfiguration* gameConfiguration;
@property (readonly) id<PetriPiece> currentPiece;
@property (readwrite, getter=isInCaptureBatch) BOOL inCaptureBatch;
@property (readwrite, getter=isInClearBatch) BOOL inClearBatch;
@property (readonly, getter=isGameOver) BOOL gameOver;


@end
