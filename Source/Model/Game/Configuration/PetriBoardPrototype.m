//
//  PetriBoardPrototype.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/2/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardPrototype.h"
#import "PetriBoard.h"

@implementation PetriBoardPrototype


- (id)initWithClass:(Class<PetriBoard>)cls
{
	boardClass = cls;
	setupParameters = [cls setupParameters];
	return self;
}

+ (id)prototypeForBoardClass:(Class<PetriBoard>)cls
{
	return [[PetriBoardPrototype alloc] initWithClass:cls];
}

- (void)setBoardClass:(Class<PetriBoard>)newClass
{
	boardClass = newClass;
	setupParameters = [newClass setupParameters];
}

+ (NSSet*)keyPathsForValuesAffectingSetupParameters
{
	return [NSSet setWithObject:@"boardClass"];
}

@synthesize boardClass;
@synthesize setupParameters;

@end
