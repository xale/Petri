//
//  PetriGameplayViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayViewController.h"

#import "PetriSquareGridBoardLayer.h"

#import "PetriSquareGridBoard.h"

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
	
	// Create a layer for the board
	// FIXME: TESTING
	PetriSquareGridBoardLayer* boardLayer = [[PetriSquareGridBoardLayer alloc] initWithBoard:[[PetriSquareGridBoard alloc] initWithWidth:10
																																  height:10]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintMinX]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintMaxY]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintWidth]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight]];
	[backgroundLayer addSublayer:boardLayer];
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

@synthesize game;

@end
