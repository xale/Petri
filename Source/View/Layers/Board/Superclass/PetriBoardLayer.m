//
//  PetriBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardLayer.h"

#import "PetriSquareGridBoard.h"
#import "PetriSquareGridBoardLayer.h"

#import "PetriBoardCellLayer.h"

@implementation PetriBoardLayer

NSString* const PetriUnknownBoardTypeExceptionName =				@"unknownBoardTypeException";
NSString* const PetriUnknownBoardTypeExceptionDescriptionFormat =	@"Cannot generate board layer for unknown board class: %@";

+ (id)boardLayerForBoard:(id<PetriBoard>)boardToDisplay
{
	// Attempt to determine the type of board
	// Square-grid
	if ([boardToDisplay isKindOfClass:[PetriSquareGridBoard class]])
	{
		return [[PetriSquareGridBoardLayer alloc] initWithBoard:(PetriSquareGridBoard*)boardToDisplay];
	}
	
	// Unknown board type: throw an exception
	NSString* exceptionDesc = [NSString stringWithFormat:PetriUnknownBoardTypeExceptionDescriptionFormat, [boardToDisplay class]];
	NSException* unknownBoardTypeException = [NSException exceptionWithName:PetriUnknownBoardTypeExceptionName
																	 reason:exceptionDesc
																   userInfo:nil];
	@throw unknownBoardTypeException;
}

- (id)initWithBoard:(id<PetriBoard>)boardToDisplay
		aspectRatio:(CGFloat)ratio
{
	// Check that we're not attempting to instantiate an abstract class
	if ([self isMemberOfClass:[PetriBoardLayer class]])
	{
		[self doesNotRecognizeSelector:_cmd];
		return nil;
	}
	
	// Initialize the superclass with the appropriate aspect ratio
	if (![super initWithAspectRatio:ratio])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Hold a reference to the board
	board = boardToDisplay;
	
	return self;
}

- (id)init
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

#pragma mark -
#pragma mark Cell Highlights

- (void)highlightCells:(NSSet*)cellsToHighlight
			   asValid:(BOOL)valid
{
	[self willChangeValueForKey:@"highlightedCells"];
	
	// Disable animations
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	// Un-highlight existing highlighted cells
	for (PetriBoardCellLayer* cellLayer in [self highlightedCells])
	{
		[cellLayer setHighlighted:NO];
	}
	
	// Highlight the new cells
	for (PetriBoardCellLayer* cellLayer in cellsToHighlight)
	{
		[cellLayer setHighlightsAsValid:valid];
		[cellLayer setHighlighted:YES];
	}
	
	[CATransaction commit];
	
	highlightedCells = cellsToHighlight;
	
	[self didChangeValueForKey:@"highlightedCells"];
}

#pragma mark -
#pragma mark Piece Scaling

- (void)scalePieceLayerToCellSize:(PetriPieceLayer*)pieceLayer
{
	[self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark Accessors

- (PetriBoardCellLayer*)cellLayerForCell:(PetriBoardCell*)cell
{
	// Search the sublayers for a cell layer containing the specified cell
	for (PetriBoardCellLayer* cellLayer in [self sublayers])
	{
		if ([[cellLayer cell] isEqual:cell])
			return cellLayer;
	}
	
	// No corresponding layer found
	return nil;
}

- (NSSet*)cellLayersForCells:(NSSet*)cells
{
	// Search the sublayers for cell layers containing the one of the specified cells
	NSMutableSet* cellLayers = [NSMutableSet setWithCapacity:[cells count]];
	for (PetriBoardCellLayer* cellLayer in [self sublayers])
	{
		if ([cells containsObject:[cellLayer cell]])
			[cellLayers addObject:cellLayer];
	}
	
	return [cellLayers copy];
}

@synthesize board;
@synthesize highlightedCells;

@end
