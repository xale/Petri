//
//  PetriServerNetworkController.h
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PetriNetworkController.h"

#define PETRI_SERVER_PORT 31994

/*!
 Distributed Object that is the server RPC interface for Petri games
 Each client will get this interface and will be able to register itself with the server
 */
@interface PetriServerNetworkController : PetriNetworkController
{
	NSMutableSet* clientNCs; /*!< list of clients that are registered with this server */
}

/*!
 Method creates an distributed object that clients can connect to
 */
- (void)init;

/*!
 Register a client with this server by an IP address string
 This will attempt to connect to the client hosted distributed object which provides a RPC interface
 
 @param clientIpAddr client IP address to register as a string
 */
- (void)addClientByIpAddr:(NSString*)clientIpAddr;


/*!
 Search for a client object to remove from the set of listening clients
 @param clientNC client network controller to remove from the set of client networks controllers
 */
- (void)removeClient:(NSDistantObject*)clientNC;

@end
