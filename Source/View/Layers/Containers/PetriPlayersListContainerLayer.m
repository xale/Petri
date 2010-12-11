//
//  PetriPlayersListContainerLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/1/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayersListContainerLayer.h"

#import "PetriPlayerStatusLayer.h"

/*!
 Private methods on PetriPlayersListContainerLayer
 */
@interface PetriPlayersListContainerLayer(Private)

/*!
 Creates new player-status boxes for the specified players list.
 @param players The new list of players for which to create status boxes.
 @param playerSlots The number of slots which the new players can occupy.
 @param initialSelectedPlayer The selected player when the boxes are created.
 */
- (NSArray*)statusBoxLayersForPlayers:(NSArray*)players
								slots:(NSUInteger)playerSlots
					   selectedPlayer:(PetriPlayer*)initialSelectedPlayer;

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
												 slots:playerSlots
										selectedPlayer:startingPlayer]];
	
	// Hold references to the player list and starting player
	playersList = players;
	selectedPlayer = startingPlayer;
	
	return self;
}

#pragma mark -
#pragma mark Layout

- (NSArray*)statusBoxLayersForPlayers:(NSArray*)players
								slots:(NSUInteger)playerSlots
					   selectedPlayer:(PetriPlayer*)initialSelectedPlayer
{
	// Create "status box" layers for each player in the game
	NSMutableArray* statusBoxes = [NSMutableArray arrayWithCapacity:[players count]];
	PetriPlayer* player;
	for (NSUInteger playerNum = 0; playerNum < [players count]; playerNum++)
	{
		// Get the player at this index
		player = [players objectAtIndex:playerNum];
		
		// Create a status box for the player
		PetriPlayerStatusLayer* statusBox = [PetriPlayerStatusLayer playerStatusLayerForPlayer:player
																					  selected:[player isEqual:initialSelectedPlayer]];
		
		// Anchor the status box to the left edge of the container
		[statusBox addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
															relativeTo:@"superlayer"
															 attribute:kCAConstraintMinX]];
		
		// Position the status box a proportional distance from the top of the container
		CGFloat topPositionScale = (1.0 - ((CGFloat)playerNum / (CGFloat)playerSlots));
		[statusBox addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxY
															relativeTo:@"superlayer"
															 attribute:kCAConstraintMaxY
																 scale:topPositionScale
																offset:0]];
		
		// Size the status box to fill the container layer horizontally
		[statusBox addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															relativeTo:@"superlayer"
															 attribute:kCAConstraintWidth]];
		[statusBox addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															relativeTo:@"superlayer"
															 attribute:kCAConstraintHeight
																 scale:(1.0 / playerSlots)
																offset:0]];
		[statusBoxes addObject:statusBox];
	}
	
	return [statusBoxes copy];
}

#pragma mark -
#pragma mark Accessors

@synthesize playersList;

- (void)setSelectedPlayer:(PetriPlayer*)newSelectedPlayer
{
	// Select the status box corresponding to the player
	for (PetriPlayerStatusLayer* statusBox in [self sublayers])
	{
		[statusBox setSelected:[[statusBox player] isEqual:newSelectedPlayer]];
	}
	
	// Hold a reference to the player
	selectedPlayer = newSelectedPlayer;
}
@synthesize selectedPlayer;

@end
