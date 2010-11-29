//
//  PetriPieceLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceLayer.h"
#import "PetriPiece.h"

#import "PetriSquareGridPiece.h"
#import "PetriSquareGridPieceLayer.h"

@implementation PetriPieceLayer

+ (void)initialize
{
	[self exposeBinding:@"orientation"];
}

NSString* const PetriUnknownPieceTypeExceptionName =				@"unknownPieceTypeException";
NSString* const PetriUnknownPieceTypeExceptionDescriptionFormat =	@"Cannot generate piece layer for unknown piece class: %@";

+ (id)pieceLayerForPiece:(id<PetriPiece>)displayPiece
{
	// Attempt to determine the type of piece
	// Square-grid
	if ([displayPiece isKindOfClass:[PetriSquareGridPiece class]])
	{
		return [[PetriSquareGridPieceLayer alloc] initWithPiece:(PetriSquareGridPiece*)displayPiece];
	}
	
	// Unknown board type: throw an exception
	NSString* exceptionDesc = [NSString stringWithFormat:PetriUnknownPieceTypeExceptionDescriptionFormat, [displayPiece class]];
	NSException* unknownPieceTypeException = [NSException exceptionWithName:PetriUnknownPieceTypeExceptionName
																	 reason:exceptionDesc
																   userInfo:nil];
	@throw unknownPieceTypeException;
}

- (id)initWithPiece:(id<PetriPiece>)displayPiece
		aspectRatio:(CGFloat)ratio
{
	// Check that we're not attempting to instantiate an abstract class
	if ([self isMemberOfClass:[PetriPieceLayer class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// Initialize the superclass with the appropriate aspect ratio
	if (![super initWithAspectRatio:ratio])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Hold a reference to the piece
	piece = displayPiece;
	
	// Bind the layer's orientation to the piece's
	[self bind:@"orientation"
	  toObject:displayPiece
   withKeyPath:@"orientation"
	   options:nil];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize piece;

- (void)setOrientation:(NSUInteger)newOrientation
{
	// Find the angle of rotation of the piece, as a proportional amount of a full circle
	CGFloat rotation = ((CGFloat)newOrientation / (CGFloat)[[[self piece] class] orientationsCount]);
	
	// Convert to radians
	rotation = -(rotation * (2.0 * M_PI));
	
	// Rotate the layer
	[self setValue:[NSNumber numberWithDouble:rotation]
		forKeyPath:@"transform.rotation"];
	
	// Change the local value
	orientation = newOrientation;
}
@synthesize orientation;

@end
