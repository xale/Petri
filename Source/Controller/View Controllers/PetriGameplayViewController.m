//
//  PetriGameplayViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayViewController.h"

#import "PetriSquareGridBoardLayer.h"
#import "PetriAspectRatioLayer.h"

#import "PetriGame.h"
#import "PetriSquareGridBoard.h"

#import "CALayer+ConstraintSets.h"

NSString* const PetriGameplayViewNibName =	@"GameplayView";

#define PetriGameplayViewBoardLayerScale	0.75

@implementation PetriGameplayViewController

+ (void)initialize
{
	[self exposeBinding:@"game"];
}

- (id)initWithWindowController:(PetriMainWindowController*)windowController
{
	return [super initWithWindowController:windowController
								   nibName:PetriGameplayViewNibName];
}

- (void)awakeFromNib
{
	// Bind to the model
	[self bind:@"game"
	  toObject:[self mainWindowController]
   withKeyPath:@"model.gameGroup.game"
	   options:nil];
	
	// Create a background layer for the view
	CALayer* backgroundLayer = [CALayer layer];
	
	// Add a layout manager
	[backgroundLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Setup the view to be layer-hosting (see discussion under documentation of NSView -setWantsLayer:)
	[gameplayPane setLayer:backgroundLayer];
	[gameplayPane setWantsLayer:YES];
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)endGame:(id)sender
{
	// FIXME: testing code; needs to prompt user, etc.
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

- (IBAction)returnToTitleView:(id)sender
{
	// FIXME: testing code; needs to prompt user, check if host, etc.
	[[self mainWindowController] displayViewControllerForKey:PetriTitleViewControllerKey];
}

#pragma mark -
#pragma mark Accessors

#define PetriGameplayViewNewPieceBoxScaleFactor	0.3
#define PetriGameplayViewContainerLayersSpacing	0.1

- (void)setGame:(PetriGame*)newGame
{
	// Retrieve the background layer for the gameplay pane of the view
	CALayer* backgroundLayer = [gameplayPane layer];
	
	// Remove all current sublayers
	[backgroundLayer setSublayers:nil];
	
	// Determine the aspect ratio for the board layer (based on the board's dimensions)
	// FIXME: TESTING
	PetriSquareGridBoard* board = (PetriSquareGridBoard*)[newGame board];
	CGFloat boardRatio = ((CGFloat)[board width] / (CGFloat)[board height]);
	
	// Add space for the "new piece box" and player-info layers
	CGFloat containerRatio = (boardRatio + PetriGameplayViewNewPieceBoxScaleFactor);
	
	// Create a fixed-aspect-ratio layer to contain the game-related layers
	CALayer* containerLayer = [PetriAspectRatioLayer layerWithAspectRatio:containerRatio];
	[containerLayer setBorderColor:CGColorGetConstantColor(kCGColorWhite)];	// FIXME: debug
	[containerLayer setBorderWidth:1.0];	// FIXME: debug
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	[containerLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Add a layout manager
	[containerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Add the container to the background
	[backgroundLayer addSublayer:containerLayer];
	
	// Create a layer for the game board
	PetriSquareGridBoardLayer* boardLayer = [[PetriSquareGridBoardLayer alloc] initWithBoard:board];
	[boardLayer setName:@"board"];
	
	// Anchor the board to the lower-left corner of the container
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight
															  scale:boardRatio
															 offset:0]];
	
	// Add the board to the container layer
	[containerLayer addSublayer:boardLayer];
	
	// Create a layer for the "next piece box"
	CALayer* nextPieceBoxLayer = [PetriAspectRatioLayer squareLayer];
	[nextPieceBoxLayer setName:@"next piece box"];
	[nextPieceBoxLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)]; // FIXME: debug
	
	// Anchor the next-piece box to the lower-right corner of the container
	[nextPieceBoxLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	[nextPieceBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																relativeTo:@"superlayer"
																 attribute:kCAConstraintHeight
																	 scale:PetriGameplayViewNewPieceBoxScaleFactor
																	offset:0]];
	[nextPieceBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																relativeTo:@"superlayer"
																 attribute:kCAConstraintHeight
																	 scale:PetriGameplayViewNewPieceBoxScaleFactor
																	offset:0]];
	
	// Add the next-piece box to the container layer
	[containerLayer addSublayer:nextPieceBoxLayer];
	
	// Create "status box" layers for each player in the game
	for (NSUInteger playerNum = 0; playerNum < [[newGame players] count]; playerNum++)
	{
		// FIXME: WRITEME
	}
	
	// Hold a reference to the game object
	game = newGame;
}
@synthesize game;

@end
