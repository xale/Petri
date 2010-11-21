//
//  PetriGameplayViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

@class PetriGame;

/*!
 \brief The controller for the Gameplay view.
 
 The PetriGameplayViewController is responsible for handling events from the view that displays displays and interacts with a game in progress.
 */
@interface PetriGameplayViewController : PetriMainWindowViewController
{
	IBOutlet NSSplitView* panesSplitView;	/*!< The split view containing the gameplay and chat panes. */
	IBOutlet NSView* gameplayPane;	/*!< The layer-hosting view containing the board, next piece, and player information layers. */
	IBOutlet NSView* chatPane;		/*!< The (standard) view containing the chat box. */
	
	PetriGame* game;	/*!< A reference to the current game in progress, which is displayed on this view. */
}

/*!
 Ends the game and returns to the Game Group view.
 */
- (IBAction)endGame:(id)sender;

/*!
 Leaves the game and returns to the Title view.
 */
- (IBAction)returnToTitleView:(id)sender;

@property (readwrite, assign) PetriGame* game;

@end
