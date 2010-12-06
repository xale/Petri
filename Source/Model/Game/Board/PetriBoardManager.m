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

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];	
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

@end
