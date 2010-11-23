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
@class PetriGridBoard;
@class PetriPiece;
@class Petri2DCoordinates;

@protocol PetriGameplayViewDelegate;

/*!
 \brief An NSView subclass that draws the Gameplay view.
 
 The PetriGameplayView is a CoreAnimation layer-hosting view that contains and draws the game board, status information about the players in the game, and the current piece for the turn; it also handles the input events for interation with these elements, and makes callbacks to a delegate when such an event attempts to modify the model state.
 */
@interface PetriGameplayView : PetriNoLayerResizeAnimationView
{
	IBOutlet id <PetriGameplayViewDelegate> delegate;	/*!< The delegate object which this view will talk to when attempting to modify the model. */
	PetriGame* game;	/*!< The model Game object for which this view draws a representation. */
}

@property (readwrite, assign) IBOutlet id<PetriGameplayViewDelegate> delegate;
@property (readwrite, assign) PetriGame* game;

@end

/*!
 \brief A protocol for model-interaction from a PetriGameplayView via its delegate.
 */
@protocol PetriGameplayViewDelegate

/*!
 Queries the delegate for the validity of a player placing a piece at the specified coordinates on the board.
 
 @param gameplayView The view requesting the validation.
 @param piece The piece whose placement is being validated.
 @param pieceOwner The owner of the piece whose placement is being validated.
 @param coordinates The placement coordinates to validate for the piece.
 @param board The board on which placement is being validated.
 */
- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
	   canPlacePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
	   atCoordinates:(Petri2DCoordinates*)coordinates
		 onGridBoard:(PetriGridBoard*)board;

/*!
 Informs the delegate that a piece has been placed on the board.
 
 @param gameplayView The view responsible for the placement.
 @param piece The piece being placed.
 @param pieceOwner The owner of the piece being placed.
 @param coordinates The placement coordinates for the piece.
 @param board The board on which to place the piece.
 */
- (void)gameplayView:(PetriGameplayView*)gameplayView
		  placePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
	   atCoordinates:(Petri2DCoordinates*)coordinates
			 onBoard:(PetriGridBoard*)board;

@end
