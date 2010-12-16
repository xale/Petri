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
@class PetriBoardCell;

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
	BOOL inCaptureBatch; /*!< In batch of cells queued for capture. */
	BOOL inClearBatch; /*!< In batch of cells queued to be cleared. */
	BOOL gameOver; /*!< Game is over because all opposing players have been elimanted. */
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

/*!
 Use an item that a player possess on cells, pieces, or target players
 
 @param item item to use
 @param cells cells to use item on
 @param pieces pieces to use item on
 @param targetPlayers players targeted by item
 @param usingPlayer player using the item
 */
- (void)useItem:(PetriItem*)item
		onCells:(NSArray*)cells
		 pieces:(NSArray*)pieces
		players:(NSArray*)targetPlayers
	   byPlayer:(PetriPlayer*)usingPlayer;

/*!
 Place piece for a specific player on a specific cell
 
 @param piece piece to place
 @param pieceOwner owner of the new piece to place
 @param cell cell to place piece on
 */
- (void)placePiece:(id<PetriPiece>)piece
         forPlayer:(PetriPlayer*)pieceOwner
            onCell:(PetriBoardCell*)cell;

@property (readonly) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readonly) id<PetriBoard>  board;
@property (readonly) PetriGameConfiguration* gameConfiguration;
@property (readonly) id<PetriPiece> currentPiece;
@property (readwrite, getter=isInCaptureBatch) BOOL inCaptureBatch;
@property (readwrite, getter=isInClearBatch) BOOL inClearBatch;
@property (readonly, getter=isGameOver) BOOL gameOver;


@end
