//
//  PetriPieceContainerLayer.h
//  Petri
//
//  Created by Alex Heinz on 12/1/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@class PetriPieceLayer;

@protocol PetriPiece;

/*!
 \brief A CALayer subclass that displays the game's current piece on the gameplay view.
 */
@interface PetriPieceContainerLayer : PetriAspectRatioLayer
{
	PetriPieceLayer* currentPieceLayer;	/*!< The sublayer of the container which represents the current piece. */
}

/*!
 Initializes a PetriPieceContainerLayer with the first piece of the game.
 @param startingPiece The first piece the container should display.
 */
- (id)initWithPiece:(id<PetriPiece>)startingPiece;

/*!
 Hides or shows the contained piece.
 */
- (void)setPieceHidden:(BOOL)hide;

@property (readwrite, assign) id<PetriPiece> piece;	/*!< Computed property. The PetriPiece whose layer is displayed in this container. */
@property (readonly) PetriPieceLayer* currentPieceLayer;

@end
