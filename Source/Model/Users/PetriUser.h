//
//  PetriUser.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief Represents a local or remote human user participating in a game group.
 
 PetriUser instances represent a human user of the Petri application, and, in particular, encapsulate and present information to other users during network games.
 */
@interface PetriUser : NSObject
{
	NSString* nickname;	/*!< The user's name or nickname, visible to other users during a network game. */
}

/*!
 Creates a new PetriUser object with the specified nickname.
 @param userNickname the user's nickname, chosen (presumably) by the human being at the keyboard.
 */
- (id)initWithNickname:(NSString*)userNickname;

@property (readwrite, copy) NSString* nickname;

@end
