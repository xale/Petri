//
//  PetriSquareGridPiece.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGridPiece.h"

/*!
 \brief A concrete PetriGridPiece subclass that represents pieces to be placed on a PetriSquareGridBoard.
 
 The coordinate offsets of a PetriSquareGridPiece represent indexes on a board that uses a perpendicular coordinate system. Rotations rotate the piece by 90°, so the number of possible orientations is 4.
 */
@interface PetriSquareGridPiece : PetriGridPiece
{
	
}

/*!
 Returns a piece-frequency dictionary containing the set of default pieces, with an even distribution.
 */
+ (NSDictionary*)defaultPieceFrequencies;

+ (id)unitPiece;	/*!< Returns a PetriSquareGridPiece with a single cell located at the piece's origin. */
+ (id)line2Piece;	/*!< Returns a PetriSquareGridPiece consisting of two adjacent cells. */
+ (id)line3Piece;	/*!< Returns a PetriSquareGridPiece consisting of three cells in a line. */
+ (id)l3Piece;		/*!< Returns a PetriSquareGridPiece consisting of three cells in an 'L' shape */
+ (id)line4Piece;	/*!< Returns a PetriSquareGridPiece consisting of four cells in a line. */
+ (id)squarePiece;	/*!< Returns a PetriSquareGridPiece consisting of four cells in a square. */
+ (id)jPiece;		/*!< Returns a PetriSquareGridPiece shaped like the 'J' tetromino. */
+ (id)lPiece;		/*!< Returns a PetriSquareGridPiece shaped like the 'L' tetromino. */
+ (id)zPiece;		/*!< Returns a PetriSquareGridPiece shaped like the 'Z' tetromino. */
+ (id)sPiece;		/*!< Returns a PetriSquareGridPiece shaped like the 'S' tetromino. */
+ (id)tPiece;		/*!< Returns a PetriSquareGridPiece shaped like the 'T' tetromino. */
+ (id)line5Piece;	/*!< Returns a PetriSquareGridPiece consisting of five cells in a line. */

@end
