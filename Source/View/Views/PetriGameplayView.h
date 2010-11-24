//
//  PetriGameplayView.h
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"

#import "PetriBoard.h"

@class PetriGame;
@class PetriPlayer;
@class PetriPiece;

@protocol PetriGameplayViewDelegate;

/*!
 \brief An NSView subclass that draws the Gameplay view.
 
 The PetriGameplayView is a CoreAnimation layer-hosting view that contains and draws the game board, status information about the players in the game, and the current piece for the turn; it also handles the input events for interation with these elements, and makes callbacks to a delegate when such an event attempts to modify the model state.
 */
@interface PetriGameplayView : PetriNoLayerResizeAnimationView
{
	IBOutlet id <PetriGameplayViewDelegate> delegate;	/*!< The delegate object which this view will talk to when attempting to modify the model. */
	
	CALayer* outerContainerLayer;	/*!< A fixed-aspect-ratio container layer that keeps the game elements centered on the view. */
	CALayer* pieceBoxLayer;		/*!< A square layer in the lower-right corner of the container layer that holds the next piece to be placed on the board. */
	CALayer* playerBoxesConstainerLayer;	/*!< A container layer for the player-status-info boxes in the top-right corner of the view. */
	
	NSArray* players;			/*!< The list of players in the game. */
	PetriPlayer* currentPlayer;	/*!< The player whose turn it is. */
	id<PetriBoard> board;		/*!< The game board. */
	PetriPiece* currentPiece;	/*!< The piece to be placed this turn. */
}

@property (readwrite, assign) IBOutlet id<PetriGameplayViewDelegate> delegate;
@property (readwrite, copy) NSArray* players;
@property (readwrite, assign) PetriPlayer* currentPlayer;
@property (readwrite, assign) id<PetriBoard> board;
@property (readwrite, assign) PetriPiece* currentPiece;

@end

/*!
 \brief A protocol for model-interaction from a PetriGameplayView via its delegate.
 */
@protocol PetriGameplayViewDelegate

/*!
 Queries the delegate as to whether the current piece (i.e., the next piece to be placed on the board) may be rotated.
 @param gameplayView The view requesting the validation.
 @param piece The piece for which to validate rotation.
 @param pieceOwner The player who currently has the active turn, and therefore "owns" the piece.
 */
- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
canRotateCurrentPiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner;

/*!
 Informs the delegate that the current piece should be rotated.
 @param gameplayView The view on which the rotation was performed.
 @param piece The piece to be rotated.
 @param pieceOwner The player who currently has the active turn, and therefore "owns" the piece.
 */
- (void)gameplayView:(PetriGameplayView*)gameplayView
  rotateCurrentPiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner;

/*!
 Queries the delegate for the validity of a player placing a piece at the specified coordinates on the board.
 @param gameplayView The view requesting the validation.
 @param piece The piece whose placement is being validated.
 @param pieceOwner The owner of the piece whose placement is being validated.
 @param originCell The cell in which the origin of the piece will be placed.
 @param board The board on which placement is being validated.
 */
- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
	   canPlacePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)originCell
			 ofBoard:(id<PetriBoard>)board;

/*!
 Informs the delegate that a piece has been placed on the board.
 @param gameplayView The view responsible for the placement.
 @param piece The piece being placed.
 @param pieceOwner The owner of the piece being placed.
 @param originCell The cell in which the origin of the piece is being placed.
 @param board The board on which to place the piece.
 */
- (void)gameplayView:(PetriGameplayView*)gameplayView
		  placePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)originCell
			 ofBoard:(id<PetriBoard>)board;

@end
