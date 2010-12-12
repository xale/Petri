//
//  PetriGameplayViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

#import "PetriGameplayView.h"	// Imported here for delegate protocol definition

@class PetriGame;

/*!
 \brief The controller for the Gameplay view.
 
 The PetriGameplayViewController is responsible for handling events from the view that displays displays and interacts with a game in progress.
 */
@interface PetriGameplayViewController : PetriMainWindowViewController <PetriGameplayViewDelegate>
{
	IBOutlet PetriGameplayView* gameplayView;	/*!< The main view displaying the board, pieces, players, etc. */
	
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

/*!
 Skips the current player's turn.
 */
- (IBAction)skipTurn:(id)sender;

@property (readwrite, assign) PetriGame* game;

@end
