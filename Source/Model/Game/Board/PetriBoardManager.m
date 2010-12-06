//
//  PetriBoardManager.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardManager.h"


@implementation PetriBoardManager

static PetriBoardManager *sharedPetriBoardManager = nil;

+ (PetriBoardManager*)sharedManager
{
    if (sharedPetriBoardManager == nil)
	{
        sharedPetriBoardManager = [[super allocWithZone:NULL] init];
    }
    return sharedPetriBoardManager;	
}

- (id)init
{
	registeredBoardClasses = [NSMutableSet set];
	return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];	
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

- (void)registerBoardClass:(Class<PetriBoard>)cls
{
	if ([registeredBoardClasses containsObject:cls])
	{
		NSException* exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Attempted to register an already registered board class." userInfo:nil];
		@throw exception;
	}
	[registeredBoardClasses addObject:cls];
}

- (NSSet*)registeredBoardClasses
{
	return [registeredBoardClasses copy];
}

@end
