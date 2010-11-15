//
//  PetriGameGroupViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

@class PetriGameGroup;

/*!
 \brief The controller for the Game Group view.
 
 The PetriGameGroupViewController is responsible for handling events from the view that displays information about a game group, and allows the host to configure rules and begin games.
 */
@interface PetriGameGroupViewController : PetriMainWindowViewController
{
	PetriGameGroup* gameGroup;	/*!< A reference to the game group whose state is reflected on this view. */
}

/*!
 Leaves the game group and returns to the Title view.
 */
- (IBAction)returnToTitleView:(id)sender;

/*!
 Starts a game with the current players and rules from the current game group, and switches to the Gameplay view.
 */
- (IBAction)startGame:(id)sender;

@property (readwrite, assign) PetriGameGroup* gameGroup;

@end
