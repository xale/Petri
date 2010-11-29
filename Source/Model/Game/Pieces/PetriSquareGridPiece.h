//
//  PetriPiece.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriPiece.h"
/*!
 \brief The game pieces given to players to place on the board.
 
 A PetriPiece object is a (small) collection of coordinates which represent the offsets of cells from an origin point. Placing a piece on the board adds the cells in the set to the board contents, assuming the placement is legal. Each game has a pool of piece configurations, and a random member of this pool is generated at the beginning of each turn, as the piece for the player to place on the board.
 */
@interface PetriSquareGridPiece : NSObject <PetriPiece>
{
	NSSet* cellCoordinates;	/*!< The set of Petri2DCoordinates describing the positions of the cells in this piece, as relative offsets from the piece's placement origin location. */
	NSUInteger orientation;
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
 Initializes a PetriPiece with a set of coordinates and rotates it the specified number of times.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 @param rotations The number of times the piece is rotated.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates
					rotations:(NSUInteger)rotations;

/*!
 Creates a new PetriPiece with a specific set of coordinates.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
 */
+ (id)pieceWithCellCoordinates:(NSSet*)coordinates;

/*!
 Creates a new PetriPiece with a specific set of coordinates and rotates it a number of times.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
 @param rotations number of times the piece is rotated.
 */
+ (id)pieceWithCellCoordinates:(NSSet*)coordinates
					 rotations:(NSUInteger)rotations;

/**
 * Returns the coordinates current piece, but rotated clockwise.
 * This is done by rotating all blocks in the set 90 degrees about the origin.
 */
- (NSSet*)cellCoordinatesRotatedClockwise;

/*!
 In the case of pieces to be placed on a square grid, this method returns 4.
 */
+ (NSUInteger)orientationsCount;

/*!
 Returns YES if the specified piece has the same set of cell offsets as the receiver.
 @param piece The piece with which to compare.
 */
- (BOOL)isEqualToPiece:(PetriSquareGridPiece*)piece;

@property (readonly) NSSet* cellCoordinates;
@property (readonly) NSUInteger orientation;

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
