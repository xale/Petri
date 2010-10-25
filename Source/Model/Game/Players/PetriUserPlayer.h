//
//  PetriUserPlayer.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer.h"

@class PetriUser;

/*!
 \brief a PetriPlayer subclass representing a player controlled by a human user.
 
 The PetriUserPlayer represents a Petri game player controlled by a human user, as opposed to a computer AI. It holds a reference to the associated user's PetriUser instance.
 */
@interface PetriUserPlayer : PetriPlayer
{
	PetriUser* controllingUser;	/*!< The human user controlling this player. */
}

@property (readonly) PetriUser* controllingUser;

@end
