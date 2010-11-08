//
//  PetriMainWindowToolbarController.m
//  Petri
//
//  Created by Alex Heinz on 11/7/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowToolbarController.h"
#import "PetriMainWindowController.h"

@implementation PetriMainWindowToolbarController

- (void)awakeFromNib
{
	// Register for view-change notifications from the main window controller
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(mainWindowViewChanged:)
												 name:PetriMainWindowDidDisplayViewControllerNotification
											   object:mainWindowController];
}

- (void)finalize
{
	// De-register for view-change notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark View-Change Notifications

- (void)mainWindowViewChanged:(NSNotification*)notification
{
	NSString* viewControllerKey = [[notification userInfo] objectForKey:PetriViewControllerKeyNotificationKey];
	
	// FIXME: adjust toolbar items/arrangement to reflect current view
}

@end
