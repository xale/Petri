//
//  PetriBoardManager.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol PetriBoard;

/*!
 Singleton class for registering available boards.
 */
@interface PetriBoardManager : NSObject
{
	NSMutableSet* registeredBoardClasses;	/*!< A set of boards that have been registered with this class. */
}

/*!
 Factory method for the board method; either allocates a new one if one doesn't exist or returns a reference to the current one.
 */
+ (PetriBoardManager*)sharedManager;

/*!
 Add a board class to the set of playable board classes.
 
 @param cls the class to add
 */
- (void)registerBoardClass:(Class<PetriBoard>)cls;

/*!
 Accessor for an immutable copy of registeredBoardClasses.
 */
@property (readonly) NSSet* registeredBoardClasses;

@end
