//
//  PetriJoinGameViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriJoinGameViewController.h"

NSString* const PetriJoinGameViewNibName =	@"JoinGameView";

@implementation PetriJoinGameViewController

- (id)initWithWindowController:(PetriMainWindowController*)windowController
{
	return [super initWithWindowController:windowController
								   nibName:PetriJoinGameViewNibName];
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)returnToTitleView:(id)sender
{
	// Return to the title view
	[[self mainWindowController] displayViewControllerForKey:PetriTitleViewControllerKey];
}

- (IBAction)joinGameGroup:(id)sender
{
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriGameGroupViewControllerKey];
}

@end
