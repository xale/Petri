//
//  PetriMainWindowViewController.m
//  Petri
//
//  Created by Alex Heinz on 11/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

@implementation PetriMainWindowViewController

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithNibName:(NSString*)nibNameOrNil
			   bundle:(NSBundle*)nibBundleOrNil
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithWindowController:(PetriMainWindowController*)windowController
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithWindowController:(PetriMainWindowController*)windowController
					   nibName:(NSString*)nibName
{
	// Check that we're not attempting to instantiate an abstract class
	if ([self isMemberOfClass:[PetriMainWindowViewController class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	if (![super initWithNibName:nibName bundle:nil])
		return nil;
	
	mainWindowController = windowController;
	
	return self;
}

#pragma mark -
#pragma mark Display Notifications

- (void)willDisplayInWindow
{
	// Does nothing; subclasses may override
}

- (void)didDisplayInWindow
{
	// Does nothing; subclasses may override
}

#pragma mark -
#pragma mark Interface Validation

- (BOOL)validateUserInterfaceItem:(id<NSValidatedUserInterfaceItem>)item
{
	return [self respondsToSelector:[item action]];
}

#pragma mark -
#pragma mark Accessors

@synthesize mainWindowController;

@end
