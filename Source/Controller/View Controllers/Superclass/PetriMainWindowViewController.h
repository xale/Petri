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

@property (readwrite, assign) PetriMainWindowController* mainWindowController;

@end
