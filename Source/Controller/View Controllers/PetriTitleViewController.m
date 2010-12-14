//
//  PetriTitleViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriTitleViewController.h"

#import "PetriModel.h"

NSString* const PetriTitleViewNibName =	@"TitleView";

@implementation PetriTitleViewController

- (id)initWithWindowController:(PetriMainWindowController*)windowController
{
	return [super initWithWindowController:windowController
								   nibName:PetriTitleViewNibName];
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)createLocalGameGroup:(id)sender
{
	// Create a game group
	[[[self mainWindowController] model] createLocalGameGroup];
	
	// Switch to the game group view
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

- (IBAction)createNetworkGameGroup:(id)sender
{
	// Create a game group and host it as a server
	[[[self mainWindowController] model] createNetworkGameGroup];
	
	// Switch to the game group view
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

- (IBAction)joinNetworkGameGroup:(id)sender
{
	// Switch to the join view
	[[self mainWindowController] displayViewControllerForKey:PetriJoinGameViewControllerKey];
}

@end
