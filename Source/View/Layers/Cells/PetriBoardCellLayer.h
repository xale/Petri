//
//  PetriBoardCellLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PetriBoardCell;

/*!
 \brief A CALayer subclass used to display a PetriBoardCell.
 
 The PetriBoardCellLayer displays the properties of a given PetriBoardCell object on the view.
 */
@interface PetriBoardCellLayer : CALayer
{
	PetriBoardCell* cell;	/*!< The cell for which this layer provides a graphical representation. */
	BOOL highlighted;		/*!< Specifies whether the cell should indicate that it is highlighted for piece placment. */
	BOOL highlightsAsValid;	/*!< Specifies whether the cell, when highlighted, should indicate "valid" or "invalid" for piece placement. */
	
	CIFilter* highlightFilter;	/*!< The filter used to indicate the presence and type of highlight on the cell. */
	CAAnimation* highlightAnimation;	/*!< The animation, if any, applied to the highlight filter. */
}

/*!
 Creates a new PetriBoardCellLayer with display attributes bound to the appropriate properties of the specified PetriBoardCell.
 
 @param displayedCell The PetriBoardCell that this layer will represent.
 */
+ (id)boardCellLayerForCell:(PetriBoardCell*)displayedCell;

/*!
 Initializes a PetriBoardCellLayer by binding various display attributes to appropriate properties of the specified PetriBoardCell.
 
 @param displayedCell The PetriBoardCell that this layer will represent.
 */
- (id)initWithCell:(PetriBoardCell*)displayedCell;

@property (readonly) PetriBoardCell* cell;
@property (readwrite, assign, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign) BOOL highlightsAsValid;

@end
