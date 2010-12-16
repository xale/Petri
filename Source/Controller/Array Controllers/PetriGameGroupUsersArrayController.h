//
//  PetriGameGroupUsersArrayController.h
//  Petri
//
//  Created by Alex Heinz on 12/14/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriGameGroup;

/*!
 \brief An NSArrayController subclass for managing the list of users on the Game Group view.
 */
@interface PetriGameGroupUsersArrayController : NSArrayController
{
	PetriGameGroup* gameGroup;	/*!< A reference to the game group to which the users in the managed array belong. */
}

@property (readwrite, assign) PetriGameGroup* gameGroup;

@end
