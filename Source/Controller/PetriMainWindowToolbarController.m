//
//  PetriMainWindowToolbarController.m
//  Petri
//
//  Created by Alex Heinz on 11/7/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowToolbarController.h"
#import "PetriMainWindowController.h"

/*!
 Private methods on PetriMainWindowToolbarController.
 */
@interface PetriMainWindowToolbarController (Private)

/*!
 Displays the toolbar configuration associated with the view-controller specified by the given key.
 @param viewKey The key corresponding to the view controller current displayed on the main window.
 */
- (void)configureToolbarForViewKey:(NSString*)viewKey;

/*!
 Returns an array containing the item identifiers of the toolbar items appropriate for display on a given view.
 @param viewKey The key corresponding to the view controller current displayed on the main window.
 */
- (NSArray*)toolbarItemIdentifiersForViewKey:(NSString*)viewKey;

/*!
 \defgroup toolbarConfigs Toolbar Configurations
 @{
 */
//! Identifiers for toolbar items on the Title view
- (NSArray*)titleViewToolbarItemIdentifiers;
//! Identifiers for toolbar items on the Game Group view
- (NSArray*)gameGroupViewToolbarItemIdentifiers;
//! Identifiers for toolbar items on the Gameplay view
- (NSArray*)gameplayViewToolbarItemIdentifiers;
//! @}

@end

@implementation PetriMainWindowToolbarController

- (void)awakeFromNib
{
	// Register for view-change notifications from the main window controller
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(mainWindowViewChanged:)
												 name:PetriMainWindowDidDisplayViewControllerNotification
											   object:mainWindowController];
	
	// Display the toolbar for the title view
	[self configureToolbarForViewKey:PetriTitleViewControllerKey];
}

- (void)finalize
{
	// De-register for view-change notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark View-Change Notifications/Actions

- (void)mainWindowViewChanged:(NSNotification*)notification
{
	// Determine which view is being displayed
	NSString* viewKey = [[notification userInfo] objectForKey:PetriViewControllerKeyNotificationKey];
	
	// Change the toolbar configuration
	[self configureToolbarForViewKey:viewKey];
}


- (void)configureToolbarForViewKey:(NSString*)viewKey
{
	// Get the current configuration of the toolbar
	NSMutableDictionary* toolbarConfig = [NSMutableDictionary dictionaryWithDictionary:[toolbar configurationDictionary]];
	
	// Replace the visible items with the appropriate items for the current configuration
	[toolbarConfig setObject:[self toolbarItemIdentifiersForViewKey:viewKey]
					  forKey:@"TB Item Identifiers"];
	[toolbar setConfigurationFromDictionary:toolbarConfig];
}

#pragma mark -
#pragma mark Toolbar Configurations

NSString* const PetriNoToolbarForViewKeyExceptionName =	@"noToolbarForViewKeyException";
NSString* const PetriNoToolbarForViewKeyExceptionDescriptionFormat =	@"No toolbar configuration for view-controller key %@";

- (NSArray*)toolbarItemIdentifiersForViewKey:(NSString*)viewKey
{
	if ([viewKey isEqualToString:PetriTitleViewControllerKey])
		return [self titleViewToolbarItemIdentifiers];
	
	if ([viewKey isEqualToString:PetriGameGroupViewControllerKey])
		return [self gameGroupViewToolbarItemIdentifiers];
	
	if ([viewKey isEqualToString:PetriGameplayViewControllerKey])
		return [self gameplayViewToolbarItemIdentifiers];
	
	// No toolbar configuration for specified view: throw an exception
	NSString* exceptionDesc = [NSString stringWithFormat:PetriNoToolbarForViewKeyExceptionDescriptionFormat, viewKey];
	NSException* unknownKeyException = [NSException exceptionWithName:PetriNoToolbarForViewKeyExceptionName
															   reason:exceptionDesc
															 userInfo:nil];
	@throw unknownKeyException;
}

- (NSArray*)titleViewToolbarItemIdentifiers
{
	// FIXME: WRITEME
	return [NSArray array];
}

- (NSArray*)gameGroupViewToolbarItemIdentifiers
{
	// FIXME: WRITEME
	return [NSArray array];
}

- (NSArray*)gameplayViewToolbarItemIdentifiers
{
	// FIXME: WRITEME
	return [NSArray array];
}

@end
