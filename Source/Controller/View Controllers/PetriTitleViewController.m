//
//  PetriTitleViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriTitleViewController.h"

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
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

- (IBAction)createNetworkGameGroup:(id)sender
{
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

- (IBAction)joinNetworkGameGroup:(id)sender
{
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriJoinGameViewControllerKey];
}

@end
