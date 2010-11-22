//
//  PetriGameRules.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfiguration.h"


@implementation PetriGameConfiguration

NSString* const PetriInvalidGameConfigurationExceptionName =			@"invalidGameConfigurationException";
NSString* const PetriInvalidMinMaxPlayersExceptionDescriptionFormat =	@"Minimum players (%d) greater than maximum players (%d)";

- (id)initWithMinPlayers:(NSInteger)minPlayerCount
			  maxPlayers:(NSInteger)maxPlayerCount
		pieceFrequencies:(NSDictionary*)pieces
{

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

@end
