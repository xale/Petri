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
#import "PetriUserPlayer.h"
#import "PetriAIPlayer.h"

@implementation PetriGameGroup

#pragma mark -
#pragma mark Accessors

- (id)initWithHost:(PetriUser*)gameHost
{
	host = gameHost;
	
	// FIXME: default values, for testing
	gameConfiguration = [[PetriGameConfiguration alloc] initWithMinPlayers:4
																maxPlayers:4
														  pieceFrequencies:nil]; // FIXME: should not be nil
	
	users = [NSMutableArray arrayWithObject:gameHost];
	game = nil;
	return self;
}

- (NSArray*)users
{
	return [users copy];
}

- (void)addUsersObject:(PetriUser*)user
{
	//FIXME: handle case of user already in users
	[self willChangeValueForKey:@"users"];
	[users addObject:user];
	[self didChangeValueForKey:@"users"];
}

- (void)removeUsersObject:(PetriUser*)user
{
	[self willChangeValueForKey:@"users"];
	[users removeObject:user];
	[self didChangeValueForKey:@"users"];
}

- (void)newGame
{
	NSMutableArray* players = [NSMutableArray array];
	for (PetriUser* user in users)
	{
		[players addObject:[[PetriUserPlayer alloc] initWithControllingUser:user]];
	}
	for (NSInteger numPlayers = [players count]; numPlayers < [gameConfiguration minPlayers]; numPlayers = [players count])
	{
		[players addObject:[[PetriAIPlayer alloc] init]];
	}
	[self setGame:[[PetriGame alloc] initWithPlayers:[players copy]
								   gameConfiguration:gameConfiguration]];
}

@synthesize host;
@synthesize gameConfiguration;
@synthesize game;

@end
