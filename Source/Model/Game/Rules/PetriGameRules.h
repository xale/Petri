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
	NSDictionary* pieceFrequencies;	/*!< Stores probablilities used to choose a piece from the set of pieces at the beginning of each turn. Maps PetriPiece to NSNumber; i.e., piece to probability. */
}

@end
