//
//  PetriItem.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief A usuable item that can affect game state.
 
 PetriItem instances represent game items that can be collected by players, and then used by their owners to influence the game.
 */
@interface PetriItem : NSObject <NSCopying>
{
	NSString* itemName;			/*!< Name of the item; displayed and used for equality checking. */
	BOOL affectsCells;			/*!< \c YES if the item can be used on cells, \c NO otherwise. */
	BOOL affectsPieces;			/*!< \c YES if the item can be used on pieces, \c NO otherwise. */
	BOOL affectsPlayers;		/*!< \c YES if the item can be used on players, \c NO otherwise. */
	BOOL allowsCaptures;		/*!< \c YES if captures should be attempted after this item is used, \c NO otherwise. */
	NSInvocation* validator;	/*!< The method the object should use to validate the attempted item use. */
	NSInvocation* performer;	/*!< The method which is actually used to effect the change resulting from the item use. */
}

/*!
 Tests for the equality of two PetriItem objects.
 */
- (BOOL)isEqualToItem:(PetriItem*)item;

/*!
 An item is initialized with two methods, one for validating its use and one for actually using it.
 The structure of the methods determines the three boolean affectsFOO parameters.
 \warning The name is considered a unique identifier; two items with the same name are considered equivalent.
 
 @param name user visible name of the item; used in determining equality
 @param validator a method which takes validates item use
 @param performer a method which actually uses the item
 @param canCapture a flag which allows or disallows the item to cause captures
 */
- (id)initWithName:(NSString*)name
		 validator:(NSInvocation*)itemValidator
		 performer:(NSInvocation*)itemPerformer
  allowingCaptures:(BOOL)canCapture;

/*!
 This is a general method for using an item.  If a particular parameter doesn't apply, it is ignored and it is safe to pass nil.
 This method will crash if it expects a value and does not receive one.
 The validate method should be called beforehand with the same arguments.
 If the corresponding affectsFOO member is \c NO, the parameter is ignored.
 Calls the performer.
 
 @param cells the cells the item affects, may be nil if it is ignored
 @param pieces the pieces the item affects, may be nil if it is ignored
 @param players the players the item affects, may be nil if it is ignored
 @param usingPlayer the player who is using the item; always required
 */
- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer;

/*!
 This is a general method for validating the use of an item.  If a particular parameter doesn't apply, it is ignored and it is safe to pass nil.
 This method will return \c NO if it expects a value and does not receive one.
 The use method should be called afterward with the same arguments to actually use the item.
 If the corresponding affectsFOO member is \c NO, the parameter is ignored.
 Calls the validator.
 
 @param cells the cells the item affects, may be nil if it is ignored
 @param pieces the pieces the item affects, may be nil if it is ignored
 @param players the players the item affects, may be nil if it is ignored
 @param usingPlayer the player who is using the item; always required
 */
- (void)useItemOnCells:(NSArray*)cells
				pieces:(NSArray*)pieces
			   players:(NSArray*)players
			  byPlayer:(PetriPlayer*)usingPlayer;

@property (readonly) NSString* itemName;
@property (readonly) BOOL affectsCells;
@property (readonly) BOOL affectsPieces;
@property (readonly) BOOL affectsPlayers;
@property (readonly) BOOL allowsCaptures;

@end
