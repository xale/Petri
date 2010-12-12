//
//  PetriPlayer+DisplayName.m
//  Petri
//
//  Created by Alex Heinz on 12/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayer+DisplayName.h"

#import "PetriAIPlayer.h"
#import "PetriUserPlayer.h"
#import "PetriUser.h"

@implementation PetriPlayer(DisplayName)

- (NSString*)displayName
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

@end

NSString* const PetriPlayerAIPlayerDisplayName =	@"Computer";

@implementation PetriAIPlayer(DisplayName)

- (NSString*)displayName
{
	return PetriPlayerAIPlayerDisplayName;
}

@end

@implementation PetriUserPlayer(DisplayName)

- (NSString*)displayName
{
	return [[self controllingUser] nickname];
}

@end

