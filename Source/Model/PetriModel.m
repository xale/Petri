//
//  PetriModel.m
//  Petri
//
//  Created by Alex Heinz on 11/17/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriModel.h"

#import "PetriGameGroup.h"
#import "PetriUser.h"

@implementation PetriModel

#pragma mark -
#pragma mark Creating Game Groups

- (void)createLocalGameGroup
{
	PetriUser* hostUser = [[PetriUser alloc] initWithNickname:NSUserName()];
	
	[self setGameGroup:[[PetriGameGroup alloc] initWithHost:hostUser]];
}

#pragma mark -
#pragma mark Accessors

@synthesize gameGroup;

@end
