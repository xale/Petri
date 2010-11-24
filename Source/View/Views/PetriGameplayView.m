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
#import "PetriBoardCell.h"
#import "PetriPiece.h"

#import "PetriAspectRatioLayer.h"
#import "PetriBoardLayer.h"
#import "PetriBoardCellLayer.h"
#import "PetriPieceLayer.h"

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
 Creates the layer used as the container for the next piece.
 */
- (CALayer*)createNextPieceBoxLayer;

/*!
 Creates the layer used as the container for the player-status boxes.
 */
- (CALayer*)createPlayerBoxesConstainerLayer;

/*!
 Creates new player-status boxes for the specified players list.
 @param playersList The new list of players for which to create status boxes.
 */
- (NSArray*)createStatusBoxLayersForPlayers:(NSArray*)playersList;

@end

@implementation PetriGameplayView

+ (void)initialize
{
	[self exposeBinding:@"players"];
	[self exposeBinding:@"currentPlayer"];
	[self exposeBinding:@"board"];
	[self exposeBinding:@"currentPiece"];
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
	
	// Create container layers, but do not add them to the view yet
	nextPieceBoxLayer = [self createNextPieceBoxLayer];
	playerBoxesConstainerLayer = [self createPlayerBoxesConstainerLayer];
}

#pragma mark -
#pragma mark Drawing Attributes

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

- (CALayer*)createNextPieceBoxLayer
{
	// Create a layer
	CALayer* boxLayer = [PetriAspectRatioLayer squareLayer];
	[boxLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	[boxLayer setCornerRadius:8.0];
	[boxLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.8)]; // FIXME: debug
	
	// Anchor the layer to the lower-right corner of its superlayer
	[boxLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	
	// Make the layer square, and size it proportionally to its superlayer
	[boxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
													   relativeTo:@"superlayer"
														attribute:kCAConstraintHeight
															scale:PetriGameplayViewSidebarProportion
														   offset:0]];
	[boxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
													   relativeTo:@"superlayer"
														attribute:kCAConstraintHeight
															scale:PetriGameplayViewSidebarProportion
														   offset:0]];
	
	return boxLayer;
}

- (CALayer*)createPlayerBoxesConstainerLayer
{
	// Create a container layer
	CALayer* playerContainerLayer = [CALayer layer];
	[playerContainerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Anchor the container to the top-right corner of its superlayer
	[playerContainerLayer addConstraintsFromSet:[CAConstraint superlayerUpperRightCornerConstraintSet]];
	
	// Constrain the container to fill the right-edge "sidebar" of the superlayer (leaving space for the next-piece box below)
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
	
	return playerContainerLayer;
}

- (NSArray*)createStatusBoxLayersForPlayers:(NSArray*)playersList
{
	CGFloat playerSlotsCount = (CGFloat)4;	// FIXME: hardcoded value
	
	// Create "status box" layers for each player in the game
	NSMutableArray* statusBoxes = [NSMutableArray arrayWithCapacity:[playersList count]];
	for (NSUInteger playerNum = 0; playerNum < [playersList count]; playerNum++)
	{
		CALayer* statusBoxLayer = [CALayer layer];
		[statusBoxLayer setCornerRadius:8.0];
		
		// Color the layer according to the player's color
		NSColor* playerColor = [[playersList objectAtIndex:playerNum] color];
		[statusBoxLayer setBackgroundColor:CGColorCreateGenericRGB([playerColor redComponent], [playerColor greenComponent], [playerColor blueComponent], 0.8)];	// FIXME: debug
		
		// Anchor the status box to the left edge of the container
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMinX]];
		
		// Position the status box a proportional distance from the top of the container
		CGFloat topPositionScale = ((playerSlotsCount - playerNum) / playerSlotsCount);
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMaxY
																	  scale:topPositionScale
																	 offset:0]];
		
		// Size the status box to fill the container layer horizontally
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintWidth]];
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintHeight
																	  scale:(1.0 / playerSlotsCount)
																	 offset:0]];
		
		[statusBoxes addObject:statusBoxLayer];
	}
	
	return [statusBoxes copy];
}

#pragma mark -
#pragma mark Input Events

- (void)mouseDown:(NSEvent*)mouseEvent
{
	// Determine where on the view the click occurred
	NSPoint clickedPoint = [self convertPoint:[mouseEvent locationInWindow]
									 fromView:nil];
	
	// Find the clicked layer
	CALayer* clickedLayer = [[self layer] hitTest:NSPointToCGPoint(clickedPoint)];
	
	// FIXME: TESTING: If the clicked layer is a cell of the board, place a one-by-one piece
	if ([clickedLayer isKindOfClass:[PetriBoardCellLayer class]])
	{
		// Get the board from the clicked cell's superlayer
		id<PetriBoard> clickedBoard = [(PetriBoardLayer*)[clickedLayer superlayer] board];
		
		// Get cell of the board that was clicked
		PetriBoardCell* clickedCell = [(PetriBoardCellLayer*)clickedLayer cell];
		
		// Test if the piece can be placed at the clicked coordinates
		/* FIXME: TESTING
		 BOOL validMove = [[self delegate] gameplayView:self
										 canPlacePiece:[self currentPiece]
											 forPlayer:[self currentPlayer]
												onCell:clickedCell
											   ofBoard:clickedBoard];
		 */
		BOOL validMove = YES;
		if (validMove)
		{
			// Place the piece
			[[self delegate] gameplayView:self
							   placePiece:[self currentPiece]
								forPlayer:[self currentPlayer]
								   onCell:clickedCell
								  ofBoard:clickedBoard];
		}
	}
}

#pragma mark -
#pragma mark Accessors

@synthesize delegate;

@synthesize players;
@synthesize currentPlayer;

- (void)setBoard:(id<PetriBoard>)newBoard
{
	// If it exists, remove the current container layer from the background
	[outerContainerLayer removeFromSuperlayer];
	
	// Create the new board layer
	PetriBoardLayer* boardLayer = [self createBoardLayerForBoard:newBoard];
	
	// Calculate the aspect ratio of the new container layer, based on the new board's aspect ratio
	CGFloat containerRatio = ([boardLayer aspectRatio] + PetriGameplayViewSidebarProportion);
	
	// (Re-)create the container layer
	outerContainerLayer = [PetriAspectRatioLayer layerWithAspectRatio:containerRatio];
	[outerContainerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Constrain the container layer to fill the view
	[outerContainerLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[outerContainerLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Add the board to the container layer
	[outerContainerLayer addSublayer:boardLayer];
	
	// Add a layer to hold the piece to be played each turn
	[outerContainerLayer addSublayer:nextPieceBoxLayer];
	
	// Add a layer containing the status boxes for the players in the game
	[outerContainerLayer addSublayer:playerBoxesConstainerLayer];
	
	// Add the container to the view
	[[self layer] addSublayer:outerContainerLayer];
	
	// Hold a reference to the board object
	board = newBoard;
}
@synthesize board;

- (void)setCurrentPiece:(PetriPiece*)newPiece
{
	// Create a piece layer
	CALayer* pieceLayer = [PetriPieceLayer pieceLayerForPiece:newPiece];
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Place the layer in the new-piece box
	[nextPieceBoxLayer setSublayers:[NSArray arrayWithObject:pieceLayer]];
	
	// Hold a reference to the board object
	currentPiece = newPiece;
}
@synthesize currentPiece;

@end
