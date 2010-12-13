//
//  PetriBoardCell.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriCellType.h"

@class PetriPlayer;
@class PetriItem;

/*!
 \brief Object representing a cell on the game board.
 
 The PetriBoardCell class stores information about an individual "place" (i.e., a single unit in the coordinate system) on a game board, including the type of cell, the which player (if any) controls the cell, and, if present, an item that can be picked up when the cell is claimed.
 */
@interface PetriBoardCell : NSObject <NSCopying, NSCoding>
{
	PetriCellType cellType;	/*!< The type of cell. */
	PetriPlayer* owner;		/*!< The player currently controlling the cell, if any. Should be nil if cellType is not headCell or bodyCell. */
	PetriItem* pickUp;		/*!< The item picked up when this cell is claimed, if any. Should be nil if cellType is not unoccupiedCell. */
	NSInteger cellID;		/*!< A unique identifier, assigned by the board when the cell is created, and used to determine cell equality. */
}

/**
 * Default constructor
 * Initializes owner and item to nil and type to unoccupied
 * @param ID A unique identifier for the cell on its board.
 */
- (id)initWithCellID:(NSInteger)ID;

/**
 * Initializes a PetriBoardCell with the specified type, owner, if any, and item, if any.
 * @param type The type of cell
 * @param player The player currently controlling the cell; may be nil.
 * @param item The item picked up when this cell is claimed; may be nil.
 * @param ID A unique identifier for the cell on its board.
 */
- (id)initWithCellType:(PetriCellType)type
				 owner:(PetriPlayer*)player
				pickUp:(PetriItem*)item
				cellID:(NSInteger)ID;

/*!
 Clears the current cell
 */
- (void)clearCell;

/*!
 Transfers ownership of cell to player
 @param player the player that now owns the cell
 */
- (void)takeCellForPlayer:(PetriPlayer*)player;

/*!
 Returns \c YES if the cells is empty and \c NO otherwise.
 */
- (BOOL)isEmpty;

/*!
 Returns \c YES if the specified cell has the same \c cellID as the receiver.
 */
- (BOOL)isEqualToCell:(PetriBoardCell*)otherCell;

/*!
 Returns \c YES if the specified cell has the same values for its properties (except \c cellID) as the receiver.
 Intended for unit testing and debugging.
 */
- (BOOL)hasSamePropertiesAsCell:(PetriBoardCell*)otherCell;

@property (readwrite, assign) PetriCellType cellType;
@property (readwrite, assign) PetriPlayer* owner;
@property (readwrite, copy) PetriItem* pickUp;
@property (readonly) NSInteger cellID;

@end
