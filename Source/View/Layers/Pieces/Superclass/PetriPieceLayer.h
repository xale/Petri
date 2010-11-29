//
//  PetriPieceLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAspectRatioLayer.h"

@protocol PetriPiece;

/*!
 \brief An abstract CALayer subclass for drawing a PetriPiece object.
 
 The PetriPieceLayer is a abstract view-model class intended for representations of PetriPiece objects, which are rendered as a group of neutral (as in "player-color-less") cells in the appropriate arrangement.
 */
@interface PetriPieceLayer : PetriAspectRatioLayer
{
	id<PetriPiece> piece;	/*!< The piece this layer displays. */
	NSUInteger orientation;	/*!< The piece's orientation, used as the layer's rotation. Automatically bound to the piece's \c orientation property. */
}

/*!
 Factory method. Generates a PetriPieceLayer subclass appropriate for displaying the given piece.
 @param displayPiece The piece that should be displayed on the generated layer.
 */
+ (id)pieceLayerForPiece:(id<PetriPiece>)displayPiece;

/*!
 Initializes a new PetriPieceLayer with a reference to the specified piece.
 \warning Called by subclasses, do not invoke directly; use the class-factory method +pieceLayerForPiece: instead.
 @param displayPiece The PetriPiece this layer will represent.
 @param ratio The aspect ratio the piece layer will maintain.
 */
- (id)initWithPiece:(id<PetriPiece>)displayPiece
		aspectRatio:(CGFloat)ratio;

@property (readonly) id<PetriPiece> piece;
@property (readwrite, assign) NSUInteger orientation;

@end
