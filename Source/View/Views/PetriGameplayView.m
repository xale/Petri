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
- (CALayer*)pieceContainerLayerForGame:(PetriGame*)newGame;

/*!
 Creates the layer used as the container for the player-status boxes.
 @param newGame The game with which the view is being initialized.
 */
- (CALayer*)playerBoxesConstainerLayerForGame:(PetriGame*)newGame;

/*!
 Called when the view receives a -mouseDown: event corresponding to a click on a cell of the board.
 */
- (void)boardCellLayerClicked:(PetriBoardCellLayer*)clickedLayer;

/*!
 Called when the view recieves a -mouseDown: event corresponding to a click on the current-piece container layer.
 */
- (void)pieceContainerLayerClicked:(PetriPieceContainerLayer*)clickedLayer;

/*!
 Called when the view receives a -keyDown: event corresponding to a press of the spacebar.
 */
- (void)spacebarDown:(NSEvent*)keyEvent;

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
	PetriBoardLayer* boardLayer = [PetriBoardLayer boardLayerForBoard:newBoard];
	
	// Anchor the board to the lower-left corner of its superlayer
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	
	// Constrain the board's height to the height of its superlayer
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight
															  scale:[boardLayer aspectRatio]
															 offset:0.0]];
	
	return boardLayer;
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
	
	// Add the board to the container layer
	[newContainer addSublayer:newBoardLayer];
	
	return newContainer;
}

- (CALayer*)pieceContainerLayerForGame:(PetriGame*)newGame
{
	// Create a layer
	CALayer* pieceContainerLayer = [[PetriPieceContainerLayer alloc] initWithPiece:[newGame currentPiece]];
	
	// Anchor the layer to the lower-right corner of its superlayer
	[pieceContainerLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	
	// Make the layer square, and size it proportionally to its superlayer
	[pieceContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																  relativeTo:@"superlayer"
																   attribute:kCAConstraintHeight
																	   scale:PetriGameplayViewSidebarProportion
																	  offset:0]];
	[pieceContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																  relativeTo:@"superlayer"
																   attribute:kCAConstraintHeight
																	   scale:PetriGameplayViewSidebarProportion
																	  offset:0]];
	
	// Bind the piece displayed in the layer to the current piece in the game
	[pieceContainerLayer bind:@"piece"
					 toObject:newGame
				  withKeyPath:@"currentPiece"
					  options:nil];
	
	return pieceContainerLayer;
}

- (CALayer*)playerBoxesConstainerLayerForGame:(PetriGame*)newGame
{
	// Create a container layer
	CALayer* playerContainerLayer = [[PetriPlayersListContainerLayer alloc] initWithPlayersList:[newGame players]
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
	NSPoint clickedPoint = [self convertPoint:[mouseEvent locationInWindow]
									 fromView:nil];
	
	// Find the clicked layer
	CALayer* clickedLayer = [[self layer] hitTest:NSPointToCGPoint(clickedPoint)];
	
	// Search the layer's ancestor tree, looking for layers of interest
	for (CALayer* searchLayer = clickedLayer; searchLayer != nil; searchLayer = [searchLayer superlayer])
	{
		// Cell on the board
		if ([searchLayer isKindOfClass:[PetriBoardCellLayer class]])
			[self boardCellLayerClicked:(PetriBoardCellLayer*)searchLayer];
		
		// Piece box
		if ([searchLayer isKindOfClass:[PetriPieceContainerLayer class]])
			[self pieceContainerLayerClicked:(PetriPieceContainerLayer*)searchLayer];
	}
}

- (void)boardCellLayerClicked:(PetriBoardCellLayer*)clickedLayer
{
	// Get cell of the board that was clicked
	PetriBoardCell* clickedCell = [clickedLayer cell];
	
	// Get the board from the clicked cell's superlayer
	id<PetriBoard> clickedBoard = [(PetriBoardLayer*)[clickedLayer superlayer] board];
	
	BOOL validMove = [[self delegate] gameplayView:self
									 canPlacePiece:[[self game] currentPiece]
										 forPlayer:[[self game] currentPlayer]
											onCell:clickedCell
										   ofBoard:clickedBoard];
	if (validMove)
	{
		// Place the current piece on the board
		[[self delegate] gameplayView:self
						   placePiece:[[self game] currentPiece]
							forPlayer:[[self game] currentPlayer]
							   onCell:clickedCell
							  ofBoard:clickedBoard];
	}
}

- (void)pieceContainerLayerClicked:(PetriPieceContainerLayer*)clickedLayer
{
	// FIXME: TESTING
}

- (void)mouseMoved:(NSEvent*)mouseEvent
{
	// FIXME: WRITEME
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
#pragma mark Accessors

@synthesize delegate;

- (void)setGame:(PetriGame*)newGame
{
	// Remove any existing sublayers from the background
	[[self layer] setSublayers:nil];
	
	// Create the new board layer
	PetriBoardLayer* boardLayer = [self createBoardLayerForBoard:[newGame board]];
	
	// Create the new container layer
	CALayer* outerContainerLayer = [self createOuterContainerLayerForBoardLayer:boardLayer];
	
	// Add a layer to hold the piece to be played each turn
	[outerContainerLayer addSublayer:[self pieceContainerLayerForGame:newGame]];
	
	// Add a layer containing the status boxes for the players in the game
	[outerContainerLayer addSublayer:[self playerBoxesConstainerLayerForGame:newGame]];
	
	// Add the container to the view
	[[self layer] addSublayer:outerContainerLayer];
	
	// Hold a reference to the game object
	game = newGame;
}
@synthesize game;

@end
