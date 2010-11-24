//
//  PetriGameRules.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfiguration.h"
#import "PetriPiece.h"

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

+ (NSDictionary*)defaultPieceFrequencies
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithInteger:1],	[PetriPiece sPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece zPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece lPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece jPiece],
			[NSNumber numberWithInteger:1],	[PetriPiece line3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece line4Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece line5Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece j3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece l3Piece],
			[NSNumber numberWithInteger:1],	[PetriPiece squarePiece],
			nil];
}

#pragma mark -
#pragma mark Accessors

@synthesize minPlayers;
@synthesize maxPlayers;
@synthesize pieceFrequencies;

@end
