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

@implementation PetriBoardLayer

NSString* const PetriUnknownBoardTypeExceptionName =				@"unknownBoardTypeException";
NSString* const PetriUnknownBoardTypeExceptionDescriptionFormat =	@"Cannot generate board layer for unknown board class: %@";

+ (id)boardLayerForBoard:(id <PetriBoard>)boardToDisplay
{
	// Attempt to determine the type of board
	// Square-grid
	if ([(id)boardToDisplay isKindOfClass:[PetriSquareGridBoard class]])
	{
		return [[PetriSquareGridBoardLayer alloc] initWithBoard:(PetriSquareGridBoard*)boardToDisplay];
	}
	
	// Unknown board type: throw an exception
	NSString* exceptionDesc = [NSString stringWithFormat:PetriUnknownBoardTypeExceptionDescriptionFormat, [(id)boardToDisplay class]];
	NSException* invalidKeyException = [NSException exceptionWithName:PetriUnknownBoardTypeExceptionName
															   reason:exceptionDesc
															 userInfo:nil];
	@throw invalidKeyException;
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
#pragma mark Accessors

@synthesize board;

@end
