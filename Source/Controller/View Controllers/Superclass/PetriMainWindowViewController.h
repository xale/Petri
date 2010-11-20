//
//  PetriMainWindowViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PetriMainWindowController.h"

/*!
 \brief An abstract superclass for view controllers displayed on the main window.
 
 The PetriMainWindowViewController class is an abstract subclass of NSViewController for use on the main window of the application.
 */
@interface PetriMainWindowViewController : NSViewController
{
	PetriMainWindowController* mainWindowController;	/*!< A reference to the main window controller. */
}

/*!
 Creates a new view controller which reports to the specified window controller.'
 
 Abstract method. Default initializer for subclasses.
 
 @param windowController The top-level main-window controller managing this view/controller pair.
 */
- (id)initWithWindowController:(PetriMainWindowController*)windowController;

/*!
 Creates a new view controller managing the view loaded from the specified nib, and managed by the specified window controller.
 
 \warning Do not invoke directly; instatiate a subclass instead.
 
 @param windowController The top-level main-window controller managing this view/controller pair.
 @param nibName The name of the nib file from which to load this controller's view.
 */
- (id)initWithWindowController:(PetriMainWindowController*)windowController
					   nibName:(NSString*)nibName;

@property (readwrite, assign) PetriMainWindowController* mainWindowController;

@end
