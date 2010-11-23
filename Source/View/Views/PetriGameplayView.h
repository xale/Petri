//
//  PetriGameplayView.h
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"

@class PetriGame;

/*!
 \brief An NSView subclass that draws the Gameplay view.
 
 The PetriGameplayView is a CoreAnimation layer-hosting view that contains and draws the game board, status information about the players in the game, and the current piece for the turn; it also handles the input events for interation with these elements, and makes callbacks to a delegate when such an event attempts to modify the model state.
 */
@interface PetriGameplayView : PetriNoLayerResizeAnimationView
{
	PetriGame* game;	/*!< The model Game object for which this view draws a representation. */
}

@property (readwrite, assign) PetriGame* game;

@end
