//
//  PetriGameGroupViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroupViewController.h"

NSString* const PetriGameGroupViewNibName =	@"GameGroupView";

@implementation PetriGameGroupViewController

- (id)init
{
	return [super initWithNibName:PetriGameGroupViewNibName
						   bundle:nil];
}

#pragma mark -
#pragma mark Interface Actions

- (IBAction)returnToTitleView:(id)sender
{
	// FIXME: testing code; should check if the player is the host of a network game before closing
	[[self mainWindowController] displayViewControllerForKey:PetriTitleViewControllerKey];
}

- (IBAction)startGame:(id)sender
{
	// FIXME: testing code
	[[self mainWindowController] displayViewControllerForKey:PetriGameplayViewControllerKey];
}

@end