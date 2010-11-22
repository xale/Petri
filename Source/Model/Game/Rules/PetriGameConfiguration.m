//
//  PetriGameRules.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfiguration.h"

// FIXME: hardcoded values
#define PetriGameConfigurationDefaultAbsoluteMinPlayers	2
#define PetriGameConfigurationDefaultAbsoluteMaxPlayers	4

@implementation PetriGameConfiguration

NSString* const PetriInvalidGameConfigurationExceptionName =			@"invalidGameConfigurationException";
NSString* const PetriMinPlayersTooSmallExceptionDescriptionFormat =		@"Minimum players (%d) too small (must be at least %d)";
NSString* const PetriMaxPlayersTooLargeExceptionDescriptionFormat =		@"Maximum players (%d) too large (must be no more than %d)";
NSString* const PetriInvalidMinMaxPlayersExceptionDescriptionFormat =	@"Minimum players (%d) greater than maximum players (%d)";

- (id)initWithMinPlayers:(NSInteger)minPlayerCount
			  maxPlayers:(NSInteger)maxPlayerCount
		pieceFrequencies:(NSDictionary*)pieces
{
	// Test that the min and max player counts are sane
	// Min players no less than absolute minimum
	if (minPlayerCount < PetriGameConfigurationDefaultAbsoluteMinPlayers)	// FIXME: hardcoded value
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriMinPlayersTooSmallExceptionDescriptionFormat, minPlayerCount, PetriGameConfigurationDefaultAbsoluteMinPlayers];
		NSException* minTooSmallException = [NSException exceptionWithName:PetriInvalidGameConfigurationExceptionName
																	reason:exceptionDesc
																  userInfo:nil];
		@throw minTooSmallException;
	}
	
	// Max players no more than absolute maximum
	if (maxPlayerCount > PetriGameConfigurationDefaultAbsoluteMaxPlayers)	// FIXME: hardcoded value
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriMaxPlayersTooLargeExceptionDescriptionFormat, maxPlayerCount, PetriGameConfigurationDefaultAbsoluteMaxPlayers];
		NSException* maxTooLargeException = [NSException exceptionWithName:PetriInvalidGameConfigurationExceptionName
																	reason:exceptionDesc
																  userInfo:nil];
		@throw maxTooLargeException;
	}
	
	// Min players no greater than max players
	if (minPlayerCount > maxPlayerCount)
	{
		NSString* exceptionDesc = [NSString stringWithFormat:PetriInvalidMinMaxPlayersExceptionDescriptionFormat, minPlayerCount, maxPlayerCount];
		NSException* invalidMinMaxException = [NSException exceptionWithName:PetriInvalidGameConfigurationExceptionName
																	  reason:exceptionDesc
																	userInfo:nil];
		@throw invalidMinMaxException;
	}
	
	// Initialize members
	minPlayers = minPlayerCount;
	maxPlayers = maxPlayerCount;
	pieceFrequencies = pieces;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize minPlayers;
@synthesize maxPlayers;
@synthesize pieceFrequencies;

- (NSInteger)absoluteMinPlayers
{
	return PetriGameConfigurationDefaultAbsoluteMinPlayers;	// FIXME: hardcoded value
}

- (NSInteger)absoluteMaxPlayers
{
	return PetriGameConfigurationDefaultAbsoluteMaxPlayers;	// FIXME: hardcoded value
}

@end
