//
//  PetriServerNetworkController.m
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriServerNetworkController.h"

#import "PetriGameGroup.h"

@implementation PetriServerNetworkController

- (id)initWithGameGroup:(PetriGameGroup*)GameGroup
{
	//Set gameGroup
	gameGroup = GameGroup;
	
	NSSocketPort *port = [[NSSocketPort alloc] initWithTCPPort:PETRI_SERVER_PORT];
	
	NSConnection *connection;
	
	connection = [NSConnection connectionWithReceivePort:port sendPort:port];
	[connection setRootObject:self];
	if ([connection registerName:@"PetriServerListenConnection"] == NO)
	{
		/* Handle error. */
	}
	
	[[NSRunLoop currentRunLoop] run];
	
	return self;
}

- (void)addClientByIpAddr:(NSString*)clientIpAddr
{
	//Instantiate a distributed server object
	id PetriClientNetworkControllerProxy;
	PetriClientNetworkControllerProxy = [[NSConnection
										  rootProxyForConnectionWithRegisteredName:@"PetriClientListenConnection"
										  host:clientIpAddr] retain];
	
	//Now set pointer to PetriServerNetworkControllerProxy
	[clientNCs addObject:PetriClientNetworkControllerProxy];
}

- (void)removeClient:(NSDistantObject*)client
{
	for (NSDistantObject* current in clientNCs)
	{
		if (current == client)
		{
			[clientNCs removeObject:current];
		}
	}
}

@end
