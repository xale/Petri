//
//  PetriGameGroup.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroup.h"

#import "PetriGame.h"
#import "PetriGameConfiguration.h"

#import "PetriPlayer.h"
#import "PetriUser.h"
#import "PetriUserPlayer.h"
#import "PetriAIPlayer.h"

@implementation PetriGameGroup

#pragma mark -
#pragma mark Accessors

- (id)initWithHost:(PetriUser*)gameHost
{
	host = gameHost;
	
	// FIXME: default values, for testing
	gameConfiguration = [PetriGameConfiguration defaultGameConfiguration];
	
	users = [NSMutableArray arrayWithObject:gameHost];
	game = nil;
	localGameGroup = YES; //FIXME: When we get networking, there actually needs to be some logic here.
	// Create an array of colors for the players
	// FIXME: hardcoded
	playerColors = [NSArray arrayWithObjects:
					[NSColor redColor],
					[NSColor blueColor],
					[NSColor greenColor],
					[NSColor yellowColor],
					[NSColor purpleColor],
					[NSColor orangeColor],
					nil];
	
	return self;
}

- (NSArray*)users
{
	return [users copy];
}

- (void)addUsersObject:(PetriUser*)user
{
	if ([users containsObject:user])
	{
		NSString* reason = [NSString stringWithFormat:@"Attempted to add user \"%@\" to %@.", [user nickname], users];
		[[NSException exceptionWithName:@"UserFoundWhenAddingException" reason:reason userInfo:nil] raise];
	}
	[self willChangeValueForKey:@"users"];
	[users addObject:user];
	[self didChangeValueForKey:@"users"];
}

- (void)removeUsersObject:(PetriUser*)user
{
	if (![users containsObject:user])
	{
		NSString* reason = [NSString stringWithFormat:@"Attempted to remove user \"%@\" from %@.", [user nickname], users];
		[[NSException exceptionWithName:@"UserNotFoundWhenRemovingException" reason:reason userInfo:nil] raise];
	}
	[self willChangeValueForKey:@"users"];
	[users removeObject:user];
	[self didChangeValueForKey:@"users"];
}

- (void)newGame
{
	// Create a list of players participating in the game
	NSMutableArray* players = [NSMutableArray array];
	
	// Add a player to the game representing each user in the group
	for (NSUInteger playerNum = 0; playerNum < [users count]; playerNum++)
	{
		[players addObject:[[PetriUserPlayer alloc] initWithPlayerID:playerNum
													 controllingUser:[users objectAtIndex:playerNum]]];
	}
	
	// Fill any remaining "player slots" in the game with AI players
	for (NSUInteger playerNum = [players count]; playerNum < [gameConfiguration minPlayers]; playerNum++)
	{
		[players addObject:[[PetriAIPlayer alloc] initWithPlayerID:playerNum
															 color:[playerColors objectAtIndex:playerNum]]];
	}
	
	// Create new game with the list of players and the currently-configured rules
	[self setGame:[[PetriGame alloc] initWithPlayers:[players copy]
								   gameConfiguration:gameConfiguration]];
}

@synthesize host;
@synthesize gameConfiguration;
@synthesize game;
@synthesize playerColors;
@synthesize isLocalGameGroup;

@end
