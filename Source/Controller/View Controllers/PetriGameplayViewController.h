//
//  PetriGameplayViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

/*!
 \brief The controller for the Gameplay view.
 
 The PetriGameplayViewController is responsible for handling events from the view that displays displays and interacts with a game in progress.
 */
@interface PetriGameplayViewController : PetriMainWindowViewController
{
	
}

/*!
 Ends the game and returns to the Game Group view.
 */
- (IBAction)endGame:(id)sender;

/*!
 Leaves the game and returns to the Title view.
 */
- (IBAction)returnToTitleView:(id)sender;

@end
