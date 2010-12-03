//
//  PetriPlayersListContainerLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/1/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayersListContainerLayer.h"

/*!
 Private methods on PetriPlayersListContainerLayer
 */
@interface PetriPlayersListContainerLayer(Private)

/*!
 Creates new player-status boxes for the specified players list.
 @param players The new list of players for which to create status boxes.
 @param playerSlots The number of slots which the new players can occupy.
 */
- (NSArray*)statusBoxLayersForPlayers:(NSArray*)players
								slots:(NSUInteger)playerSlots;

@end

@implementation PetriPlayersListContainerLayer

+ (void)initialize
{
	[self exposeBinding:@"selectedPlayer"];
}

- (id)initWithPlayersList:(NSArray*)players
			  playerSlots:(NSUInteger)playerSlots
		   selectedPlayer:(PetriPlayer*)startingPlayer
{
	// Initialize the layer
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Create sublayers for the player-status boxes
	[self setSublayers:[self statusBoxLayersForPlayers:players
												 slots:playerSlots]];
	
	// Hold references to the player list and starting player
	playersList = players;
	selectedPlayer = startingPlayer;
	
	return self;
}

#pragma mark -
#pragma mark Layout

- (NSArray*)statusBoxLayersForPlayers:(NSArray*)players
								slots:(NSUInteger)playerSlots
{
	// Create "status box" layers for each player in the game
	NSMutableArray* statusBoxes = [NSMutableArray arrayWithCapacity:[players count]];
	for (NSUInteger playerNum = 0; playerNum < [players count]; playerNum++)
	{
		CALayer* statusBoxLayer = [CALayer layer];
		[statusBoxLayer setCornerRadius:8.0];
		
		// Color the layer according to the player's color
		NSColor* playerColor = [[players objectAtIndex:playerNum] color];
		CGColorRef boxColor = CGColorCreateGenericRGB([playerColor redComponent], [playerColor greenComponent], [playerColor blueComponent], 1.0);
		[statusBoxLayer setBackgroundColor:boxColor];
		CGColorRelease(boxColor);
		
		// Anchor the status box to the left edge of the container
		[statusBoxLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
																 relativeTo:@"superlayer"
																  attribute:kCAConstraintMinX]];
		
		// Position the status box a proportional distance from the top of the container
		CGFloat topPositionScale = (1.0 - ((CGFloat)playerNum / (CGFloat)playerSlots));
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
																	  scale:(1.0 / playerSlots)
																	 offset:0]];
		[statusBoxes addObject:statusBoxLayer];
	}
	
	return [statusBoxes copy];
}

#pragma mark -
#pragma mark Accessors

@synthesize playersList;
@synthesize selectedPlayer; // FIXME: WRITEME: override -setSelectedPlayer: to highlight new current player

@end
