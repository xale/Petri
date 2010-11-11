//
//  PetriMainWindowToolbarController.h
//  Petri
//
//  Created by Alex Heinz on 11/7/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriMainWindowController;

/*!
 \brief Controller responsible for the toolbar on the main window.
 
 The PetriMainWindowToolbarController is responsible for the items on the toolbar of the main window, particularly, for receiving the events they send, and forwarding them to the main window controller, and for swapping them in and out when the view being displayed changes.
 */
@interface PetriMainWindowToolbarController : NSObject
{
	IBOutlet PetriMainWindowController* mainWindowController;	/*!< A reference to the main window controller. */
	IBOutlet NSToolbar* toolbar;	/*!< The toolbar on the main window, for which this controller is responsible. */
	
	NSDictionary* toolbarConfigurations;	/*!< The toolbar configurations for each of the views. Maps NSString to NSArray; i.e., view-controller key to list of toolbar-item identifiers. */ 
}

@end
