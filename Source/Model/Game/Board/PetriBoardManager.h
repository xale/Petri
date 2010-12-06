//
//  PetriBoardManager.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 Singleton class for registering available boards.
 */
@interface PetriBoardManager : NSObject
{

}

/*!
 Factory method for the board method; either allocates a new one if one doesn't exist or returns a reference to the current one.
 */
+ (PetriBoardManager*)sharedManager;

@end
