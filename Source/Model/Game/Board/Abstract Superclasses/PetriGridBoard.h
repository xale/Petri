//
//  PetriGridBoard.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriBoard.h"

@class Petri2DCoordinates;
@class PetriPiece;
@class PetriPlayer;
@class PetriBoardCell;

/*!
 \brief Object representing a Petri game board.
 
 The PetriBoard class is a container for a collection of PetriBoardCell objects, representing the contents of the board during a game.
 */
@interface PetriGridBoard : NSObject <PetriBoard>
{
	NSArray* cells;	/*!< Two-dimensional grid of PetriBoardCell objects representing the contents of the board. */
	NSInteger width;	/*!< Width of board, as an integer number of columns */
	NSInteger height;	/*!< Height of board, as an integer number of rows */
}

/**
 * Creates a board with a width and height of 10
 */
- (id)init;


/**
 * Creates a board with a specified width and height
 * @param boardWidth width to make the board
 * @param boardHeight height to make the board
 */
- (id)initWithWidth:(NSInteger)boardWidth
			 height:(NSInteger)boardHeight;

/**
 * Places a piece with a given owner at a cell location
 * @param piece piece to place
 * @param cellLocation origin for the origin of the piece to be placed
 * @param player owner of the piece being placed
 */
- (void)placePiece:(PetriPiece*)piece
		atLocation:(Petri2DCoordinates*)cellLocation
		 withOwner:(PetriPlayer*)player;

/**
 * Returns a cell at a given location
 * @param location Location on board to return the cell at
 * @return cell at given location
 */
- (PetriBoardCell*)cellAtLocation:(Petri2DCoordinates*)location;

/**
 * Returns a cell at a given coordinates
 * @param x x coordinate of desired cell on board
 * @param y y coordinate of desired cell on board
 * @return cell at given location
 */
- (PetriBoardCell*)cellAtX:(NSInteger)x
						 Y:(NSInteger)y;

/**
 * Returns a location for a given cell
 * @param cell cell on board to return the location
 * @return location at given location
 */- (Petri2DCoordinates*)coordinatesFromCell:(PetriBoardCell*)cell;



/**
 * Runs every time a piece is placed and performs all captures that are possible
 * recursively until no more captures are available
 */
- (void)capture;

/**
 * Place a given piece at a location naively
 * Legal moves are checked with the isValidPlacement method
 * @param piece piece to place
 * @param location location to place the piece
 * @param owner of the piece
 */
- (void)placePiece:(PetriPiece*)piece
		atLocation:(Petri2DCoordinates*)location
		 withOwner:(PetriPlayer*)owner;

/**
 * Check if a location is a valid place to put a piece
 * @param piece piece to place
 * @param location location to place the piece
 * @param player of the piece
 * @return true if the location is valid
 */
- (BOOL)isValidPlacementForPiece:(PetriPiece*)piece
					  atLocation:(Petri2DCoordinates*)location
					  withPlayer:(PetriPlayer*)player;

/**
 * Get an immutable set of all cells that are adjacent to a given location for the purpose of placing a piece
 * @param location location to get adjacent cells
 * @return NSSet of cells that are adjacent to the location
 */
- (NSSet*)placementCellsAdjacentToLocation:(Petri2DCoordinates*)location;

/**
 * Get an immutable set of all cells that are adjacent to a given location for the purpose of placing a piece
 * @param location location to get adjacent cells
 * @return NSSet of locations that are adjacent
 */
- (NSSet*)capturableCellsAdjacentToLocation:(Petri2DCoordinates*)location;

@property (readonly) NSInteger width;
@property (readonly) NSInteger height;

@end
