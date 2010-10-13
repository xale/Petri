//
//	PetriAppDelegate.h
//	Petri
//
//	Created by Alex Heinz on 10/4/10.
//	Copyright 2010 Alex Heinz, Paul Martin and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief The Application Delegate object for the Petri application.
 */
@interface PetriAppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet NSWindow *window;	/*!< The main application window. */
}

@property (readwrite, assign) IBOutlet NSWindow *window;

@end
