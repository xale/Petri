//
//  PetriPiece.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief The game pieces given to players to place on the board.
 
 A PetriPiece object is a (small) collection of coordinates which represent the offsets of cells from an origin point. Placing a piece on the board adds the cells in the set to the board contents, assuming the placement is legal. Each game has a pool of piece configurations, and a random member of this pool is generated at the beginning of each turn, as the piece for the player to place on the board.
 */
@interface PetriSquareGridPiece : NSObject <NSCopying>
{
	NSSet* cellCoordinates;	/*!< The set of Petri2DCoordinates describing the positions of the cells in this piece, as relative offsets from the piece's placement origin location. */
}

/*!
 Returns a piece-frequency dictionary containing the set of default pieces, with an even distribution.
 */
+ (NSDictionary*)defaultPieceFrequencies;

+ (id)unitPiece;	/*!< Returns a PetriPiece with a single cell located at the piece's origin. */
+ (id)line2Piece;	/*!< Returns a PetriPiece consisting of two adjacent cells. */
+ (id)line3Piece;	/*!< Returns a PetriPiece consisting of three cells in a line. */
+ (id)l3Piece;		/*!< Returns a PetriPiece consisting of three cells in an 'L' shape */
+ (id)line4Piece;	/*!< Returns a PetriPiece consisting of four cells in a line. */
+ (id)squarePiece;	/*!< Returns a PetriPiece consisting of four cells in a square. */
+ (id)jPiece;		/*!< Returns a PetriPiece shaped like the 'J' tetromino. */
+ (id)lPiece;		/*!< Returns a PetriPiece shaped like the 'L' tetromino. */
+ (id)zPiece;		/*!< Returns a PetriPiece shaped like the 'Z' tetromino. */
+ (id)sPiece;		/*!< Returns a PetriPiece shaped like the 'S' tetromino. */
+ (id)line5Piece;	/*!< Returns a PetriPiece consisting of five cells in a line. */

/**
 * Default constructor. Initializes a PetriPiece with a specific set of coordinates.
 * @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates;

/*!
 Creates a new PetriPiece with a specific set of coordinates.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
 */
+ (id)pieceWithCellCoordinates:(NSSet*)coordinates;

/**
 * Returns the current piece, but rotated clockwise
 * This is done by rotating all blocks in the set 90 degrees about the origin
 * @return current piece rotated clockwise
 */
- (PetriSquareGridPiece*)pieceRotatedClockwise;

/**
 * Returns the current piece, but rotated counterclockwise
 * This is done by rotating all blocks in the set -90 degrees about the origin
 * @return current piece rotated counterclockwise
 */
- (PetriSquareGridPiece*)pieceRotatedCounterclockwise;

/*!
 Returns the number of orientations the piece can be rotated to occupy; more precisely, rotating a piece this many times is guaranteed to produce a piece whose configuration is identical to the original piece.
 In the case of pieces to be placed on a square grid, this method returns 4.
 */
+ (NSUInteger)orientationsCount;

/*!
 Returns YES if the specified piece has the same set of cell offsets as the receiver.
 @param piece The piece with which to compare.
 */
- (BOOL)isEqualToPiece:(PetriSquareGridPiece*)piece;

@property (readonly) NSSet* cellCoordinates;

/**
 Return the width of the piece
 @return width as NSInteger
 */
- (NSInteger)width;

/**
 Return the height of the piece
 @return height as NSInteger
 */
- (NSInteger)height;

@end
