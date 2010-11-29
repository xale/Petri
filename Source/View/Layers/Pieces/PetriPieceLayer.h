//
//  PetriPieceLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@class PetriSquareGridPiece;

/*!
 \brief A CALayer subclass for drawing a PetriPiece.
 
 The PetriPieceLayer draws a representation of a PetriPiece, rendered as a group of neutral (as in "player-color-less") cells in the appropriate arrangement.
 */
@interface PetriPieceLayer : PetriAspectRatioLayer
{
	PetriSquareGridPiece* piece;	/*!< The piece this layer displays. */
}

/*!
 Initializes a Piece Layer to display the specified Piece.
 @param displayPiece The PetriPiece the layer will display.
 */
- (id)initWithPiece:(PetriSquareGridPiece*)displayPiece;

/*!
 Creates a new Piece Layer to display the specified Piece.
 @param displayPiece The PetriPiece the layer will display.
 */
+ (id)pieceLayerForPiece:(PetriSquareGridPiece*)displayPiece;

@property (readonly) PetriSquareGridPiece* piece;

@end
