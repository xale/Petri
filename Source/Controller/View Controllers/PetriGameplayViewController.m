//
//  PetriGameplayViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayViewController.h"

#import "PetriGame.h"
#import "PetriBoard.h"
#import "PetriGridBoard.h"

NSString* const PetriGameplayViewNibName =	@"GameplayView";

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
	
	// Bind the gameplay view to this controller
	[gameplayPane bind:@"game"
			  toObject:self
		   withKeyPath:@"game"
			   options:nil];
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
#pragma mark PetriGameplayView Delegate Methods

- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
	   canPlacePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
	   atCoordinates:(Petri2DCoordinates*)coordinates
		 onGridBoard:(PetriGridBoard*)board
{
	return [board isValidPlacementForPiece:piece
								atLocation:coordinates
								withPlayer:pieceOwner];
}

- (void)gameplayView:(PetriGameplayView*)gameplayView
		  placePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
	   atCoordinates:(Petri2DCoordinates*)coordinates
			 onBoard:(PetriGridBoard*)board
{
	// FIXME: naive implementation
	[board placePiece:piece
		   atLocation:coordinates
			withOwner:pieceOwner];
}

#pragma mark -
#pragma mark Accessors

@synthesize game;

@end
