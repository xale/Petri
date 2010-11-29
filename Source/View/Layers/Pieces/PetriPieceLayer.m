//
//  PetriPieceLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceLayer.h"

#import "PetriSquareGridPiece.h"
#import "Petri2DCoordinates.h"

/*!
 Private methods on PetriPieceLayer.
 */
@interface PetriPieceLayer(Private)

/*!
 Returns an aspect ratio for the layer based on a piece's dimensions.
 @param displayPiece The piece this layer will display; the resulting aspect ratio will be the piece's \c width divided by its \c height.
 */
- (CGFloat)aspectRatioForPiece:(PetriSquareGridPiece*)displayPiece;

/*!
 Creates and lays out the cell sublayers for the given piece.
 @param displayPiece The piece whose configuration the sublayers will lay out according to.
 */
- (void)createCellSublayersForPiece:(PetriSquareGridPiece*)displayPiece;

@end


@implementation PetriPieceLayer

- (id)initWithPiece:(PetriSquareGridPiece*)displayPiece
{
	// Initialize the layer with the appropriate aspect ratio for the piece
	if (![super initWithAspectRatio:[self aspectRatioForPiece:displayPiece]])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Lay out the layer's cells
	[self createCellSublayersForPiece:displayPiece];
	
	piece = displayPiece;
	
	return self;
}

+ (id)pieceLayerForPiece:(PetriSquareGridPiece*)displayPiece
{
	return [[self alloc] initWithPiece:displayPiece];
}

#pragma mark -
#pragma mark Layout

- (CGFloat)aspectRatioForPiece:(PetriSquareGridPiece*)displayPiece
{
	return ((CGFloat)[displayPiece width] / (CGFloat)[displayPiece height]);
}

- (void)createCellSublayersForPiece:(PetriSquareGridPiece*)displayPiece
{
	// Create a sublayer for each cell in the piece
	for (Petri2DCoordinates* cellCoord in [displayPiece cellCoordinates])
	{
		// FIXME: preliminary implementation
		CALayer* cellLayer = [CALayer layer];
		[cellLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)];	// FIXME: debug
		
		// Constrain the layer's size as a proportion of this layer's size
		[cellLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															relativeTo:@"superlayer"
															 attribute:kCAConstraintWidth
																 scale:(0.95 / [displayPiece width])
																offset:0.0]];
		[cellLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															relativeTo:@"superlayer"
															 attribute:kCAConstraintHeight
																 scale:(0.95 / [displayPiece height])
																offset:0.0]];
		
		// Constrain the layer's position according the cell's coordinates
		[cellLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidX
															relativeTo:@"superlayer"
															 attribute:kCAConstraintWidth
																 scale:(([cellCoord xCoordinate] + 0.5) / [displayPiece width])
																offset:0.0]];
		[cellLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
															relativeTo:@"superlayer"
															 attribute:kCAConstraintHeight
																 scale:(([cellCoord yCoordinate] + 0.5) / [displayPiece height])
																offset:0.0]];
		
		// Add the layer to this layer's sublayers
		[self addSublayer:cellLayer];
	}
}

#pragma mark -
#pragma mark Accessors

@synthesize piece;

@end
