//
//  PetriPieceLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceLayer.h"

#import "PetriPiece.h"

/*!
 Private methods on PetriPieceLayer.
 */
@interface PetriPieceLayer(Private)

/*!
 Returns a aspect ratio for the layer based on a piece's dimensions.
 */
- (CGFloat)aspectRatioForPiece:(PetriPiece*)p;

@end


@implementation PetriPieceLayer

- (id)initWithPiece:(PetriPiece*)displayPiece
{
	// Initialize the layer with the appropriate aspect ratio for the piece
	if (![super initWithAspectRatio:[self aspectRatioForPiece:displayPiece]])
		return nil;
	
	// Lay out the layer's cells
	// FIXME: WRITEME
	
	return self;
}

+ (id)pieceLayerForPiece:(PetriPiece*)displayPiece
{
	return [[self alloc] initWithPiece:displayPiece];
}

#pragma mark -
#pragma mark Layout

- (CGFloat)aspectRatioForPiece:(PetriPiece*)p
{
	// FIXME: WRITEME
	return 1.0;
}

#pragma mark -
#pragma mark Accessors

@synthesize piece;

@end
