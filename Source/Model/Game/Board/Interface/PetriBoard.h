//
//  PetriBoard.h
//  Petri
//
//  Created by Paul Martin on 10/11/17.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardCell;

/*!
 \brief Protocol definining common behaviors for interacting with the state of the game board.
 
 The PetriBoard protocol defines how the game interacts with the state of the board, such as placing pieces, checking for and making captures, using items, etc.
 */
@protocol PetriBoard

/*!
 Returns a set of PetriBoardCells which are, for the purposes of \a piece \a placement, adjacent to the specified cell on the board.
 @param cell The cell around which to find adjacent cells.
 */
- (NSSet*)placementCellsAdjacentToCell:(PetriBoardCell*)cell;

/*!
 Returns a set of PetriBoardCells which are, for the purposes of \a territory \a capture, adjacent to the specified cell on the board.
 @param cell The cell around which to find adjacent cells.
 */
- (NSSet*)capturableCellsAdjacentToCell:(PetriBoardCell*)cell;

+ (NSString*)boardType; //FIXME: document me
+ (NSInteger)absoluteMinPlayers;	// FIXME: document me (old documentation is out-of-date: "(Computed property) Specifies the minimum valid value for the minPlayers and maxPlayers properties.")
+ (NSInteger)absoluteMaxPlayers;	// FIXME: document me (old documentation is out-of-date: "(Computed property) Specifies the maximum valid value for the minPlayers and maxPlayers properties.")

@end
