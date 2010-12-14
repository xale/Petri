//
//  PetriGameGroupUsersArrayController.m
//  Petri
//
//  Created by Alex Heinz on 12/14/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroupUsersArrayController.h"

#import "PetriGameGroup.h"
#import "PetriUser.h"
#import "PetriGameConfiguration.h"

@implementation PetriGameGroupUsersArrayController

+ (void)initialize
{
	[self exposeBinding:@"gameGroup"];
}

NSString* const PetriGameGroupUsersArrayControllerUserNicknameFormat =	@"Player %d";

- (id)newObject
{
	NSUInteger numUsers = [[[self gameGroup] users] count];
	return [[PetriUser alloc] initWithNickname:[NSString stringWithFormat:PetriGameGroupUsersArrayControllerUserNicknameFormat, (numUsers + 1)]
								   playerColor:[[[self gameGroup] defaultPlayerColors] objectAtIndex:numUsers]];
}

- (IBAction)add:(id)sender
{
	// Check that the number of users in the group is less than the maximum number of players
	if ([[self arrangedObjects] count] < [[[self gameGroup] gameConfiguration] maxPlayers])
	{
		// Add a user to the group
		[super add:sender];
	}
}

- (IBAction)remove:(id)sender
{
	// Check that the number of users in the group is greater than the minimum number of players
	if ([[self arrangedObjects] count] > [[[self gameGroup] gameConfiguration] minPlayers])
	{
		// Remove the last user in the group
		[self removeObjectAtArrangedObjectIndex:([[self arrangedObjects] count] - 1)];
	}
}

#pragma mark -
#pragma mark Accessors

@synthesize gameGroup;

@end
