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
 
 A PetriPiece object is a (small) collection of coordinates which represent the locations of cells. Each game has a pool of piece configurations, and a random member of this pool is generated at the beginning of each turn, as the piece for the player to place on the board. Placing the piece on the board adds the cells in the set, specified by their offsets from the location at which the piece is placed, to the board contents, assuming the placement is legal.
 */
@interface PetriPiece : NSObject
{
	NSSet* cellCoordinates;	/*!< The set of Petri2DCoordinates describing the positions of the cells in this piece, as relative offsets from the piece's placement location. */
}

/**
 * Default constructor
 * Creates a set of four locations for a tetromino
 * In this case it's an s-block for testing purposes
 * We will work to extend this with more shapes later
 */
- (id)init;

/**
 * Initializes a PetriPiece with a specific set of coordinates.
 * @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
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
- (PetriPiece*)pieceRotatedClockwise;

/**
 * Returns the current piece, but rotated counterclockwise
 * This is done by rotating all blocks in the set -90 degrees about the origin
 * @return current piece rotated counterclockwise
 */
- (PetriPiece*)pieceRotatedCounterclockwise;

@property (readonly) NSSet* cellCoordinates;

@end
