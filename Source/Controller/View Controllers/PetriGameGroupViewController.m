//
//  PetriGameGroupViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroupViewController.h"

#import "PetriModel.h"
#import "PetriGameGroup.h"

NSString* const PetriGameGroupViewNibName =	@"GameGroupView";

@implementation PetriGameGroupViewController

+ (void)initialize
{
	[self exposeBinding:@"gameGroup"];
}

- (id)initWithWindowController:(PetriMainWindowController*)windowController
{
	return [super initWithWindowController:windowController
								   nibName:PetriGameGroupViewNibName];
}

- (void)awakeFromNib
{
	// Bind the local gameGroup member to the model
	[self bind:@"gameGroup"
	  toObject:[self mainWindowController]
   withKeyPath:@"model.gameGroup"
	   options:nil];
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)returnToTitleView:(id)sender
{
	// FIXME: testing code; should check if the player is the host of a network game before closing
	// Return to the title view
	[[self mainWindowController] displayViewControllerForKey:PetriTitleViewControllerKey];
	
	// Leave/tear down the game group
	[[[self mainWindowController] model] leaveGameGroup];
}

- (IBAction)startGame:(id)sender
{
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriGameplayViewControllerKey];
	
	// Start a game
	[[self gameGroup] newGame];
}

#pragma mark -
#pragma mark Accessors

@synthesize gameGroup;

@end
