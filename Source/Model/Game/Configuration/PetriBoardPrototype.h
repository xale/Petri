//
//  PetriBoardPrototype.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/2/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol PetriBoard;

/*!
 Class used to select board before the game starts.
 */
@interface PetriBoardPrototype : NSObject
{
	Class<PetriBoard> boardClass;	/*!< Class of the board that this prototype represents. */
	NSDictionary* setupParameters;	/*!< map from names (NSString*) to PetriBoardParameters that are configurable on the board of the class above. */
}

/*!
 Initializer for BoardPrototype; sets the setupParameters to defaults for the class.
 @param cls the class of the board for which this is a prototype
 */
- (id)initWithClass:(Class<PetriBoard>)cls;

/*!
 Allocates and initializes a new prototype for the class requested.
 @param cls the class of the board for which this is a prototype
 */
+ (id)prototypeForBoardClass:(Class<PetriBoard>)cls;

@property (readwrite, assign) Class<PetriBoard> boardClass;
@property (readonly) NSDictionary* setupParameters;
@property (readonly) NSArray* valuesOfSetupParameters;	/*!< An readonly call-through to [setupParameters allValues], used for bindings. */

@end
