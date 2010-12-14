//
//  PetriModel.h
//  Petri
//
//  Created by Alex Heinz on 11/17/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PetriGameGroup;
@class PetriNetworkController;

/*!
 \brief Top-level model-encapsulation class.
 
 The PetriModel class is a KVC-compliant wrapper for the top-level model objects in the Petri application. It is intended to be created and maintained by the primary controller object, and its properties bound to and modified by other, lower-level controllers.
 */
@interface PetriModel : NSObject
{
	PetriGameGroup* gameGroup;	/*!< The current game group at the top level of the model. May be nil. */
	
	PetriNetworkController* networkController;	/*!< The current client or server network controller. May be nil. */
}

/*!
 Instructs the model to generate a new Game Group, intended for play on the local machine.
 */
- (void)createLocalGameGroup;

/*!
 Instructs the model to generate a new Game Group, intended for play over a network, and a network controller to advertise the group.
 */
- (void)createNetworkGameGroup;

/*!
 Attempts to join a game group at the specified hostname or IP address.
 */
- (void)joinGameGroupWithHost:(NSString*)hostnameOrIP;

/*!
 Tears down the game group, and the network controller, if one exists.
 */
- (void)leaveGameGroup;

@property (readwrite, assign) PetriGameGroup* gameGroup;

@end
