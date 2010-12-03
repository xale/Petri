//
//  PetriBoardPrototype.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/2/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PetriBoard;

/*!
 Class used to select board before the game starts.
 */
@interface PetriBoardPrototype : NSObject
{
	Class<PetriBoard> boardClass;	/*!< Class of the board that this prototype represents. */
	NSSet* setupParameters;	/*!< Set of PetriBoardParameters that are configurable on the board of the class above. */
}

@property (readwrite, assign) Class<PetriBoard> boardClass;

@end
