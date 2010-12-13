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

@interface PetriClientNetworkController : PetriNetworkController
{
	NSDistantObject* serverNC;
}

- (void)initWithServerHost:(NSString*)serverIpAddr;

- (void)createBoardFromSerialized:(NSData*)serializedBoard;

@end
