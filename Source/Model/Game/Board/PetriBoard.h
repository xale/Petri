//
//  PetriBoard.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardLocation;
@class PetriPiece;
@class PetriPlayer;
@class PetriBoardCell;

/*!
 \brief Object representing a Petri game board.
 
 The PetriBoard class is a container for a collection of PetriBoardCell objects, representing the contents of the board during a game.
 */
@interface PetriBoard : NSObject
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
		atLocation:(PetriBoardLocation*)cellLocation
		 withOwner:(PetriPlayer*)player;

/**
 * Returns a cell at a given location
 * @param location Location on board to return the cell at
 * @return cell at given location
 */
- (PetriBoardCell*)cellAtLocation:(PetriBoardLocation*)location;

/**
 * Returns a cell at a given coordinates
 * @param x x coordinate of desired cell on board
 * @param y y coordinate of desired cell on board
 * @return cell at given location
 */
- (PetriBoardCell*)cellAtX:(NSInteger)x
						 Y:(NSInteger)y;

@property (readonly) NSInteger width;
@property (readonly) NSInteger height;

@end
