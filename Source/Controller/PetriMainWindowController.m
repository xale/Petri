//
//	PetriMainWindowController.m
//	Petri
//
//	Created by Alex Heinz on 10/4/10.
//	Copyright 2010 Alex Heinz, Paul Martin and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowController.h"
#import "PetriTitleViewController.h"
#import "PetriGameGroupViewController.h"
#import "PetriGameplayViewController.h"

NSString* const PetriTitleViewControllerKey	=		@"PetriTitleViewController";
NSString* const PetriGameGroupViewControllerKey =	@"PetriGameGroupViewController";
NSString* const PetriGameplayViewControllerKey =	@"PetriGameplayViewController";

@implementation PetriMainWindowController

- (id)init
{
	// Create view controllers
	viewControllers = [NSDictionary dictionaryWithObjectsAndKeys:
					   [[PetriTitleViewController alloc] init], PetriTitleViewControllerKey,
					   [[PetriGameGroupViewController alloc] init], PetriGameGroupViewControllerKey,
					   [[PetriGameplayViewController alloc] init], PetriGameplayViewControllerKey,
					   nil];
	
	return self;
}

- (void)awakeFromNib
{
	// Display the title view controller
	[self displayViewControllerForKey:PetriTitleViewControllerKey];
}

#pragma mark -
#pragma mark View Swapping

- (void)displayViewController:(NSViewController*)newViewController
{
	// Attempt to move first-responder status to the window
	if (![[self window] makeFirstResponder:[self window]])
	{
		NSBeep();
		return;
	}
	
	// Get the new view to be displayed from its controller
	NSView* newView = [newViewController view];
	
	// Compute the change in window size to accomodate the new view
	NSSize currentSize = [[viewBox contentView] frame].size;
	NSSize newSize = [newView frame].size;
	CGFloat deltaWidth = newSize.width - currentSize.width;
	CGFloat deltaHeight = newSize.height - currentSize.height;
	NSRect windowFrame = [[self window] frame];
	windowFrame.size.width += deltaWidth;
	windowFrame.size.height += deltaHeight;
	windowFrame.origin.y -= deltaHeight;
	
	// Clear the view box so the window can be resized
	[viewBox setContentView:nil];
	
	// Resize the window
	[[self window] setFrame:windowFrame
					display:YES
					animate:YES];
	
	// Swap the view into the box
	[viewBox setContentView:newView];
	
	// Move first-responder status to the new view
	[[self window] makeFirstResponder:newView];
	
	// Change the current view controller
	[self setCurrentViewController:newViewController];
}

- (void)displayViewControllerForKey:(NSString*)viewControllerKey
{
	[self displayViewController:[viewControllers objectForKey:viewControllerKey]];
}

#pragma mark -
#pragma mark NSApplicationDelegate Methods

- (void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
	// Insert code here to initialize your application 
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender
{
	return YES;
}

#pragma mark -
#pragma mark Accessors

@synthesize window;
@synthesize currentViewController;

@end
