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
	[gameplayPane bind:@"players"
			  toObject:self
		   withKeyPath:@"game.players"
			   options:nil];
	[gameplayPane bind:@"currentPlayer"
			  toObject:self
		   withKeyPath:@"game.currentPlayer"
			   options:nil];
	[gameplayPane bind:@"board"
			  toObject:self
		   withKeyPath:@"game.board"
			   options:nil];
	[gameplayPane bind:@"currentPiece"
			  toObject:self
		   withKeyPath:@"game.currentPiece"
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
			  onCell:(PetriBoardCell*)cell
			 ofBoard:(id<PetriBoard>)board
{
	return [board validatePlacementOfPiece:piece
								 withOwner:pieceOwner
									onCell:cell];
}

- (void)gameplayView:(PetriGameplayView*)gameplayView
		  placePiece:(PetriPiece*)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)cell
			 ofBoard:(id<PetriBoard>)board
{
	// Place the piece on the board
	[board placePiece:piece
			withOwner:pieceOwner
			   onCell:cell];
	
	// Advance to the next player's turn
	[[self game] nextTurn];
	
	// FIXME: WRITEME
}

#pragma mark -
#pragma mark Accessors

@synthesize game;

@end
