//
//  PetriGameplayView.h
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"

@class PetriGame;
@class PetriPlayer;
@protocol PetriBoard;
@class PetriBoardCell;
@protocol PetriPiece;
@class PetriItem;

@class PetriBoardLayer;
@class PetriPieceLayer;
@class PetriPieceContainerLayer;
@class PetriPlayersListContainerLayer;

@protocol PetriGameplayViewDelegate;

/*!
 \brief An NSView subclass that draws the Gameplay view.
 
 The PetriGameplayView is a CoreAnimation layer-hosting view that contains and draws the game board, status information about the players in the game, and the current piece for the turn; it also handles the input events for interation with these elements, and makes callbacks to a delegate when such an event attempts to modify the model state.
 */
@interface PetriGameplayView : PetriNoLayerResizeAnimationView
{
	IBOutlet id<PetriGameplayViewDelegate> delegate;	/*!< The delegate object which this view will talk to when attempting to modify the model. */
	
	PetriGame* game;	/*!< The game currently displayed on the view. */
	
	// Layers:
	CALayer* outerContainerLayer;	/*!< Sublayer of the background which maintains the aspect ratio of the layer's contents. */
	PetriBoardLayer* boardLayer;	/*!< Sublayer of the \c outerContainerLayer which displays the board. */
	PetriPieceContainerLayer* pieceContainerLayer;	/*!< Sublayer of the \c outerContainerLayer which contains the current piece to be played. */
	PetriPlayersListContainerLayer* playersContainerLayer;	/*!< Sublayer of the \c outerContainerLayer which displays the list of players. */
	
	PetriPieceLayer* carriedPiece;	/*!< The piece carried by the user's cursor, if the player has picked it up. */
	PetriBoardCell* destinationCell;	/*!< The cell over which the carried piece's origin is located, if any. Used primarily as an internal optimization. */
	
	PetriItem* carriedItem;			/*!< The item carried by the user's cursor, if the player has picked one up. */
	NSMutableArray* itemTargets;	/*!< The list of layers targeted by the user for the use of an item. */
}

/*!
 Instructs the view to drop whatever layer is carried by the cursor, if any.
 */
- (IBAction)dropCarriedObjects:(id)sender;

@property (readwrite, assign) IBOutlet id<PetriGameplayViewDelegate> delegate;
@property (readwrite, assign) PetriGame* game;

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
canRotateCurrentPiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner;

/*!
 Informs the delegate that the current piece should be rotated.
 @param gameplayView The view on which the rotation was performed.
 @param piece The piece to be rotated.
 @param pieceOwner The player who currently has the active turn, and therefore "owns" the piece.
 */
- (void)gameplayView:(PetriGameplayView*)gameplayView
  rotateCurrentPiece:(id<PetriPiece>)piece
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
	   canPlacePiece:(id<PetriPiece>)piece
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
		  placePiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)originCell
			 ofBoard:(id<PetriBoard>)board;

/*!
 Queries the delegate for the validity of using an item on the specified cells of a board.
 @param gameplayView The view requesting the validation.
 @param item The item the user is attempting to use.
 @param itemUser The player attempting to use the item.
 @param cells The list of PetriBoardCells on which the player is attempting to use the item.
 @param board The board on which the item will be used.
 */
- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
		  canUseItem:(PetriItem*)item
		   forPlayer:(PetriPlayer*)itemUser
			 onCells:(NSArray*)cells
			 ofBoard:(id<PetriBoard>)board;

/*!
 Informs the delegate that an item has been used on the board.
 @param gameplayView The view on which the item's use was performed.
 @param item The item used.
 @param itemUser The player using the item.
 @param cells The list of PetriBoardCells on which the item was used.
 @param board The board on which the item was used.
 */
- (void)gameplayView:(PetriGameplayView*)gameplayView
			 useItem:(PetriItem*)item
		   forPlayer:(PetriPlayer*)itemUser
			 onCells:(NSArray*)cells
			 ofBoard:(id<PetriBoard>)board;

@end
