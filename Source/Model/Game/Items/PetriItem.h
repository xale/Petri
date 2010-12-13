//
//  PetriItem.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PetriBoard;

@class PetriPlayer;

/*!
 \brief A usuable item that can affect game state.
 
 PetriItem instances represent game items that can be collected by players, and then used by their owners to influence the game.
 */
@interface PetriItem : NSObject <NSCopying>
{
	
}

/*!
 Tests for the equality of two PetriItem objects.
 */
- (BOOL)isEqualToItem:(PetriItem*)item;

/*!
 Default initilaizer.
 Needs override.
 */
- (id)init;

/*!
 This is a general method for using an item.  If a particular parameter doesn't apply, it is ignored and it is safe to pass nil.
 This method may crash if it expects a value and does not receive one or receives one it does not expect.
 The validate method should be called beforehand with the same arguments.
 
 @param cells the cells the item affects
 @param pieces the pieces the item affects
 @param players the players the item affects
 @param usingPlayer the player who is using the item; always required
 @param board the board that the game is being played on; always required
 */
- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer
			   onBoard:(id<PetriBoard>)board;

/*!
 This is a general method for validating the use of an item.  If a particular parameter doesn't apply, it is ignored and it is safe to pass nil.
 This method will return \c NO if it expects a value and does not receive one or receives one it does not expect.
 The use method should be called afterward with the same arguments to actually use the item.
 
 @param cells the cells the item affects
 @param pieces the pieces the item affects
 @param players the players the item affects
 @param usingPlayer the player who is using the item; always required
 @param board the board that the game is being played on; always required
 */
- (BOOL)validateItemOnCells:(NSArray*)cells
					 pieces:(NSArray*)pieces
					players:(NSArray*)players
				   byPlayer:(PetriPlayer*)usingPlayer
					onBoard:(id<PetriBoard>)board;

@property (readonly) NSString* itemName;	/*!< Name of the item; displayed and used for equality checking. Subclasses must override to provide the item's name. */
@property (readonly) BOOL allowsCaptures;	/*!< Subclasses may override to return \c YES if captures should be attempted after this item is used. Defaults to \c NO. */
@property (readonly) NSImage* icon;			/*!< An icon to display on the view when representing this item in a player's inventory. Subclasses must override to provide an image. */

@end
