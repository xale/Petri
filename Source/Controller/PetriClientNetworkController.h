//
//  PetriClientNetworkController.h
//  Petri
//
//  Created by Paul Martin on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PetriNetworkController.h"

#define PETRI_CLIENT_PORT 31995

/*!
 Interface for the client network controller, a distributed object that the server contains a pointer to for each object
 Each client has an interface for RPC
 */
@interface PetriClientNetworkController : PetriNetworkController
{
	NSDistantObject* serverNC; /*!< Server client is connceted to */
}

/*!
 Initialize the client and connect to a distributed object of the server RPC interface being hosted on the server
 The client then vends itself as a distributed object and tells the server to initiate a connection to it.
 @param serverIpAddr ip address of server to connect to
 */
- (id)initWithServerHost:(NSString*)serverIpAddr
				 GameGroup:(PetriGameGroup*)gameGroup;

/*!
 @deprecated
 This method is to be replaced with initGame
 */
- (void)createBoardFromSerialized:(NSData*)serializedBoard;

@end
