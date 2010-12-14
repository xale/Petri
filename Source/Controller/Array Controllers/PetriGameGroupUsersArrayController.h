//
//  PetriGameGroupUsersArrayController.h
//  Petri
//
//  Created by Alex Heinz on 12/14/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriGameGroup;

@interface PetriGameGroupUsersArrayController : NSArrayController
{
	PetriGameGroup* gameGroup;
}

@property (readwrite, assign) PetriGameGroup* gameGroup;

@end
