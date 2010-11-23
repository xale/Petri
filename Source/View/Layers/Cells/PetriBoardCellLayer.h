//
//  PetriBoardCellLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriBoardCell;

/*!
 \brief A CALayer subclass used to display a PetriBoardCell.
 
 The PetriBoardCellLayer displays the properties of a given PetriBoardCell object on the view.
 */
@interface PetriBoardCellLayer : CALayer
{
	PetriBoardCell* cell;	/*!< The cell for which this layer provides a graphical representation. */
}

/*!
 Creates a new PetriBoardCellLayer with display attributes bound to the appropriate properties of the specified PetriBoardCell.
 
 @param displayedCell The PetriBoardCell that this layer will represent.
 */
+ (id)boardCellLayerBoundToCell:(PetriBoardCell*)displayedCell;

/*!
 Initializes a PetriBoardCellLayer by binding various display attributes to appropriate properties of the specified PetriBoardCell.
 
 @param displayedCell The PetriBoardCell that this layer will represent.
 */
- (id)initBoundToCell:(PetriBoardCell*)displayedCell;

@property (readonly) PetriBoardCell* cell;

@end
