//
//  PetriItemLayer.h
//  Petri
//
//  Created by Alex Heinz on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@class PetriItem;

/*!
 \brief A CALayer subclass that represents a PetriItem.
 
 A PetriItemLayer is a CALayer subclass which displays the icon for a PetriItem on a semitransparent black background with a white border.
 */
@interface PetriItemLayer : PetriAspectRatioLayer
{
	PetriItem* item;	/*!< The item whose icon this layer displays. */
	BOOL highlighted;	/*!< If \c YES, the layer indicates that it is selected. */
}

/*!
 Initializes a new PetriItemLayer to display the specified Item.
 @param displayedItem The PetriItem that should be displayed on the layer.
 */
- (id)initWithItem:(PetriItem*)displayedItem;

/*!
 Creates a new PetriItemLayer object displaying the specified Item.
 @param displayedItem The PetriItem that should be displayed on the new layer.
 */
+ (id)itemLayerForItem:(PetriItem*)displayedItem;

@property (readonly) PetriItem* item;
@property (readwrite, assign, getter=isHighlighted) BOOL highlighted;

@end
