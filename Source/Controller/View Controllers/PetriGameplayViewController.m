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
canRotateCurrentPiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner
{
	// FIXME: check that the player performing the rotation is local to the machine
	return YES;
}

- (void)gameplayView:(PetriGameplayView*)gameplayView
  rotateCurrentPiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner
{
	// Ask the game to rotate the current piece
	[[self game] rotateCurrentPiece];
	
	// FIXME: anything else?
}

- (BOOL)gameplayView:(PetriGameplayView*)gameplayView
	   canPlacePiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)cell
			 ofBoard:(id<PetriBoard>)board
{
	return [board validatePlacementOfPiece:piece
								 withOwner:pieceOwner
									onCell:cell];
}

- (void)gameplayView:(PetriGameplayView*)gameplayView
		  placePiece:(id<PetriPiece>)piece
		   forPlayer:(PetriPlayer*)pieceOwner
			  onCell:(PetriBoardCell*)cell
			 ofBoard:(id<PetriBoard>)board
{
	// Place the piece on the board
	[gameplayView beginPiecePlacementTransaction];
	[board placePiece:piece
			withOwner:pieceOwner
			   onCell:cell];
	[gameplayView endPiecePlacementTransaction];
	
	// Perform captures for the player who placed the piece
	BOOL flag = NO;
	
	do
	{
		[gameplayView beginCaptureTransaction];
		flag = [[self game] stepCapturesForCurrentPlayer];
		[gameplayView endCaptureTransaction];
	} while (flag);
	// Clean up any dead cells
	[gameplayView beginDeadCellsTransaction];
	[[self game] clearDeadCells];
	[gameplayView endDeadCellsTransaction];
	
	// Advance to the next player's turn
	[[self game] nextTurn];
}

#pragma mark -
#pragma mark Accessors

@synthesize game;

@end
