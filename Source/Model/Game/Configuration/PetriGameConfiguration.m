//
//  PetriGameRules.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfiguration.h"
#import "PetriSquareGridPiece.h"
#import "PetriSquareGridBoard.h" // FIXME: this is for now; later this default should be abstracted away

#import "PetriBoardPrototype.h"

@implementation PetriGameConfiguration

+ (id)defaultGameConfiguration
{
	return [[self alloc] initWithMinPlayers:2
								 maxPlayers:4
						   pieceFrequencies:[PetriSquareGridPiece defaultPieceFrequencies]];
}

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
	prototype = [PetriBoardPrototype prototypeForBoardClass:[PetriSquareGridBoard class]];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize minPlayers;
@synthesize maxPlayers;
@synthesize pieceFrequencies;
@synthesize prototype;

@end
