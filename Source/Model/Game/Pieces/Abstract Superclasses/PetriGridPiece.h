//
//  PetriGridPiece.h
//  Petri
//
//  Created by Alex Heinz on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriPiece.h"

/*!
 \brief The type of game piece placed on a PetriGridBoard.
 
 A PetriGridPiece object is a (small) collection of coordinates which represent the offsets of cells from an origin coordinate; adding a grid piece to a grid board (assuming its placement is legal) consists of claiming each cell on the board whose coordinates are defined by the set of coordinates in the piece, offset by the coordinates on the board of the piece's origin when it is placed.
 */
@interface PetriGridPiece : NSObject <PetriPiece>
{
	NSSet* cellCoordinates;	/*!< The set of Petri2DCoordinates describing the positions of the cells in this piece, as relative offsets from the piece's placement origin location. */
	NSUInteger orientation;	/*!< The number of times the piece's coordinates have been rotated, relative to the piece's configuration when it was created. */
}

/*!
 Default constructor. Initializes a PetriGridPiece with a set of coordinates and rotates it the specified number of times.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 @param rotations The number of times the piece is rotated.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates
					rotations:(NSUInteger)rotations;

/**
 * Initializes a PetriGridPiece with a specific set of coordinates.
 * @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates;

/*!
 Creates a new PetriGridPiece with a specific set of coordinates.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
 */
+ (id)pieceWithCellCoordinates:(NSSet*)coordinates;

/*!
 Takes an NSSet of Petri2DCoordinates, and rotates the set clockwise about the origin while preserving their relative positions.
 \warning Abstract method; subclasses must override.
 */
- (NSSet*)rotateCoordinatesClockwise:(NSSet*)coordinates;

/*!
 Takes an NSSet of Petri2DCoordinates, and shifts them so that they maintain their positions relative to one another, but their bounding rect has its origin at (0,0).
 */
- (NSSet*)normalizeCoordinates:(NSSet*)coordinates;

/*!
 Returns YES if the specified piece has the same set of cell offsets as the receiver.
 @param piece The piece with which to compare.
 */
- (BOOL)isEqualToGridPiece:(PetriGridPiece*)piece;

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

@property (readonly) NSSet* cellCoordinates;
@property (readonly) NSUInteger orientation;

@end
