//
//  PetriPlayer+DisplayName.h
//  Petri
//
//  Created by Alex Heinz on 12/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer.h"

/*!
 \brief Adds a -displayName: method to the PetriPlayer subclasses, for use by the view.
 */
@interface PetriPlayer(DisplayName)

/*!
 Returns a string suitable for display as the player's name on the view.
 For PetriUserPlayers, this returns the controlling user's nickname; for PetriAIPlayers, this returns a constant placeholder string.
 */
- (NSString*)displayName;

@end
