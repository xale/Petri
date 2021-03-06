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
#import "PetriItem.h"

#import "PetriAspectRatioLayer.h"
#import "PetriBoardLayer.h"
#import "PetriBoardCellLayer.h"
#import "PetriPlayerStatusLayer.h"
#import "PetriPlayersListContainerLayer.h"
#import "PetriPieceLayer.h"
#import "PetriPieceContainerLayer.h"
#import "PetriItemLayer.h"
#import "PetriItemStackLayer.h"

#import "NSArray+Subranges.h"
#import "CALayer+ConstraintSets.h"

/*!
 Private methods on PetriGameplayView.
 */
@interface PetriGameplayView(Private)

#pragma mark View Layout

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
 Creates a layer used as an overlay when the game ends, displaying the "game over" message.
 */
- (CALayer*)gameOverLayerForGame:(PetriGame*)newGame;

#pragma mark Input Events

/*!
 Returns the deepest layer in the outer container layer's ancestor tree whose bounds contain the specified point in the window's coordinate system.
 */
- (CALayer*)hitTestContainerLayerAtWindowLocation:(NSPoint)locationInWindow;

/*!
 Called when the view receives a -mouseDown: event corresponding to a click on a layer representing a cell of the board.
 */
- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
	   onBoardCellLayer:(PetriBoardCellLayer*)clickedLayer;

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
 Called when the view recieves a -mouseDown: event corresponding to a click on a stack of items in a player's inventory.
 */
- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
	   onItemStackLayer:(PetriItemStackLayer*)clickedLayer;

/*!
 Called when the view receives a -mouseUp: event corresponding to a click-release over the layer representing the board.
 */
- (BOOL)handleMouseUp:(NSEvent*)mouseEvent
	   overBoardLayer:(PetriBoardLayer*)clickedLayer;

/*!
 Called when the view receives a -keyDown: event corresponding to a press of the spacebar.
 */
- (void)spacebarDown:(NSEvent*)keyEvent;

#pragma mark Carried-Piece Methods

/*!
 Returns a the cell on the board located beneath the origin cell of the carried piece, or nil if no such cell is present.
 */
- (PetriBoardCell*)cellUnderCarriedPieceOrigin;

/*!
 Tests if the current position of the carried piece is valid for placement on the board.
 */
- (BOOL)canPlaceCarriedPiece;

/*!
 Checks if the carried piece's origin has moved from the previous highlighted placement location, and highlights the new location if necessary.
 */
- (void)updatePieceHighlight;

/*!
 Highlights cells on the board in the shape of the current piece, with its origin at the specified cell.
 */
- (void)forceUpdatePieceHighlightForDestinationCell:(PetriBoardCell*)cell;

/*!
 Removes the carried piece layer, if any, from the cursor, and optionally returns it to its container.
 */
- (void)dropCarriedPieceAndReturnToContainer:(BOOL)returnToContainer;

#pragma mark Carried-Item Methods

/*!
 Tests if the current item targets are valid for using the currently-carried item.
 */
- (BOOL)canUseCarriedItem;

/*!
 Highlights the cells on the board targeted by the currently-carried item.
 */
- (void)updateItemTargetHighlight;

/*!
 Removes the carried item, if any, from the cursor.
 */
- (void)dropCarriedItem;

#pragma mark Clearing Highlights

/*!
 Un-highlights any highlighted cells on the board.
 */
- (void)clearBoardHighlight;

#pragma mark Model-Event Transactions

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

#define PetriGameplayViewGameOverOverlayOpacity	0.5

NSString* const PetriGameplayViewGameOverOverlayString =	@"Game Over";
NSString* const PetriGameplayViewGameOverOverlayFontName =	@"Arial Rounded MT Bold";
#define	PetriGameplayViewGameOverOverlayFontSize	60.0

- (CALayer*)gameOverLayerForGame:(PetriGame*)newGame
{
	// Create a (hidden) overlay layer
	CALayer* overlayLayer = [CALayer layer];
	[overlayLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Give the layer a semitransparent black background
	CGColorRef overlayColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, PetriGameplayViewGameOverOverlayOpacity);
	[overlayLayer setBackgroundColor:overlayColor];
	CGColorRelease(overlayColor);
	
	// Size the layer to the full size of the view
	[overlayLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	[overlayLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	
	// Create a text sublayer
	CATextLayer* gameOverTextLayer = [CATextLayer layer];
	[gameOverTextLayer setString:PetriGameplayViewGameOverOverlayString];
	
	// Configure the text attributes
	CTFontRef gameOverFont = CTFontCreateWithName((CFStringRef)PetriGameplayViewGameOverOverlayFontName, 0.0, NULL);
	[gameOverTextLayer setFont:gameOverFont];
	CFRelease(gameOverFont);
	[gameOverTextLayer setFontSize:PetriGameplayViewGameOverOverlayFontSize];
	[gameOverTextLayer setAlignmentMode:kCAAlignmentCenter];
	
	// Size the text layer to center on the overlay
	[gameOverTextLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[gameOverTextLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																relativeTo:@"superlayer"
																 attribute:kCAConstraintWidth]];
	 
	// Add the text sublayer to the overlay
	[overlayLayer addSublayer:gameOverTextLayer];
	
	// Make the overlay visible only when the game ends
	[overlayLayer bind:@"hidden"
			  toObject:newGame
		   withKeyPath:@"gameOver"
			   options:[NSDictionary dictionaryWithObject:NSNegateBooleanTransformerName
												   forKey:NSValueTransformerNameBindingOption]];
	
	return overlayLayer;
}

#pragma mark -
#pragma mark Input Events

- (IBAction)dropCarriedObjects:(id)sender
{
	[self dropCarriedPieceAndReturnToContainer:YES];
	[self dropCarriedItem];
}

- (CALayer*)hitTestContainerLayerAtWindowLocation:(NSPoint)locationInWindow
{
	// Determine where on the view the click occurred
	CGPoint clickedPoint = NSPointToCGPoint([self convertPoint:locationInWindow fromView:nil]);
	
	// Get the deepest layer in the hierarchy that was clicked
	return [outerContainerLayer hitTest:clickedPoint];
}

#pragma mark Mouse Down

- (void)mouseDown:(NSEvent*)mouseEvent
{
	// If the game is over, disregard input events
	if ([[self game] isGameOver])
		return;
	
	// Get the deepest layer in the hierarchy that was clicked
	CALayer* clickedLayer = [self hitTestContainerLayerAtWindowLocation:[mouseEvent locationInWindow]];
	
	// Search the layer hierarchy under the mouse for layers of interest
	for (CALayer* searchLayer = clickedLayer; searchLayer != nil; searchLayer = [searchLayer superlayer])
	{
		// Cell on the board
		if ([searchLayer isKindOfClass:[PetriBoardCellLayer class]])
		{
			if ([self handleMouseDown:mouseEvent onBoardCellLayer:(PetriBoardCellLayer*)searchLayer])
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
		
		// A stack of items
		if ([searchLayer isKindOfClass:[PetriItemStackLayer class]])
		{
			if ([self handleMouseDown:mouseEvent onItemStackLayer:(PetriItemStackLayer*)searchLayer])
				return;
		}
	}
}

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
	   onBoardCellLayer:(PetriBoardCellLayer*)clickedLayer
{
	// If the cursor is not carrying an item, ignore this event
	if (carriedItem == nil)
		return NO;
	
	// Add this cell to a list of targeted cells
	if (itemTargets == nil)
		itemTargets = [NSMutableArray array];
	[itemTargets addObject:clickedLayer];
	
	// Update item-target highlighting
	[self updateItemTargetHighlight];
	
	// Event handled
	return YES;
}

#define PetriGameplayViewCarriedPieceOpacity	0.5

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
		   onPieceLayer:(PetriPieceLayer*)clickedLayer
{
	// If the cursor is already carrying a piece, ignore this event
	if (carriedPiece != nil)
		return NO;
	
	// If the cursor is carrying an item, drop it
	[self dropCarriedItem];
	
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
	
	// Set a "grabby hand" cursor
	[[NSCursor closedHandCursor] push];
	
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
	[self dropCarriedPieceAndReturnToContainer:YES];
	
	// Event handled
	return YES;
}

- (BOOL)handleMouseDown:(NSEvent*)mouseEvent
	   onItemStackLayer:(PetriItemStackLayer*)clickedLayer
{
	// If the cursor is carrying a piece, drop it
	[self dropCarriedPieceAndReturnToContainer:YES];
	
	// Get the player box containing this layer
	PetriPlayerStatusLayer* playerBox = (PetriPlayerStatusLayer*)[clickedLayer superlayer];
	
	// If it is not this player's turn, ignore event
	if (![[playerBox player] isEqual:[[self game] currentPlayer]])
		return NO;
	
	// If the cursor is already carrying an item, drop it
	if (carriedItem != nil)
	{
		PetriItem* temp = carriedItem;
		[self dropCarriedItem];
		
		// If the clicked item is the carried one, don't pick up a new one
		if ([temp isEqual:[clickedLayer item]])
			return YES;	// Event handled
	}
	
	// "Pick up" the item in the clicked stack
	carriedItem = [clickedLayer item];
	
	// Use the item's icon as a cursor
	NSImage* itemIcon = [carriedItem icon];
	NSCursor* itemCursor = [[NSCursor alloc] initWithImage:itemIcon
												   hotSpot:NSMakePoint(([itemIcon size].width / 2),
																	   ([itemIcon size].height / 2))];
	[itemCursor push];
	
	// Highlight the picked-up item in the stack
	[playerBox highlightTopItemOfStack:clickedLayer];
	
	// Event handled
	return YES;
}

#pragma mark Mouse Up

- (void)mouseUp:(NSEvent*)mouseEvent
{
	// If the game is over, disregard input events
	if ([[self game] isGameOver])
		return;
	
	// Get the deepest layer in the hierarchy that was clicked
	CALayer* layerUnderCursor = [self hitTestContainerLayerAtWindowLocation:[mouseEvent locationInWindow]];
	
	// Search the layer hierarchy under the mouse for layers of interest
	for (CALayer* searchLayer = layerUnderCursor; searchLayer != nil; searchLayer = [searchLayer superlayer])
	{
		// The board
		if ([searchLayer isKindOfClass:[PetriBoardLayer class]])
		{
			if ([self handleMouseUp:mouseEvent overBoardLayer:(PetriBoardLayer*)searchLayer])
				return;
		}
	}
	
	// If we were in the middle of an item-target-selection drag, clear targets
	[itemTargets removeAllObjects];
	[self updateItemTargetHighlight];
}

- (BOOL)handleMouseUp:(NSEvent*)mouseEvent
	   overBoardLayer:(PetriBoardLayer*)clickedLayer
{
	// Check if the cursor is carrying a piece
	if (carriedPiece != nil)
	{
		// Check if the piece can be placed at the piece's current position
		if (![self canPlaceCarriedPiece])
			return NO;
		
		// Place the current piece on the board
		[[self delegate] gameplayView:self
						   placePiece:[[self game] currentPiece]
							forPlayer:[[self game] currentPlayer]
							   onCell:destinationCell
							  ofBoard:[[self game] board]];
		
		// "Drop" the carried piece, and do not return it to its container
		[self dropCarriedPieceAndReturnToContainer:NO];
		
		// Event handled
		return YES;
	}
	// Check if the cursor is carrying an item
	else if (carriedItem != nil)
	{
		// Check if the item can be used on the current list of targets
		if (![self canUseCarriedItem])
		{
			// If the item can't be used here, clear the list of targets
			[itemTargets removeAllObjects];
			
			// Clear highlighting
			[self clearBoardHighlight];
			
			return YES;	// Event handled
		}
		
		// If the item can be used, use it
		// Get the cells from the targeted layers
		NSMutableArray* targetedCells = [NSMutableArray arrayWithCapacity:[itemTargets count]];
		for (PetriBoardCellLayer* cellLayer in itemTargets)
		{
			[targetedCells addObject:[cellLayer cell]];
		}
		
		// Use the item
		[[self delegate] gameplayView:self
							  useItem:carriedItem
							forPlayer:[[self game] currentPlayer]
							  onCells:targetedCells
							  ofBoard:[[self game] board]];
		
		// Drop the used item from the cursor
		[self dropCarriedItem];
		
		// Event handled
		return YES;
	}
	
	// Nothing to do; event not handled
	return NO;
}

#pragma mark Mouse Tracking

- (void)mouseDragged:(NSEvent*)mouseEvent
{
	// If the game is over, disregard input events
	if ([[self game] isGameOver])
		return;
	
	// If the cursor is carrying a piece, treat this as a mouse-move event
	if (carriedPiece != nil)
	{
		[self mouseMoved:mouseEvent];
		return;
	}
	
	// If the cursor is not carrying a piece or an item, disregard this event
	if (carriedItem == nil)
		return;
	
	// Check the location under the cursor for board cell layers
	CALayer* layerUnderCursor = [self hitTestContainerLayerAtWindowLocation:[mouseEvent locationInWindow]];
	
	// If the layer is not a cell of the board, ignore this event
	if (![layerUnderCursor isKindOfClass:[PetriBoardCellLayer class]])
		return;
	
	// Determine if this layer is already in the list of targeted layers
	PetriBoardCellLayer* cellLayer = (PetriBoardCellLayer*)layerUnderCursor;
	NSUInteger targetIndex = [itemTargets indexOfObject:cellLayer];
	
	// If the layer is not in the list of targeted layers, add it
	if (targetIndex == NSNotFound)
	{
		[itemTargets addObject:cellLayer];
		
		// Update highlighting for the item targets
		[self updateItemTargetHighlight];
	}
	// If the layer is in the list, (and not the last item) truncate the list to make this the last object
	else if (targetIndex != ([itemTargets count] - 1))
	{
		itemTargets = [NSMutableArray arrayWithArray:[itemTargets subarrayToIndex:(targetIndex + 1)]];
		
		// Update highlighting for the item targets
		[self updateItemTargetHighlight];
	}
}

- (void)mouseMoved:(NSEvent*)mouseEvent
{
	// If the game is over, disregard input events
	if ([[self game] isGameOver])
		return;
	
	// If the cursor is not carrying a piece, ignore this event
	if (carriedPiece == nil)
		return;
	
	// Disable movement animation for the carried piece, since it will slow things down and is unnecessary
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	// Move the piece with the cursor
	NSPoint mousePoint = [self convertPoint:[mouseEvent locationInWindow]
								   fromView:nil];
	[carriedPiece setPosition:NSPointToCGPoint(mousePoint)];
	
	[CATransaction commit];
	
	// Update the highlighted cells under the piece
	[self updatePieceHighlight];
}

#pragma mark Keyboard

- (void)keyDown:(NSEvent*)keyEvent
{
	// If the game is over, disregard input events
	if ([[self game] isGameOver])
		return;
	
	// Check for specific keys of interest
	// Spacebar (rotate piece)
	if ([[keyEvent characters] isEqualToString:@" "])
	{
		[self spacebarDown:keyEvent];
		return;
	}
	
	// Not of interest, see if our superclass cares
	[super keyDown:keyEvent];
}

- (void)spacebarDown:(NSEvent*)keyEvent
{
	// If carrying an item, drop it (shortcut)
	[self dropCarriedItem];
	
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
		
		// Update the highlighted cells under the piece
		// Uses a forced update, since the piece's origin may be in the same cell as before the rotation, but the piece's configuration has changed
		[self forceUpdatePieceHighlightForDestinationCell:[self cellUnderCarriedPieceOrigin]];
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

- (BOOL)canPlaceCarriedPiece
{
	// Check if the piece is aligned with a destination cell
	if (destinationCell == nil)
		return NO;
	
	// Check if the piece can be placed at the destination cell
	return [[self delegate] gameplayView:self
						   canPlacePiece:[[self game] currentPiece]
							   forPlayer:[[self game] currentPlayer]
								  onCell:destinationCell
								 ofBoard:[[self game] board]];
}

- (void)updatePieceHighlight
{
	// Get the cell under the carried piece's origin
	PetriBoardCell* cellUnderPieceOrigin = [self cellUnderCarriedPieceOrigin];
	
	// If the piece's position hasn't changed, do nothing
	if (((cellUnderPieceOrigin == nil) && (destinationCell == nil)) || [cellUnderPieceOrigin isEqual:destinationCell])
		return;
	
	[self forceUpdatePieceHighlightForDestinationCell:cellUnderPieceOrigin];
}

- (void)forceUpdatePieceHighlightForDestinationCell:(PetriBoardCell*)cell
{
	// If the piece isn't over a cell, clear highlighting
	if (cell == nil)
	{
		[self clearBoardHighlight];
		destinationCell = nil;
		return;
	}
	
	// Update the piece's position
	destinationCell = cell;
	
	// Get the cells on which the piece would lie if placed
	NSSet* cellsUnderPiece = [[[self game] board] cellsCoveredByPlacingPiece:[[self game] currentPiece]
																	  onCell:destinationCell];
	
	// Get the corresponding layers on the board
	NSSet* layersUnderPiece = [boardLayer cellLayersForCells:cellsUnderPiece];
	
	// Test if the piece's current position is valid for placement
	BOOL validPlacementPosition = [self canPlaceCarriedPiece];
	
	// Highlight the set of cells
	[boardLayer highlightCells:layersUnderPiece
					   asValid:validPlacementPosition];
}

- (void)dropCarriedPieceAndReturnToContainer:(BOOL)returnToContainer
{
	// If not carrying a piece, do nothing
	if (carriedPiece == nil)
		return;
	
	// If necessary, reveal the piece in the container
	if (returnToContainer)
		[pieceContainerLayer setPieceHidden:NO];
	
	// Remove the carried piece from the background layer
	[carriedPiece removeFromSuperlayer];
	carriedPiece = nil;
	
	// Remove the grabby-hand cursor
	[NSCursor pop];
	
	// Clear the current destination cell
	destinationCell = nil;
	
	// Clear the highlighted cells under the piece
	[self clearBoardHighlight];
}

#pragma mark -
#pragma mark Carried-Item Methods

- (BOOL)canUseCarriedItem
{
	// FIXME: needs to account for different types of target layers
	// Get the cells associated with the target layers
	NSMutableArray* cells = [NSMutableArray arrayWithCapacity:[itemTargets count]];
	for (PetriBoardCellLayer* cellLayer in itemTargets)
	{
		[cells addObject:[cellLayer cell]];
	}
	
	// Ask the delegate for validation
	return [[self delegate] gameplayView:self
							  canUseItem:carriedItem
							   forPlayer:[[self game] currentPlayer]
								 onCells:cells
								 ofBoard:[[self game] board]];
}

- (void)updateItemTargetHighlight
{
	// FIXME: needs to account for different types of target layers; for now, assume all are board cells
	[boardLayer highlightCells:[NSSet setWithArray:itemTargets]
					   asValid:[self canUseCarriedItem]];
}

- (void)dropCarriedItem
{
	// If not carrying an item, do nothing
	if (carriedItem == nil)
		return;
	
	// FIXME: hacky
	for (PetriPlayerStatusLayer* playerBox in [playersContainerLayer sublayers])
		[playerBox highlightTopItemOfStack:nil];
	
	// Remove the item from the cursor
	[NSCursor pop];
	carriedItem = nil;
	
	// Clear the list of targeted layers
	[itemTargets removeAllObjects];
	
	// Clear any highlighted cells
	[self clearBoardHighlight];
	
}

#pragma mark -
#pragma mark Clearing Highlights

- (void)clearBoardHighlight
{
	// Un-highlight the highlighted cells
	[boardLayer highlightCells:nil
					   asValid:YES];
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

#define PetriGameplayViewDeadCellsAnimationDuration	2.5	// Seconds

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

- (void)setFrame:(NSRect)frameRect
{
	[super setFrame:frameRect];
	
	// If the cursor is carrying a piece, resize it
	if (carriedPiece != nil)
		[boardLayer scalePieceLayerToCellSize:carriedPiece];
}

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
	
	// Add the "game over" overlay (hidden) to the view
	[[self layer] addSublayer:[self gameOverLayerForGame:newGame]];
	
	// Start observing the new game object for notifications of capture and clear batches
	[self startObservingBatchesForGame:newGame];
	
	// Hold a reference to the game object
	game = newGame;
}
@synthesize game;

@end
