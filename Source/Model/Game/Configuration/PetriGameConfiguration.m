//
//  PetriGameRules.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameConfiguration.h"
#import "PetriSquareGridBoard.h" // FIXME: this is for now; later this default should be abstracted away

#import "PetriBoardPrototype.h"
#import "PetriBoardManager.h"
#import "PetriPiece.h"

@implementation PetriGameConfiguration

+ (void)initialize
{
	[[PetriBoardManager sharedManager] registerBoardClass:[PetriSquareGridBoard class]];
}

+ (id)defaultGameConfiguration
{
	return [[self alloc] init];
}

NSString* const PetriInvalidGameConfigurationExceptionName =			@"invalidGameConfigurationException";
NSString* const PetriInvalidMinMaxPlayersExceptionDescriptionFormat =	@"Minimum players (%d) greater than maximum players (%d)";

- (id)initWithBoardPrototype:(PetriBoardPrototype*)prototype
{
	boardPrototype = prototype;
	minPlayers = [[prototype boardClass] absoluteMinPlayers];
	maxPlayers = [[prototype boardClass] absoluteMaxPlayers];
	pieceFrequencies = [[[prototype boardClass] pieceClass] defaultPieceFrequencies];

	return self;
}

- (id)init
{
	return [self initWithBoardPrototype:[PetriBoardPrototype prototypeForBoardClass:[[[PetriBoardManager sharedManager] registeredBoardClasses] anyObject]]];
}

#pragma mark -
#pragma mark Accessors

@synthesize minPlayers;
@synthesize maxPlayers;
@synthesize pieceFrequencies;
@synthesize boardPrototype;

@end
