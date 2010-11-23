//
//  PetriGameplayView.m
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayView.h"

#import "PetriGame.h"
#import "PetriGridBoard.h"
#import "PetriSquareGridBoard.h"
#import "PetriPlayer.h"

#import "PetriAspectRatioLayer.h"
#import "PetriGridBoardLayer.h"
#import "PetriSquareGridBoardLayer.h"

#import "CALayer+ConstraintSets.h"

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
}

#pragma mark -
#pragma mark View Layout

#define PetriGameplayViewSidebarProportion		0.3

- (CALayer*)boardLayerForGame:(PetriGame*)newGame
{
	// Create a layer for the game board
	// FIXME: testing: should use reflection + class factory to initialize correct board layer type
	PetriSquareGridBoard* board = (PetriSquareGridBoard*)[newGame board];
	PetriSquareGridBoardLayer* boardLayer = [[PetriSquareGridBoardLayer alloc] initWithBoard:board];
	
	// Anchor the board to the lower-left corner of the container
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	
	// Constrain the board's height to the height of its superlayer
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight]];
	
	// FIXME: should be handled by the board layer itself =============================
	// Calculate the board's aspect ratio
	CGFloat boardRatio = ((CGFloat)[board width] / (CGFloat)[board height]);
	
	// Constrain the board's width to the height of its superlayer, times the board's aspect ratio
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight
															  scale:boardRatio
															 offset:0]];
	// FIXME: =========================================================================
	
	return boardLayer;
}

- (CALayer*)nextPieceBoxLayerForGame:(PetriGame*)newGame
{
	// Create a layer
	CALayer* nextPieceBoxLayer = [CALayer layer];
	[nextPieceBoxLayer setCornerRadius:8.0];
	[nextPieceBoxLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.8)]; // FIXME: debug
	
	// Anchor the layer to the lower-right corner of its superlayer
	[nextPieceBoxLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	
	// Make the layer square, and size it proportionally to its superlayer
	[nextPieceBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																relativeTo:@"superlayer"
																 attribute:kCAConstraintHeight
																	 scale:PetriGameplayViewSidebarProportion
																	offset:0]];
	
	// FIXME: should be handled by the layer itself ===================================
	[nextPieceBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																relativeTo:@"superlayer"
																 attribute:kCAConstraintHeight
																	 scale:PetriGameplayViewSidebarProportion
																	offset:0]];
	// FIXME: =========================================================================
	
	return nextPieceBoxLayer;
}

- (CALayer*)playerStatusBoxesLayerForGame:(PetriGame*)newGame
{
	// Create a container layer
	CALayer* containerLayer = [CALayer layer];
	[containerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Anchor the container to the top-right corner of its superlayer
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerUpperRightCornerConstraintSet]];
	
	// Constrain the container to fill the right-edge "sidebar" of the superlayer (leaving space for the next-piece box below)
	[containerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:(1.0 - PetriGameplayViewSidebarProportion)
																 offset:0]];
	[containerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriGameplayViewSidebarProportion
																 offset:0]];
	
	// Create "status box" layers for each player in the game
	for (NSUInteger playerNum = 0; playerNum < [[newGame players] count]; playerNum++)
	{
		CALayer* statusBoxLayer = [CALayer layer];
		[statusBoxLayer setCornerRadius:8.0];
		
		// Color the layer according to the player's color
		NSColor* playerColor = [[[newGame players] objectAtIndex:playerNum] color];
		[statusBoxLayer setBackgroundColor:CGColorCreateGenericRGB([playerColor redComponent], [playerColor greenComponent], [playerColor blueComponent], 0.8)];	// FIXME: debug
		
		// Anchor the status box to the left edge of the container
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMinX]];
		
		CGFloat playerSlotsCount = (CGFloat)4;	// FIXME: hardcoded value
		
		// Position the status box a proportional distance from the top of the container
		CGFloat topPositionScale = ((playerSlotsCount - playerNum) / playerSlotsCount);
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMaxY
																	  scale:topPositionScale
																	 offset:0]];
		
		// Size the status box to fill a proportional amount of the container layer
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintWidth]];
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintHeight
																	  scale:(1.0 / playerSlotsCount)
																	 offset:0]];
		
		// Add each status box to the container layer
		[containerLayer addSublayer:statusBoxLayer];
	}
	
	return containerLayer;
}

#pragma mark -
#pragma mark Accessors

- (void)setGame:(PetriGame*)newGame
{
	// Retrieve the view's hosted layer
	CALayer* backgroundLayer = [self layer];
	
	// Remove all current sublayers
	[backgroundLayer setSublayers:nil];
	
	// Determine the aspect ratio for the board layer (based on the board's dimensions)
	// FIXME: too fragile; needs sturdier mechanism
	PetriSquareGridBoard* board = (PetriSquareGridBoard*)[newGame board];
	CGFloat boardRatio = ((CGFloat)[board width] / (CGFloat)[board height]);
	
	// Add space for the new-piece-box and player-status-box layers
	CGFloat containerRatio = (boardRatio + PetriGameplayViewSidebarProportion);
	
	// Create a fixed-aspect-ratio layer as a container for the other layers
	CALayer* containerLayer = [PetriAspectRatioLayer layerWithAspectRatio:containerRatio];
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Add a layout manager
	[containerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Add the container to the background
	[backgroundLayer addSublayer:containerLayer];
	
	// Add a layer for the board to the container
	[containerLayer addSublayer:[self boardLayerForGame:newGame]];
	
	// Add a layer to hold the piece to be played each turn
	[containerLayer addSublayer:[self nextPieceBoxLayerForGame:newGame]];
	
	// Add a layer containing the status boxes for the players in the game
	[containerLayer addSublayer:[self playerStatusBoxesLayerForGame:newGame]];
	
	// Hold a reference to the game object
	game = newGame;
}
@synthesize game;

@end
