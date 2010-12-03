//
//  PetriBoardPrototype.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/2/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PetriBoard;

@interface PetriBoardPrototype : NSObject
{
	Class<PetriBoard> boardClass;
	NSDictionary* setupParameters;
}

@property (readwrite, assign) Class<PetriBoard> boardClass;

@end
