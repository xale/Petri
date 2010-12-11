//
//	PetriMainWindowController.h
//	Petri
//
//	Created by Alex Heinz on 10/4/10.
//	Copyright 2010 Alex Heinz, Paul Martin and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriModel;

@class PetriMainWindowViewController;

/*!
 \defgroup viewKeyConstants View Key Constants
 @{
 */
//! The Title view, displayed when the app starts.
extern NSString* const PetriTitleViewControllerKey;
//! The Join Game (Group) view, displayed when searching for or specifying a remote network game group.
extern NSString* const PetriJoinGameViewControllerKey;
//! The Game Group view, displayed when configuring players and options before a game.
extern NSString* const PetriGameGroupViewControllerKey;
//! The Gameplay view, displayed when a game is in progress.
extern NSString* const PetriGameplayViewControllerKey;
//! @}

/*!
 \addtogroup notifications Notifications
 @{
 */
/*!
 Posted when the PetriMainWindowController swaps a new view controller into the main window.
 */
extern NSString* const PetriMainWindowDidDisplayViewControllerNotification;
//! @}

/*!
 \addtogroup notificationKeys Notification User Info Keys
 @{
 */
/*!
 See \ref PetriMainWindowDidDisplayViewControllerNotification.
 
 The view-controller key corresponding to the view controller now displayed on the main window.
 */
extern NSString* const PetriViewControllerKeyNotificationKey;
//! @}

/*!
 \brief The controller for the main window of the Petri application.
 
 The PetriMainWindow controller class serves as the management object for the main Petri application window, controlling the swapping of views on the window, as well as performing the functions of an NSApplication delegate object.
 */
@interface PetriMainWindowController : NSObject <NSApplicationDelegate>
{
	IBOutlet NSWindow* window;	/*!< The main application window. */
	IBOutlet NSBox* viewBox;	/*!< The box containing swapped views on the window. */
	
	NSDictionary* viewControllers;				/*!< The collection of views that can be displayed on the main window. */
	PetriMainWindowViewController* currentViewController;	/*!< The view currently displayed on the main window. */
	
	PetriModel* model;	/*!< The backing model for the application. */
}

/*!
 \brief Changes the view displayed on the main window.
 
 @param viewControllerKey the key corresponding to the view to display; see \ref viewKeyConstants.
 */
- (void)displayViewControllerForKey:(NSString*)viewControllerKey;

@property (readwrite, assign) IBOutlet NSWindow* window;
@property (readwrite, assign) PetriMainWindowViewController* currentViewController;

@property (readonly) PetriModel* model;

@end
