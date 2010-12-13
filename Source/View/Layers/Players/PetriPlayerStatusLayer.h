//
//  PetriPlayerStatusLayer.h
//  Petri
//
//  Created by Alex Heinz on 12/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriPlayer;
@class PetriItemStackLayer;

/*!
 \brief A CALayer subclass that displays information about a player in the game.
 */
@interface PetriPlayerStatusLayer : CALayer
{
	PetriPlayer* player;	/*!< A reference to the player whose information is displayed on this layer. */
	BOOL selected;			/*!< If \c YES this piece draws a white border to indicate that it is this player's turn. */
	
	NSArray* itemStacks;	/*!< Sublayers on which the player's items are displayed. */
	PetriItemStackLayer* highlightedStack;	/*!< Which stack, if any, of the player's items is selected for use. */
	CATextLayer* nameLayer;	/*!< Sublayer on which the player's name is stored. */
}

/*!
 Initializes a PetriPlayerStatusLayer bound to the properties of the specified player, and optionally selected.
 @param displayedPlayer The player whose information should be displayed on this layer.
 @param initiallySelected The initial selection state of the layer.
 */
- (id)initWithPlayer:(PetriPlayer*)displayedPlayer
			selected:(BOOL)initiallySelected;

/*!
 Creates a new PetriPlayerStatusLayer bound to the properties of the specified player, and optionally selected.
 @param displayedPlayer The player whose information should be displayed on the new layer.
 @param initiallySelected The initial selection state of the layer.
 */
+ (id)playerStatusLayerForPlayer:(PetriPlayer*)displayedPlayer
						selected:(BOOL)initiallySelected;

/*!
 Highlights the top item in the specified stack of items, indicating that the player has it selected for use. Also un-highlights the currently-highlighted stack, if any.
 @param stack The stack of items in which to highlight the top item. Pass \c nil to un-highlight all stacks.
 */
- (void)highlightTopItemOfStack:(PetriItemStackLayer*)stack;

@property (readonly) PetriPlayer* player;
@property (readwrite, assign, getter=isSelected) BOOL selected;

@end
