//
//  PetriPieceContainerLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/1/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceContainerLayer.h"

#import "PetriPiece.h"
#import "PetriPieceLayer.h"

#import "CALayer+ConstraintSets.h"

/*!
 Private methods on PetriPieceContainerLayer.
 */
@interface PetriPieceContainerLayer(Private)

/*!
 Creates a PetriPieceLayer to display the specified piece, and laid out for display in the container layer.
 @param newPiece The new piece to display in this container.
 */
- (PetriPieceLayer*)pieceLayerForPiece:(id<PetriPiece>)newPiece;

@end


@implementation PetriPieceContainerLayer

+ (void)initialize
{
	[self exposeBinding:@"piece"];
}

- (id)initWithPiece:(id<PetriPiece>)startingPiece
{
	// Initialize the layer to hold a square aspect ratio
	if (![super initWithSquareAspectRatio])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Prettify
	[self setCornerRadius:8.0];
	[self setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.8)]; // FIXME: debug
	
	// Create a layer for the first piece
	currentPieceLayer = [self pieceLayerForPiece:startingPiece];
	
	// Place the layer in the container
	[self setSublayers:[NSArray arrayWithObject:currentPieceLayer]];
	
	return self;
}

#pragma mark -
#pragma mark Layout

- (PetriPieceLayer*)pieceLayerForPiece:(id<PetriPiece>)newPiece
{
	// Create a piece layer
	PetriPieceLayer* pieceLayer = [PetriPieceLayer pieceLayerForPiece:newPiece];
	
	// Anchor the layer to the center of its superlayer (this container)
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	return pieceLayer;
}

#pragma mark -
#pragma mark Accessors

- (void)setPiece:(id<PetriPiece>)newPiece
{
	// Create a layer for the new piece
	currentPieceLayer = [self pieceLayerForPiece:newPiece];
	
	// Place the new layer in the container
	[self setSublayers:[NSArray arrayWithObject:currentPieceLayer]];
}
- (id<PetriPiece>)piece
{
	return [currentPieceLayer piece];
}

@synthesize currentPieceLayer;
+ (NSSet*)keyPathsForValuesAffectingCurrentPieceLayer
{
	return [NSSet setWithObject:@"piece"];
}

@end
