//
//  PetriBoardLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@protocol PetriBoard;

@class PetriPieceLayer;

/*!
 \brief An abstract CALayer subclass used to display a PetriBoard.
 
 A PetriBoardLayer is resposible for the layout and display of a PetriBoard. In particular, it's class-factory method +boardLayerForBoard: will generate a concrete subclass appropriate for a given PetriBoard implementation.
 */
@interface PetriBoardLayer : PetriAspectRatioLayer
{
	id<PetriBoard> board;		/*!< A reference to the board this layer displays. */
	NSSet* highlightedCells;	/*!< A set of cell sublayers of this board which are currently highlighted for piece placement. */
}

/*!
 Factory method. Generates a PetriBoardLayer subclass appropriate for displaying the given Board.
 @param boardToDisplay The Board that should be displayed on the generated layer.
 */
+ (id)boardLayerForBoard:(id<PetriBoard>)boardToDisplay;

/*!
 Initializes a new PetriBoardLayer with a reference to the specified board.
 \warning Called by subclasses, do not invoke directly; use the class-factory method +boardLayerForBoard: instead.
 @param boardToDisplay The PetriBoard this layer will represent.
 @param ratio The aspect ratio the board layer will maintain.
 */
- (id)initWithBoard:(id<PetriBoard>)boardToDisplay
		aspectRatio:(CGFloat)ratio;

/*!
 Specfies a set of cells on the board to highlight, indicating the validity of placing a piece on them. Also un-highlights any currently-highlighted cells.
 @param cellsToHighlight A set of PetriBoardCellLayer sublayers of this board layer to highlight. Pass \c nil to highlight no cells.
 @param valid Specifies whether or not the cells should be highlighted as valid for the placement of a piece.
 */
- (void)highlightCells:(NSSet*)cellsToHighlight
			   asValid:(BOOL)valid;

/*!
 Resizes a PetriPieceLayer such that the size of its cell sublayers match the size of the cell layers of the receiver.
 \warning Abstract method, subclasses must override.
 @param pieceLayer The layer whose size should be adjusted.
 */
- (void)scalePieceLayerToCellSize:(PetriPieceLayer*)pieceLayer;

@property (readonly) id<PetriBoard> board;
@property (readonly) NSSet* highlightedCells;

@end
