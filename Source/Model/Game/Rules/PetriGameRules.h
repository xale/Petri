//
//  PetriGameRules.h
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief A container class for configurable game rules.
 
 A PetriGameRules object encapsulates all variables in the way Petri games are played, including the frequency at which different pieces appear, the type of board, etc.
 */
@interface PetriGameRules : NSObject
{
	NSInteger minPlayers;			/*!< The minimum number of players to participate in the game. If the game begins with fewer than this number of human users in the game group, AI players will be added to the game. */
	NSInteger maxPlayers;			/*!< The maximum number of players allowed in the game. If the game group contains this many players, new players will not be allowed to join. */
	NSDictionary* pieceFrequencies;	/*!< Stores probablilities used to choose a piece from the set of pieces at the beginning of each turn. Maps PetriPiece to NSNumber; i.e., piece to probability. */
}

@property (readwrite, assign) NSInteger minPlayers;
@property (readwrite, assign) NSInteger maxPlayers;
//FIXME: should this be readonly? it's immutable anyway.
@property (readwrite, copy) NSDictionary* pieceFrequencies;

@end
