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

#import "PetriServerNetworkController.h"
#import "PetriClientNetworkController.h"

@implementation PetriModel

#pragma mark -
#pragma mark Creating Game Groups

- (void)createLocalGameGroup
{
	// Create a game group with the local user as the host
	PetriUser* hostUser = [[PetriUser alloc] initWithNickname:NSFullUserName()
												  playerColor:[NSColor redColor]];
	[self setGameGroup:[[PetriGameGroup alloc] initWithHost:hostUser]];
}

- (void)createNetworkGameGroup
{
	// Create a game group with the local user as the host
	PetriUser* hostUser = [[PetriUser alloc] initWithNickname:NSFullUserName()
												  playerColor:[NSColor redColor]];
	[self setGameGroup:[[PetriGameGroup alloc] initWithHost:hostUser]];
	
	// Create a network controller
	networkController = [[PetriServerNetworkController alloc] initWithGameGroup:[self gameGroup]];
}

- (void)joinGameGroupWithHost:(NSString*)hostnameOrIP
{
	// Create a client network controller and attempt to connect
	networkController = [[PetriClientNetworkController alloc] initWithServerHost:hostnameOrIP];
}

- (void)leaveGameGroup
{
	// Remove the game group, and network controller, if one exists
	[self setGameGroup:nil];
	networkController = nil;
}

#pragma mark -
#pragma mark Accessors

@synthesize gameGroup;

@end
