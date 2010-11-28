//
//  PetriGameplayView.m
//  Petri
//
//  Created by Alex Heinz on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameplayView.h"

#import "PetriGame.h"
#import "PetriPlayer.h"
#import "PetriBoardCell.h"
#import "PetriPiece.h"

#import "PetriAspectRatioLayer.h"
#import "PetriBoardLayer.h"
#import "PetriBoardCellLayer.h"
#import "PetriPieceLayer.h"

#import "CALayer+ConstraintSets.h"

/*!
 Private methods on PetriGameplayView.
 */
@interface PetriGameplayView(Private)

/*!
 Creates a new board layer for the specified board, set up for display on this view as a sublayer of the outer container layer.
 @param newBoard The board for which to create a Board Layer.
 */
- (PetriBoardLayer*)createBoardLayerForBoard:(id<PetriBoard>)newBoard;

/*!
 Creates the CALayer used as an outer container for all visible layers on the view, and maintains their aspect ratio over view resize.
 @param newBoardLayer The new board layer to contain, which defines the aspect ratio of the new container.
 */
- (CALayer*)createOuterContainerLayerForBoardLayer:(PetriBoardLayer*)newBoardLayer;

/*!
 Creates the layer used as the container for the current piece.
 */
- (CALayer*)createPieceBoxLayer;

/*!
 Creates the layer used as the container for the player-status boxes.
 */
- (CALayer*)createPlayerBoxesConstainerLayer;

/*!
 Creates new player-status boxes for the specified players list.
 @param playersList The new list of players for which to create status boxes.
 */
- (NSArray*)createStatusBoxLayersForPlayers:(NSArray*)playersList;

/*!
 Called when the view receives a -mouseDown: event corresponding to a click on a cell of the board.
 */
- (void)boardCellLayerClicked:(PetriBoardCellLayer*)clickedLayer;

/*!
 Called when the view recieves a -mouseDown: event corresponding to a click on the piece-box layer.
 */
- (void)pieceBoxLayerClicked:(CALayer*)clickedLayer;

/*!
 Called when the view receives a -keyDown: event corresponding to a press of the spacebar.
 */
- (void)spacebarDown:(NSEvent*)keyEvent;

@end

@implementation PetriGameplayView

+ (void)initialize
{
	[self exposeBinding:@"players"];
	[self exposeBinding:@"currentPlayer"];
	[self exposeBinding:@"board"];
	[self exposeBinding:@"currentPiece"];
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
	
	// Create container layers, but do not add them to the view yet
	pieceBoxLayer = [self createPieceBoxLayer];
	playerBoxesConstainerLayer = [self createPlayerBoxesConstainerLayer];
}

#pragma mark -
#pragma mark Configuration and Drawing Attributes

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)isOpaque
{
	return NO;
}

#pragma mark -
#pragma mark View Layout

#define PetriGameplayViewSidebarProportion		0.3

- (PetriBoardLayer*)createBoardLayerForBoard:(id<PetriBoard>)newBoard
{
	// Create a layer for the game board
	PetriBoardLayer* boardLayer = [PetriBoardLayer boardLayerForBoard:newBoard];
	
	// Anchor the board to the lower-left corner of its superlayer
	[boardLayer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	
	// Constrain the board's height to the height of its superlayer
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight]];
	[boardLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														 relativeTo:@"superlayer"
														  attribute:kCAConstraintHeight
															  scale:[boardLayer aspectRatio]
															 offset:0.0]];
	
	return boardLayer;
}

- (CALayer*)createOuterContainerLayerForBoardLayer:(PetriBoardLayer*)newBoardLayer
{
	// Calculate the aspect ratio of the new container layer, based on the new board's aspect ratio
	CGFloat containerRatio = ([newBoardLayer aspectRatio] + PetriGameplayViewSidebarProportion);
	
	// Create the container layer
	CALayer* newContainer = [PetriAspectRatioLayer layerWithAspectRatio:containerRatio];
	[newContainer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Constrain the container layer to fill the view
	[newContainer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[newContainer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Add the board to the container layer
	[newContainer addSublayer:newBoardLayer];
	
	return newContainer;
}

- (CALayer*)createPieceBoxLayer
{
	// Create a layer
	CALayer* boxLayer = [PetriAspectRatioLayer squareLayer];
	[boxLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	[boxLayer setCornerRadius:8.0];
	[boxLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.8)]; // FIXME: debug
	
	// Anchor the layer to the lower-right corner of its superlayer
	[boxLayer addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	
	// Make the layer square, and size it proportionally to its superlayer
	[boxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
													   relativeTo:@"superlayer"
														attribute:kCAConstraintHeight
															scale:PetriGameplayViewSidebarProportion
														   offset:0]];
	[boxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
													   relativeTo:@"superlayer"
														attribute:kCAConstraintHeight
															scale:PetriGameplayViewSidebarProportion
														   offset:0]];
	
	return boxLayer;
}

- (CALayer*)createPlayerBoxesConstainerLayer
{
	// Create a container layer
	CALayer* playerContainerLayer = [CALayer layer];
	[playerContainerLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Anchor the container to the top-right corner of its superlayer
	[playerContainerLayer addConstraintsFromSet:[CAConstraint superlayerUpperRightCornerConstraintSet]];
	
	// Constrain the container to fill the right-edge "sidebar" of the superlayer (leaving space for the piece box below)
	[playerContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:(1.0 - PetriGameplayViewSidebarProportion)
																 offset:0]];
	[playerContainerLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriGameplayViewSidebarProportion
																 offset:0]];
	
	return playerContainerLayer;
}

- (NSArray*)createStatusBoxLayersForPlayers:(NSArray*)playersList
{
	// Determine the total number of player slots (to divide the space equally)
	// Note that the array contains NSNull placeholders for unfilled slots, which will render as empty space below the filled slots
	// FIXME: that note isn't actually true yet
	CGFloat playerSlotsCount = (CGFloat)[playersList count];
	
	// Filter the NSNull placeholders from the players list
	NSArray* newPlayers = [playersList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != %@", [NSNull null]]];
	
	// Create "status box" layers for each player in the game
	NSMutableArray* statusBoxes = [NSMutableArray arrayWithCapacity:[newPlayers count]];
	for (NSUInteger playerNum = 0; playerNum < [newPlayers count]; playerNum++)
	{
		CALayer* statusBoxLayer = [CALayer layer];
		[statusBoxLayer setCornerRadius:8.0];
		
		// Color the layer according to the player's color
		NSColor* playerColor = [[newPlayers objectAtIndex:playerNum] color];
		[statusBoxLayer setBackgroundColor:CGColorCreateGenericRGB([playerColor redComponent], [playerColor greenComponent], [playerColor blueComponent], 0.8)];	// FIXME: debug
		
		// Anchor the status box to the left edge of the container
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMinX]];
		
		// Position the status box a proportional distance from the top of the container
		CGFloat topPositionScale = ((playerSlotsCount - playerNum) / playerSlotsCount);
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMaxY
																	  scale:topPositionScale
																	 offset:0]];
		
		// Size the status box to fill the container layer horizontally
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintWidth]];
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintHeight
																	  scale:(1.0 / playerSlotsCount)
																	 offset:0]];
		[statusBoxes addObject:statusBoxLayer];
	}
	
	return [statusBoxes copy];
}

#pragma mark -
#pragma mark Input Events

#pragma mark Mouse

- (void)mouseDown:(NSEvent*)mouseEvent
{
	// Determine where on the view the click occurred
	NSPoint clickedPoint = [self convertPoint:[mouseEvent locationInWindow]
									 fromView:nil];
	
	// Find the clicked layer
	CALayer* clickedLayer = [[self layer] hitTest:NSPointToCGPoint(clickedPoint)];
	
	// Search the layer's ancestor tree, looking for layers of interest
	for (CALayer* searchLayer = clickedLayer; searchLayer != nil; searchLayer = [searchLayer superlayer])
	{
		// Cell on the board
		if ([searchLayer isKindOfClass:[PetriBoardCellLayer class]])
			[self boardCellLayerClicked:(PetriBoardCellLayer*)searchLayer];
		
		// Piece box
		if ([searchLayer isEqual:pieceBoxLayer])
			[self pieceBoxLayerClicked:searchLayer];
	}
}

- (void)boardCellLayerClicked:(PetriBoardCellLayer*)clickedLayer
{
	// Get cell of the board that was clicked
	PetriBoardCell* clickedCell = [clickedLayer cell];
	
	// Get the board from the clicked cell's superlayer
	id<PetriBoard> clickedBoard = [(PetriBoardLayer*)[clickedLayer superlayer] board];
	
	// Test if the current piece can be placed at the clicked coordinates
	/* FIXME: TESTING
	 BOOL validMove = [[self delegate] gameplayView:self
	 canPlacePiece:[self currentPiece]
	 forPlayer:[self currentPlayer]
	 onCell:clickedCell
	 ofBoard:clickedBoard];
	 */
	BOOL validMove = YES;	// FIXME: TESTING
	
	if (validMove)
	{
		// Place the current piece on the board
		[[self delegate] gameplayView:self
						   placePiece:[self currentPiece]
							forPlayer:[self currentPlayer]
							   onCell:clickedCell
							  ofBoard:clickedBoard];
	}
}

- (void)pieceBoxLayerClicked:(CALayer*)clickedLayer
{
	// FIXME: WRITEME
}

#pragma mark Keyboard

- (void)keyDown:(NSEvent*)keyEvent
{
	if ([[keyEvent characters] isEqualToString:@" "])
	{
		[self spacebarDown:keyEvent];
		return;
	}
	
	[super keyDown:keyEvent];
}

- (void)spacebarDown:(NSEvent*)keyEvent
{
	// Check if the user can rotate the current piece
	BOOL rotationAllowed = [[self delegate] gameplayView:self
								   canRotateCurrentPiece:[self currentPiece]
											   forPlayer:[self currentPlayer]];
	if (rotationAllowed)
	{
		// Rotate the current piece
		[[self delegate] gameplayView:self
				   rotateCurrentPiece:[self currentPiece]
							forPlayer:[self currentPlayer]];
	}
}

#pragma mark -
#pragma mark Accessors

@synthesize delegate;

- (void)setPlayers:(NSArray*)newPlayers
{
	// Create new player-status-box layers, and place them in their container
	[playerBoxesConstainerLayer setSublayers:[self createStatusBoxLayersForPlayers:newPlayers]];
	
	// Copy the new players list
	players = [newPlayers copy];
}
@synthesize players;
@synthesize currentPlayer;

- (void)setBoard:(id<PetriBoard>)newBoard
{
	// If it exists, remove the current container layer from the background
	[outerContainerLayer removeFromSuperlayer];
	
	// Create the new board layer
	PetriBoardLayer* boardLayer = [self createBoardLayerForBoard:newBoard];
	
	// (Re-)create the new container layer
	outerContainerLayer = [self createOuterContainerLayerForBoardLayer:boardLayer];
	
	// Add a layer to hold the piece to be played each turn
	[outerContainerLayer addSublayer:pieceBoxLayer];
	
	// Add a layer containing the status boxes for the players in the game
	[outerContainerLayer addSublayer:playerBoxesConstainerLayer];
	
	// Add the container to the view
	[[self layer] addSublayer:outerContainerLayer];
	
	// Hold a reference to the board object
	board = newBoard;
}
@synthesize board;

- (void)setCurrentPiece:(PetriPiece*)newPiece
{
	// Create a piece layer
	CALayer* pieceLayer = [PetriPieceLayer pieceLayerForPiece:newPiece];
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
	[pieceLayer addConstraintsFromSet:[CAConstraint superlayerSizeConstraintSet]];
	
	// Place the layer in the new-piece box
	[pieceBoxLayer setSublayers:[NSArray arrayWithObject:pieceLayer]];
	
	// Hold a reference to the board object
	currentPiece = newPiece;
}
@synthesize currentPiece;

@end
