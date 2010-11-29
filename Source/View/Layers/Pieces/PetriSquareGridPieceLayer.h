//
//  PetriSquareGridPieceLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceLayer.h"

@class PetriSquareGridPiece;

/*!
 \brief A concrete PetriPieceLayer subclass representing a PetriSquareGridPiece.
 */
@interface PetriSquareGridPieceLayer : PetriPieceLayer
{
	
}

/*!
 Initializes a Piece Layer to display the specified Piece.
 @param displayPiece The PetriPiece the layer will display.
 */
- (id)initWithPiece:(PetriSquareGridPiece*)displayPiece;

@end
