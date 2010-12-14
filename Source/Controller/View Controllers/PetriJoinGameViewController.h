//
//  PetriJoinGameViewController.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMainWindowViewController.h"

/*!
 \brief The controller for the Join Game view.
 
 The PetriJoinGameViewController is responsible for the join game view, which allow the user to search for and join game groups on remote, networked machines.
 */
@interface PetriJoinGameViewController : PetriMainWindowViewController
{
	IBOutlet NSTextField* hostnameField;
}

/*!
 Cancels joining a game, and returns to the Title view.
 */
- (IBAction)returnToTitleView:(id)sender;

/*!
 Attempts to join a game group, switching to the game group view if successful.
 */
- (IBAction)joinGameGroup:(id)sender;

@end
