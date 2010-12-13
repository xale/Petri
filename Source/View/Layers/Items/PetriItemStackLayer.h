//
//  PetriItemStackLayer.h
//  Petri
//
//  Created by Alex Heinz on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriItem;
@class PetriItemLayer;

/*!
 \brief A CALayer subclass for displaying a bunch of PetriItemLayers.
 
 The PetriItemStackLayer displays a number of PetriItemLayer sublayers as a "stack" (in the sense of a stack of papers, as opposed to the data structure.)
 */
@interface PetriItemStackLayer : CALayer
{
	PetriItem* item;		/*!< The type of item displayed in this stack. */
	NSUInteger itemCount;	/*!< The number of items displayed in this stack. If this value is zero, this layer will be removed from its superlayer. */
	
	CATextLayer* stackCountLabel;	/*!< A label (optionally hidden) displaying the number of items in the stack. */
}

/*!
 Initializes a PetriItemStackLayer with the specified kind of item, and initial number of items.
 @param itemType The type of item found in this stack.
 @param initialCount The number of items initially in the stack.
 */
- (id)initWithItem:(PetriItem*)itemType
			 count:(NSUInteger)initialCount;

/*!
 Creates a new PetriItemStackLayer with the specified kind of item, and initial number of items.
 @param itemType The type of item found in this stack.
 @param initialCount The number of items initially in the stack.
 */
+ (id)itemStackWithItem:(PetriItem*)itemType
				  count:(NSUInteger)initialCount;

/*!
 Returns the item layer at the top of the stack.
 */
- (PetriItemLayer*)topItemLayer;

@property (readonly) PetriItem* item;
@property (readwrite, assign) NSUInteger itemCount;

@end
