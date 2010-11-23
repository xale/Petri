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
 */
- (Petri2DCoordinates*)coordinatesOfCell:(PetriBoardCell*)cell;

/**
 * Runs every time a piece is placed and performs all captures that are possible
 * recursively until no more captures are available
 */
- (void)capture;

/**
 * Place a given piece at a location naively
 * \warning This method does no validation or error checking. Call -validatePlacementOfPiece:withOwner:atCoordinates: first.
 * @param piece piece to place
 * @param pieceOwner player placing the piece
 * @param pieceOrigin the coordinates to place the piece's origin
 */
- (void)placePiece:(PetriPiece*)piece
		 withOwner:(PetriPlayer*)pieceOwner
	 atCoordinates:(Petri2DCoordinates*)pieceOrigin;

/**
 * Check if a location is a valid place to put a piece
 * @param piece the piece to place.
 * @param pieceOwner the player placing the piece
 * @param pieceOrigin the coordinates to place the piece's origin
 * @return true if the piece can be placed at the indicated coordinates
 */
- (BOOL)validatePlacementOfPiece:(PetriPiece*)piece
					   withOwner:(PetriPlayer*)pieceOwner
				   atCoordinates:(Petri2DCoordinates*)pieceOrigin;

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
