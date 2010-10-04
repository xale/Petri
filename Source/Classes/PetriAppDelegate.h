//
//	PetriAppDelegate.h
//	Petri
//
//	Created by Alex Heinz on 10/4/10.
//	Copyright 2010 Alex Heinz, Paul Martin and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PetriAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
