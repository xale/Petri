//
//  PetriBoardPrototypeView.m
//  Petri
//
//  Created by Alex Heinz on 12/7/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardPrototypeView.h"

#import "PetriBoard.h"
#import "PetriBoardParameter.h"

#import "PetriBoardLayer.h"

#import "CALayer+ConstraintSets.h"

/*!
 Private methods on PetriBoardPrototypeView.
 */
@interface PetriBoardPrototypeView(Private)

/*!
 Regenerates the PetriBoardLayer this view uses as the preview of the board; called when the board class changes, or one of its parameters is adjusted.
 */
- (void)updateBoardLayer;

/*!
 Instructs the view to begin tracking changes made to the values of a collection of PetriBoardParameter objects, using key-value observing, and to update the board preview when an adjustment is made. This method is called when the class of board being previewed is changed, since the new class is associated with a different set of parameters.
 */
- (void)startObservingBoardParameters:(NSArray*)parameters;

/*!
 Instructs the view to stop tracking changes to the given collection of PetriBoardParameter objects; see -startObservingBoardParameters:.
 */
- (void)stopObservingBoardParameters:(NSArray*)parameters;

@end

@implementation PetriBoardPrototypeView

+ (void)initialize
{
	[self exposeBinding:@"boardClass"];
	[self exposeBinding:@"boardParameters"];
}

- (id)initWithFrame:(NSRect)frameRect
{
	if (![super initWithFrame:frameRect])
		return nil;
	
	updateState = upToDate;
	
	return self;
}

- (void)awakeFromNib
{
	// Create a background layer for the view
	CALayer* backgroundLayer = [CALayer layer];
	
	// Add a layout manager
	[backgroundLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Set up the view to be layer-hosting (see discussion under documentation of NSView -setWantsLayer:)
	[self setLayer:backgroundLayer];
	[self setWantsLayer:YES];
	
	// Bind the view properties to the controller
	[self bind:@"boardClass"
	  toObject:boardPrototypeController
   withKeyPath:@"selection.boardClass"
	   options:nil];
	[self bind:@"boardParameters"
	  toObject:boardPrototypeController
   withKeyPath:@"selection.setupParameters"
	   options:nil];
}

#pragma mark -
#pragma mark Layout/Display

- (void)updateBoardLayer
{
	[[self layer] setSublayers:nil];
	
	// If either the board class or parameters are nil, do not generate a new board preview
	if ((boardClass == Nil) || (boardParameters == nil))
		return;
	
	// Create a new board layer, using the current class and parameters
	id<PetriBoard> board = [[self boardClass] boardWithParameters:[self boardParameters]];
	
	// Create a layer from the board
	CALayer* boardLayer = [PetriBoardLayer boardLayerForBoard:board];
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	
	// Replace the existing board preview
	[[self layer] addSublayer:boardLayer];
}

#pragma mark -
#pragma mark Key/Value Observing

- (void)startObservingBoardParameters:(NSArray*)parameters
{
	for (PetriBoardParameter* param in parameters)
	{
		[param addObserver:self
				forKeyPath:@"parameterValue"
				   options:0
				   context:NULL];
	}
}

- (void)stopObservingBoardParameters:(NSArray*)parameters
{
	for (PetriBoardParameter* param in parameters)
	{
		[param removeObserver:self
				   forKeyPath:@"parameterValue"];
	}
}

- (void)observeValueForKeyPath:(NSString*)keyPath
					  ofObject:(id)object
						change:(NSDictionary*)change
					   context:(void*)context
{
	// When a parameter of the board's configuration changes, update the board's appearance
	[self updateBoardLayer];
}

#pragma mark -
#pragma mark Accessors

- (void)setBoardClass:(Class<PetriBoard>)newBoardClass
{
	// Hold a reference to the board class
	boardClass = newBoardClass;
	
	if (updateState == upToDate)
	{
		updateState = boardClassChanged;	
	}
	else if (updateState == boardParametersChanged)
	{
		updateState = upToDate;
		[self updateBoardLayer];
	}
}
@synthesize boardClass;

- (void)setBoardParameters:(NSDictionary*)newBoardParameters
{
	// Stop observing the old parameter values
	[self stopObservingBoardParameters:[boardParameters allValues]];
	
	// Begin observing the new parameter values
	[self startObservingBoardParameters:[newBoardParameters allValues]];
	
	// Hold a reference to the board parameters
	boardParameters = newBoardParameters;
	
	if (updateState == upToDate)
	{
		updateState = boardParametersChanged;
	}
	else if (updateState == boardClassChanged)
	{
		updateState = upToDate;
		[self updateBoardLayer];
	}
}
@synthesize boardParameters;

@end
