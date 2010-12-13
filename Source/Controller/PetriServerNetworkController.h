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

@interface PetriServerNetworkController : PetriNetworkController
{
	NSMutableSet* clientNCs;
}

- (void)init;

- (void)addClientByIpAddr:(NSString*)clientIpAddr;

- (void)removeClient:(NSDistantObject*)clientNC;

@end
