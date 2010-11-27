//
//  PetriItem.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief A usuable item that can affect game state.
 
 PetriItem instances represent game items that can be collected by players, and then used by their owners to influence the game.
 */
@interface PetriItem : NSObject <NSCopying>
{
	
}

/*!
 Tests for the equality of two PetriItem objects.
 */
- (BOOL)isEqualToItem:(PetriItem*)item;

@end
