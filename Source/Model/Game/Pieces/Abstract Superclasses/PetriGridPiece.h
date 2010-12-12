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
	NSSet* baseCellCoordinates;	/*!< The set of Petri2DCoordinates describing the positions of the cells in this piece, as relative offsets from the piece's origin. */
	NSUInteger orientation;	/*!< The current orientation of the piece, as a number of clockwise rotations (of arbitrary degrees, defined on a per-class basis) about the origin. */
}

/*!
 Default constructor. Initializes a PetriGridPiece with a set of coordinates and initial orientation.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its origin. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 @param initialOrientation The orientation of the piece when it is created.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates
				  orientation:(NSUInteger)initialOrientation;

/**
 * Initializes a PetriGridPiece with a specific set of coordinates. The orientation of the piece will be zero.
 * @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location. These coordinates will be "normalized" relative to the origin: see the documentation for -normalizeCoordinates:.
 */
- (id)initWithCellCoordinates:(NSSet*)coordinates;

/*!
 Creates a new PetriGridPiece with a specific set of coordinates. The orientation of the new piece will be zero.
 @param coordinates A set of Petri2DCoordinates that specifies the offsets of the cells in this piece relative to its placement location.
 */
+ (id)pieceWithCellCoordinates:(NSSet*)coordinates;

/*!
 Takes an NSSet of Petri2DCoordinates, and rotates the set clockwise about the origin while preserving their relative positions.
 \warning Abstract method; subclasses must override to define the amount of rotation, and the particular implementation of that rotation.
 */
- (NSSet*)rotateCoordinatesClockwise:(NSSet*)coordinates;

/*!
 Takes an NSSet of Petri2DCoordinates, and shifts them so that they maintain their positions relative to one another, but their bounding rect has its origin at (0,0).
 */
- (NSSet*)normalizeCoordinates:(NSSet*)coordinates;

/**
 Calculates and returns the number of columns in the receiver's base coordinate set.
 */
- (NSInteger)baseWidth;

/**
 Calculates and returns the number of rows in the receiver's base coordinate set.
 */
- (NSInteger)baseHeight;

+ (NSDictionary*)defaultPieceFrequencies;

@property (readonly) NSSet* baseCellCoordinates;
@property (readonly) NSSet* currentCellCoordinates;	/*!< Computed property. The cell coordinates of the piece, after after applying the effects of the piece's \c orientation. */

@end
