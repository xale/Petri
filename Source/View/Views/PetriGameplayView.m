//
//  PetriGameplayView.m
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayView.h"

#import "PetriGame.h"
#import "PetriPlayer.h"
#import "PetriBoard.h"
#import "PetriBoardCell.h"
#import "PetriPiece.h"

#import "PetriAspectRatioLayer.h"
#import "PetriBoardLayer.h"
#import "PetriBoardCellLayer.h"
#import "PetriPlayersListContainerLayer.h"
#import "PetriPieceLayer.h"
#import "PetriPieceContainerLayer.h"

#import "CALayer+ConstraintSets.h"

/*!
 Private methods on PetriGameplayView.
 */
@interface PetriGameplayView(Private)

/*!
 Creates a new board layer for the specified board, set up for display on this view as a sublayer of the outer container layer.
 @param newBoard The board for which to create a Board Layer.
 */
- (PetriBoardLayer*)createBoardLayerForBoard:(id<PetriBoard>)newBoard;

/*!
 Creates the CALayer used as an outer container for all visible layers on the view, and maintains their aspect ratio over view resize.
 @param newBoardLayer The new board layer to contain, which defines the aspect ratio of the new container.
 */
- (CALayer*)createOuterContainerLayerForBoardLayer:(PetriBoardLayer*)newBoardLayer;

/*!
 Creates the layer used as the container for the current piece.
 @param newGame The game whose current piece the container should hold and display.
 */
- (PetriPieceContainerLayer*)pieceContainerLayerForGame:(PetriGame*)newGame;

/*!
 Creates the layer used as the container for the player-status boxes.
 @param newGame The game with which the view is being initialized.
 */
- (PetriPlayersListContainerLayer*)playersListConstainerLayerForGame:(PetriGame*)newGame;

/*!
 Called when the view receives a -mouseDown: event corresponding to a click on a the layer representing the board.
 */
- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
		   onBoardLayer:(PetriBoardLayer*)clickedLayer;

/*!
 Called when the view recieves a -mouseDown: event corresponding to a click on the layer representing the current piece.
 */
- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
		   onPieceLayer:(PetriPieceLayer*)clickedLayer;

/*!
 Called when the view recieves a -mouseDown: event corresponding to a click on the current-piece container layer.
 */
- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
  onPieceContainerLayer:(PetriPieceContainerLayer*)clickedLayer;

/*!
 Returns a the cell on the board located beneath the origin cell of the carried piece, or nil if no such cell is present.
 */
- (PetriBoardCell*)cellUnderCarriedPieceOrigin;

/*!
 Tests if the current position of the carried piece is valid for placement on the board if the piece's origin lies on the specified cell.
 @param destinationCell the cell on the board whose position corresponds to that of the piece's origin cell.
 */
- (BOOL)canPlaceCarriedPieceOnCell:(PetriBoardCell*)destinationCell;

/*!
 Removes the carried piece layer from the cursor, and optionally returns it to its container.
 */
- (void)dropCarriedPiece:(BOOL)returnToContainer;

/*!
 Called when the view receives a -keyDown: event corresponding to a press of the spacebar.
 */
- (void)spacebarDown:(NSEvent*)keyEvent;

/*!
 Called when captures are about to be performed on the board, and an appropriate CATransaction should be begun.
 */
- (void)beginCaptureTransaction;

/*!
 Called when captures have been completed, and the corresponding CATransaction should be committed.
 */
- (void)endCaptureTransaction;

/*!
 Called when dead cells are about to be cleared from the board, and an appropriate CATransaction should be begun.
 */
- (void)beginDeadCellsTransaction;

/*!
 Called when dead cells have been cleared, and the corresponding CATransaction should be committed.
 */
- (void)endDeadCellsTransaction;

@end

@implementation PetriGameplayView

+ (void)initialize
{
	[self exposeBinding:@"game"];
}

- (void)awakeFromNib
{
	// Create a background layer for the view
	CALayer* backgroundLayer = [CALayer layer];
	
	// Add a layout manager
	[backgroundLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Set up the view to be layer-hosting (see discussion under documentation of NSView -setWantsLayer:)
	[self setLayer:backgroundLayer];
	[self setWantsLayer:YES];
	
	// Make the view track mouse movements
	[self addTrackingArea:[[NSTrackingArea alloc] initWithRect:NSZeroRect
													   options:(NSTrackingMouseMoved | NSTrackingActiveInActiveApp | NSTrackingInVisibleRect)
														 owner:self
													  userInfo:nil]];
}

#pragma mark -
#pragma mark Configuration and Drawing Attributes

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)isOpaque
{
	return NO;
}

#pragma mark -
#pragma mark View Layout

#define PetriGameplayViewSidebarProportion		0.3

- (PetriBoardLayer*)createBoardLayerForBoard:(id<PetriBoard>)newBoard
{
	// Create a layer for the game board
	PetriBoardLayer* newBoardLayer = [PetriBoardLayer boardLayerForBoard:newBoard];
	
	// Anchor the board to the lower-left corner of its superlayer
	[newBoardLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	
	// Constrain the board's height to the height of its superlayer
	[newBoardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															relativeTo:@"superlayer"
															 attribute:kCAConstraintHeight]];
	[newBoardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															relativeTo:@"superlayer"
															 attribute:kCAConstraintHeight
																 scale:[newBoardLayer aspectRatio]
																offset:0.0]];
	
	return newBoardLayer;
}

- (CALayer*)createOuterContainerLayerForBoardLayer:(PetriBoardLayer*)newBoardLayer
{
	// Calculate the aspect ratio of the new container layer, based on the new board's aspect ratio
	CGFloat containerRatio = ([newBoardLayer aspectRatio] + PetriGameplayViewSidebarProportion);
	
	// Create the container layer
	CALayer* newContainer = [PetriAspectRatioLayer layerWithAspectRatio:containerRatio];
	[newContainer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Constrain the container layer to fill the view
	[newContainer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[newContainer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	return newContainer;
}

- (PetriPieceContainerLayer*)pieceContainerLayerForGame:(PetriGame*)newGame
{
	// Create a layer
	PetriPieceContainerLayer* containerLayer = [[PetriPieceContainerLayer alloc] initWithPiece:[newGame currentPiece]];
	
	// Anchor the layer to the lower-right corner of its superlayer
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	
	// Make the layer square, and size it proportionally to its superlayer
	[containerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriGameplayViewSidebarProportion
																 offset:0]];
	[containerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriGameplayViewSidebarProportion
																 offset:0]];
	
	// Bind the piece displayed in the layer to the current piece in the game
	[containerLayer bind:@"piece"
				toObject:newGame
			 withKeyPath:@"currentPiece"
				 options:nil];
	
	return containerLayer;
}

- (PetriPlayersListContainerLayer*)playersListConstainerLayerForGame:(PetriGame*)newGame
{
	// Create a container layer
	PetriPlayersListContainerLayer* playerContainerLayer = [[PetriPlayersListContainerLayer alloc] initWithPlayersList:[newGame players]
																										   playerSlots:[[[newGame board] class] absoluteMaxPlayers]
																										selectedPlayer:[newGame currentPlayer]];
	
	// Anchor the container to the top-right corner of its superlayer
	[playerContainerLayer addConstraintsFromSet:[CAConstraint superlayerUpperRightCornerConstraintSet]];
	
	// Constrain the container to fill the right-edge "sidebar" of the superlayer (leaving space for the piece box below)
	[playerContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintHeight
																		scale:(1.0 - PetriGameplayViewSidebarProportion)
																	   offset:0]];
	[playerContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																   relativeTo:@"superlayer"
																	attribute:kCAConstraintHeight
																		scale:PetriGameplayViewSidebarProportion
																	   offset:0]];
	
	// Bind the container's selected player to the game's current player
	[playerContainerLayer bind:@"selectedPlayer"
					  toObject:newGame
				   withKeyPath:@"currentPlayer"
					   options:nil];
	
	return playerContainerLayer;
}

#pragma mark -
#pragma mark Input Events

#pragma mark Mouse

- (void)mouseDown:(NSEvent*)mouseEvent
{
	// Determine where on the view the click occurred
	CGPoint clickedPoint = NSPointToCGPoint([self convertPoint:[mouseEvent locationInWindow] fromView:nil]);
	 
	// Get the deepest layer in the hierarchy that was clicked
	CALayer* clickedLayer = [outerContainerLayer hitTest:clickedPoint];
	
	// Search the layer hierarchy under the mouse for layers of interest
	for (CALayer* searchLayer = clickedLayer; searchLayer != nil; searchLayer = [searchLayer superlayer])
	{
		// The board
		if ([searchLayer isKindOfClass:[PetriBoardLayer class]])
		{
			if ([self handleMouseDown:mouseEvent onBoardLayer:(PetriBoardLayer*)searchLayer])
				return;
		}
		
		// The current piece
		if ([searchLayer isKindOfClass:[PetriPieceLayer class]])
		{
			if ([self handleMouseDown:mouseEvent onPieceLayer:(PetriPieceLayer*)searchLayer])
				return;
		}
		
		// The piece container
		if ([searchLayer isKindOfClass:[PetriPieceContainerLayer class]])
		{
			if ([self handleMouseDown:mouseEvent onPieceContainerLayer:(PetriPieceContainerLayer*)searchLayer])
				return;
		}
	}
}

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
		   onBoardLayer:(PetriBoardLayer*)clickedLayer
{
	// If the cursor is not carrying a piece, ignore this event
	if (carriedPiece == nil)
		return NO;
	
	// Get the cell under the piece's origin
	PetriBoardCell* destinationCell = [self cellUnderCarriedPieceOrigin];
	
	// Check if the piece can be placed at that position
	if (![self canPlaceCarriedPieceOnCell:destinationCell])
		return NO;
	
	// Place the current piece on the board
	[[self delegate] gameplayView:self
					   placePiece:[[self game] currentPiece]
						forPlayer:[[self game] currentPlayer]
						   onCell:destinationCell
						  ofBoard:[[self game] board]];
	
	// "Drop" the carried piece
	[self dropCarriedPiece:NO];
	
	// Event handled
	return YES;
}

#define PetriGameplayViewCarriedPieceOpacity	0.75

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
		   onPieceLayer:(PetriPieceLayer*)clickedLayer
{
	// If the cursor is already carrying a piece, ignore this event
	if (carriedPiece != nil)
		return NO;
	
	// "Pick up" the piece layer
	// Get the piece from the layer
	id<PetriPiece> piece = [clickedLayer piece];
	
	// Create a new layer with the piece
	carriedPiece = [PetriPieceLayer pieceLayerForPiece:piece];
	
	// Make the layer semitransparent
	[carriedPiece setOpacity:PetriGameplayViewCarriedPieceOpacity];
	
	// Resize the piece to match the scale of the board
	[boardLayer scalePieceLayerToCellSize:carriedPiece];
	
	// Place the layer under the cursor
	NSPoint mousePoint = [self convertPoint:[mouseEvent locationInWindow]
								   fromView:nil];
	[carriedPiece setPosition:NSPointToCGPoint(mousePoint)];
	
	// Add the layer to the background
	[[self layer] addSublayer:carriedPiece];
	
	// Hide the piece layer in the container
	[pieceContainerLayer setPieceHidden:YES];
	
	// Event handled
	return YES;
}

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
  onPieceContainerLayer:(PetriPieceContainerLayer*)clickedLayer
{
	// If the cursor is not carrying a piece, ignore this event
	if (carriedPiece == nil)
		return NO;
	
	// Drop the carried piece
	[self dropCarriedPiece:YES];
	
	// Event handled
	return YES;
}

- (void)mouseDragged:(NSEvent*)mouseEvent
{
	if ([[mouseEvent window] isEqual:[self window]])
		[self mouseMoved:mouseEvent];
}

- (void)mouseMoved:(NSEvent*)mouseEvent
{
	// If the cursor is not carrying a piece, ignore this event
	if (carriedPiece == nil)
		return;
	
	// Disable movement animation, since it will slow things down and is unnecessary
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	// Move the piece with the cursor
	NSPoint mousePoint = [self convertPoint:[mouseEvent locationInWindow]
								   fromView:nil];
	[carriedPiece setPosition:NSPointToCGPoint(mousePoint)];
	
	[CATransaction commit];
}

#pragma mark Keyboard

- (void)keyDown:(NSEvent*)keyEvent
{
	if ([[keyEvent characters] isEqualToString:@" "])
	{
		[self spacebarDown:keyEvent];
		return;
	}
	
	[super keyDown:keyEvent];
}

- (void)spacebarDown:(NSEvent*)keyEvent
{
	// Check if the user can rotate the current piece
	BOOL rotationAllowed = [[self delegate] gameplayView:self
								   canRotateCurrentPiece:[[self game] currentPiece]
											   forPlayer:[[self game] currentPlayer]];
	if (rotationAllowed)
	{
		// Rotate the current piece
		[[self delegate] gameplayView:self
				   rotateCurrentPiece:[[self game] currentPiece]
							forPlayer:[[self game] currentPlayer]];
	}
}

#pragma mark -
#pragma mark Carried-Piece Methods

- (PetriBoardCell*)cellUnderCarriedPieceOrigin
{
	// Get the piece's origin, and convert to the background layer's coordinate system
	CGPoint pieceOrigin = [[self layer] convertPoint:[carriedPiece origin]
										   fromLayer:carriedPiece];
	
	// Convert to the board layer's superlayer's coordinate system
	pieceOrigin = [[self layer] convertPoint:pieceOrigin
									 toLayer:outerContainerLayer];
	
	// Hit-test the board layer, looking for a cell under the piece's origin
	CALayer* layerUnderOrigin = [boardLayer hitTest:pieceOrigin];
	
	// Check that such a cell exists
	if ((layerUnderOrigin == nil) || ![layerUnderOrigin isKindOfClass:[PetriBoardCellLayer class]])
		return nil;
	
	// Get the cell from the layer
	return [(PetriBoardCellLayer*)layerUnderOrigin cell];
}

- (BOOL)canPlaceCarriedPieceOnCell:(PetriBoardCell*)destinationCell
{
	// Check if the piece can be placed at the origin cell
	return [[self delegate] gameplayView:self
						   canPlacePiece:[[self game] currentPiece]
							   forPlayer:[[self game] currentPlayer]
								  onCell:destinationCell
								 ofBoard:[[self game] board]];
}

- (void)dropCarriedPiece:(BOOL)returnToContainer
{
	// If necessary, reveal the piece in the container
	if (returnToContainer)
		[pieceContainerLayer setPieceHidden:NO];
	
	// Remove the carried piece from the background layer
	[carriedPiece removeFromSuperlayer];
	carriedPiece = nil;
}

#pragma mark -
#pragma mark Model-Event Transactions

#define PetriGameplayViewCaptureAnimationDuration	2.0	// Seconds

- (void)beginCaptureTransaction
{
	[CATransaction begin];
	[CATransaction setAnimationDuration:PetriGameplayViewCaptureAnimationDuration];
	// FIXME: set transaction properties
}
- (void)endCaptureTransaction
{
	// FIXME: check for balanced capture begin/end
	[CATransaction commit];
}

#define PetriGameplayViewDeadCellsAnimationDuration	3.0	// Seconds

- (void)beginDeadCellsTransaction
{
	[CATransaction begin];
	[CATransaction setAnimationDuration:PetriGameplayViewDeadCellsAnimationDuration];
	// FIXME: set transaction properties
}
- (void)endDeadCellsTransaction
{
	// FIXME: check for balanced dead-cells begin/end
	[CATransaction commit];
}

#pragma mark -
#pragma mark Key-Value Observing

- (void)startObservingBatchesForGame:(PetriGame*)gameToObserve
{
	[gameToObserve addObserver:self
					forKeyPath:@"inCaptureBatch"
					   options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
					   context:NULL];
	[gameToObserve addObserver:self
					forKeyPath:@"inClearBatch"
					   options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
					   context:NULL];
}

- (void)stopObservingBatchesForGame:(PetriGame*)gameToObserve
{
	[gameToObserve removeObserver:self
					   forKeyPath:@"inCaptureBatch"];
	[gameToObserve removeObserver:self
					   forKeyPath:@"inClearBatch"];
}

- (void)observeValueForKeyPath:(NSString*)keyPath
					  ofObject:(id)object
						change:(NSDictionary*)changeDict
					   context:(void*)context
{
	// Get the old and new values of the flag
	BOOL oldFlagValue = [[changeDict objectForKey:NSKeyValueChangeOldKey] boolValue];
	BOOL newFlagValue = [[changeDict objectForKey:NSKeyValueChangeNewKey] boolValue];
	
	// Check which key changed
	// Capture batch
	if ([keyPath isEqualToString:@"inCaptureBatch"])
	{
		// Check if this is a rising or falling edge of the flag
		if (!oldFlagValue && newFlagValue)
			[self beginCaptureTransaction];
		else if (oldFlagValue && !newFlagValue)
			[self endCaptureTransaction];
	}
	// Clear batch
	else if ([keyPath isEqualToString:@"inClearBatch"])
	{
		// Check if this is a rising or falling edge of the flag
		if (!oldFlagValue && newFlagValue)
			[self beginDeadCellsTransaction];
		else if (oldFlagValue && !newFlagValue)
			[self endDeadCellsTransaction];
	}
}

#pragma mark -
#pragma mark Accessors

@synthesize delegate;

- (void)setGame:(PetriGame*)newGame
{
	// Remove any existing sublayers from the background
	[[self layer] setSublayers:nil];
	
	// Stop observing the old game object
	[self stopObservingBatchesForGame:game];
	
	// If the new game is nil, skip creating new layers
	if (newGame == nil)
	{
		game = nil;
		return;
	}
	
	// Create the new board layer
	boardLayer = [self createBoardLayerForBoard:[newGame board]];
	
	// Create the new container layer
	outerContainerLayer = [self createOuterContainerLayerForBoardLayer:boardLayer];
	[outerContainerLayer addSublayer:boardLayer];
	
	// Add a layer to hold the piece to be played each turn
	pieceContainerLayer = [self pieceContainerLayerForGame:newGame];
	[outerContainerLayer addSublayer:pieceContainerLayer];
	
	// Add a layer containing the status boxes for the players in the game
	playersContainerLayer = [self playersListConstainerLayerForGame:newGame];
	[outerContainerLayer addSublayer:playersContainerLayer];
	
	// Add the container to the view
	[[self layer] addSublayer:outerContainerLayer];
	
	// Start observing the new game object for notifications of capture and clear batches
	[self startObservingBatchesForGame:newGame];
	
	// Hold a reference to the game object
	game = newGame;
}
@synthesize game;

@end
