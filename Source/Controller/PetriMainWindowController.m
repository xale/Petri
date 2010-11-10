//
//	PetriMainWindowController.m
//	Petri
//
//	Created by Alex Heinz on 10/4/10.
//	Copyright 2010 Alex Heinz, Paul Martin and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowController.h"

#import "PetriMainWindowViewController.h"
#import "PetriTitleViewController.h"
#import "PetriJoinGameViewController.h"
#import "PetriGameGroupViewController.h"
#import "PetriGameplayViewController.h"

NSString* const PetriTitleViewControllerKey	=		@"PetriTitleViewController";
NSString* const PetriJoinGameViewControllerKey =	@"PetriJoinGameViewController";
NSString* const PetriGameGroupViewControllerKey =	@"PetriGameGroupViewController";
NSString* const PetriGameplayViewControllerKey =	@"PetriGameplayViewController";

NSString* const PetriMainWindowDidDisplayViewControllerNotification =	@"PetriMainWindowDidDisplayViewControllerNotification";
NSString* const PetriViewControllerKeyNotificationKey =					@"PetriViewControllerKey";

@implementation PetriMainWindowController

- (id)init
{
	// Create view controllers
	viewControllers = [NSDictionary dictionaryWithObjectsAndKeys:
					   [[PetriTitleViewController alloc] init], PetriTitleViewControllerKey,
					   [[PetriJoinGameViewController alloc] init], PetriJoinGameViewControllerKey,
					   [[PetriGameGroupViewController alloc] init], PetriGameGroupViewControllerKey,
					   [[PetriGameplayViewController alloc] init], PetriGameplayViewControllerKey,
					   nil];
	
	// Connect view controllers to the window controller
	for (PetriMainWindowViewController* viewController in [viewControllers objectEnumerator])
		[viewController setMainWindowController:self];
	
	return self;
}

- (void)awakeFromNib
{
	// Display the title view controller
	[self displayViewControllerForKey:PetriTitleViewControllerKey];
}

#pragma mark -
#pragma mark View Swapping

NSString* const PetriInvalidViewControllerKeyExceptionName =	@"invalidViewControllerKeyException";
NSString* const PetriInvalidViewControllerKeyExceptionDescriptionFormat =	@"No view controller found for key %@";

- (void)displayViewControllerForKey:(NSString*)viewControllerKey
{
	// Find the view controller for the specified key
	NSViewController* newViewController = [viewControllers objectForKey:viewControllerKey];
	
	// Check that the controller exists
	if (newViewController == nil)
	{
		// No controller for specified key: throw an exception
		NSString* exceptionDesc = [NSString stringWithFormat:PetriInvalidViewControllerKeyExceptionDescriptionFormat, viewControllerKey];
		NSException* invalidKeyException = [NSException exceptionWithName:PetriInvalidViewControllerKeyExceptionName
																   reason:exceptionDesc
																 userInfo:nil];
		@throw invalidKeyException;
	}
	
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
	
	// Post a notification
	[[NSNotificationCenter defaultCenter] postNotificationName:PetriMainWindowDidDisplayViewControllerNotification
														object:self
													  userInfo:[NSDictionary dictionaryWithObject:viewControllerKey
																						   forKey:PetriViewControllerKeyNotificationKey]];
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
