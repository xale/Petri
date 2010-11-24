//
//  PetriBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

#import "PetriBoard.h"

/*!
 \brief An abstract CALayer subclass used to display a PetriBoard.
 
 A PetriBoardLayer is resposible for the layout and display of a PetriBoard. In particular, it's class-factory method +boardLayerForBoard: will generate a concrete subclass appropriate for a given PetriBoard implementation.
 */
@interface PetriBoardLayer : PetriAspectRatioLayer
{
	id<PetriBoard> board;	/*!< A reference to the board this layer displays. */
}

/*!
 Factory method. Generates a PetriBoardLayer subclass appropriate for displaying the given Board.
 @param boardToDisplay The Board that should be displayed on the generated layer.
 */
+ (id)boardLayerForBoard:(id<PetriBoard>)boardToDisplay;

/*!
 Initializes a new PetriBoardLayer with a reference to the specified board.
 \warning Called by subclasses, do not invoke directly; use the class-factory method +boardLayerForBoard: instead.
 @param boardToDisplay The PetriGridBoard this layer will represent.
 @param ratio The aspect ratio the board layer will maintain.
 */
- (id)initWithBoard:(id<PetriBoard>)boardToDisplay
		aspectRatio:(CGFloat)ratio;

@property (readonly) id<PetriBoard> board;

@end
