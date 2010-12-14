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
	NSString* nickname;		/*!< The user's name or nickname, visible to other users during a network game. */
	NSColor* playerColor;	/*!< The color that will be used for the player's color in a game. */
}

/*!
 Creates a new PetriUser object with the specified nickname and color.
 @param userNickname The user's nickname, chosen (presumably) by the human being at the keyboard.
 @param color The color of the user's player.
 */
- (id)initWithNickname:(NSString*)userNickname
		   playerColor:(NSColor*)color;

@property (readwrite, copy) NSString* nickname;
@property (readwrite, copy) NSColor* playerColor;

@end
