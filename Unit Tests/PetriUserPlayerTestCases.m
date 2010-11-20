//
//  PetriUserPlayerTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserPlayerTestCases.h"
#import "PetriUserPlayer.h"
#import "PetriUser.h"

@implementation PetriUserPlayerTestCases

NSString* const nickname = @"Xale";

- (void)setUp
{
	user = [[PetriUser alloc] initWithNickname:nickname];
	STAssertNotNil(user, @"Failed in creation of a user");
	player = [[PetriUserPlayer alloc] initWithControllingUser:user];
	STAssertNotNil(player, @"Failed in creation of a player");
}

- (void)tearDown
{
	user = nil;
	player = nil;
}

- (void)testCreatePetriUserPlayer
{
	STAssertEquals(user, [player controllingUser], @"Creation of player with user misbehaved");
}

@end
