//
//  PetriBoardPrototypeView.h
//  Petri
//
//  Created by Alex Heinz on 12/7/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriNoLayerResizeAnimationView.h"

@protocol PetriBoard;

typedef enum
{
	upToDate,
	boardClassChanged,
	boardParametersChanged
} PrototypeViewUpdateState;

/*!
 \brief An NSView subclass that displays a preview of the game board.
 
 The PetriBoardPrototypeView is intended to display a preview of the game board before the game starts, based upon a PetriBoard class and a set of PetriBoardParameter objects in a dictionary, which define the board's appearance; both of these things are conventionally found in a PetriBoardPrototype object, to whose properties this view is intended to be bound.
 */
@interface PetriBoardPrototypeView : PetriNoLayerResizeAnimationView
{
	IBOutlet NSObjectController* boardPrototypeController;	/*!< An NSObjectController whose content object is the PetriBoardPrototype that defines view's appearance; this outlet is connected here, rather than in the GameGroupViewController, which would be a much more logical place, due to a bizarre interface glitch that appears to occur when the view controller is given an IBOutlet connected to this view (or, apparently, any NSView class other than the top-level view.) */
	
	Class<PetriBoard> boardClass;	/*!< The class of PetriBoard currently being previewed. */
	NSDictionary* boardParameters;	/*!< The parameters defining the currently-previewed board. */
	
	PrototypeViewUpdateState updateState;	/*!< An internal state-machine enum used to keep the board class and parameters synchronized across KVC updates. */
}

@property (readwrite, assign) Class<PetriBoard> boardClass;
@property (readwrite, assign) NSDictionary* boardParameters;

@end
