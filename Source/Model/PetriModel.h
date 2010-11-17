//
//  PetriModel.h
//  Petri
//
//  Created by Alex Heinz on 11/17/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriGameGroup;

/*!
 \brief Top-level model-encapsulation class.
 
 The PetriModel class is a KVC-compliant wrapper for the top-level model objects in the Petri application. It is intended to be created and maintained by the primary controller object, and its properties bound to and modified by other, lower-level controllers.
 */
@interface PetriModel : NSObject
{
	PetriGameGroup* gameGroup;	/*!< The current game group at the top level of the model. May be nil. */
}

@property (readwrite, assign) PetriGameGroup* gameGroup;

@end
