//
//  PetriBoardPrototype.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/2/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardPrototype.h"

@implementation PetriBoardPrototype

- (void) setBoardClass:(Class<PetriBoard>)newClass
{
	boardClass = newClass;
	setupParameters = [newClass setupParameters];
}

@synthesize boardClass

@end
