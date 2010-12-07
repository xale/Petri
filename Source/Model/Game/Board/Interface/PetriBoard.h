//
//  PetriBoard.h
//  Petri
//
//  Created by Paul Martin on 10/11/17.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardCell;
@class PetriPlayer;

@protocol PetriPiece;

/*!
 \brief Protocol definining common behaviors for interacting with the state of the game board.
 
 The PetriBoard protocol defines how the game interacts with the state of the board, such as placing pieces, checking for and making captures, using items, etc.
 */
@protocol PetriBoard <NSObject, NSCopying>

/*!
 Returns a board initialized with the parameters given.
 @param parameters a dictionary of names to parameters, usually taken from +setupParameters: and configured by the user
 */
- (id)initWithParameters:(NSDictionary*)parameters;

/*!
 Returns a board initialized with the parameters given.
 @param parameters a dictionary of names to parameters, usually taken from +setupParameters: and configured by the user
 */
+ (id)boardWithParameters:(NSDictionary*)parameters;

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

/*!
 Method called on board to validate piece placement.
 @param piece the piece to place
 @param owner the player attempting to place the piece
 @param cell the cell on the board on which the origin of the piece will be placed
 */
- (BOOL)validatePlacementOfPiece:(id<PetriPiece>)piece
					   withOwner:(PetriPlayer*)owner
						  onCell:(PetriBoardCell*)cell;
/*!
 Method called on board to place piece.
 \warning This method does no validation; call -validatePlacementOfPiece:withOwner:onCell: first.
 @param piece the piece to place
 @param owner the player attempting to place the piece
 @param cell the cell on the board on which the origin of the piece will be placed
 */
- (void)placePiece:(id<PetriPiece>)piece
		 withOwner:(PetriPlayer*)owner
			onCell:(PetriBoardCell*)cell;

/*!
 Remove all cells that don't have a path to their owner's head.
 Should be called after every manipulation to the board to ensure legal state.
 */
- (void)clearDeadCells;

/*!
 Returns a set of all head cells on the board.
 */
- (NSSet*)heads;

/*!
 Returns the head cell owned by the player, or nil if none exists.
 
 @param player the player whose head cell is of interest.
 */
- (PetriBoardCell*)headForPlayer:(PetriPlayer*)player;

/*!
 Sets the head cells of the players in the array passed in.
 */
- (void)setHeadsForPlayers:(NSArray*)players;

/*
 Runs every time a piece is placed and performs all captures that are possible
 recursively until no more captures are available
 
 @param player player to perform captures for
 */
- (void)performCapturesForPlayer:(PetriPlayer*)player;

/*!
 Returns a dictionary of BoardParameter objects mapped by name.
 */
+ (NSDictionary*)setupParameters;

+ (Class<PetriPiece>)pieceClass;	/*!< Returns the type of PetriPiece used by this type of board. */

+ (NSUInteger)absoluteMinPlayers;	/*!< Returns the minimum number of players that a board of this type can accommodate. */
+ (NSUInteger)absoluteMaxPlayers;	/*!< Returns the maximum number of players that a board of this type can accommodate. */

@end
