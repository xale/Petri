//
//  PetriGameGroupTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriGameGroupTestCases.h"
#import "PetriGameGroup.h"
#import "PetriUser.h"

@implementation PetriGameGroupTestCases

- (void)setUp
{
	user1 = [[PetriUser alloc] initWithNickname:@"Alex"];
	user2 = [[PetriUser alloc] initWithNickname:@"Paul"];
	user3 = [[PetriUser alloc] initWithNickname:@"Xale"];
	testGameGroup = [[PetriGameGroup alloc] initWithHost:user1];
	STAssertNotNil(testGameGroup, @"PetriGameGroup object creation unsuccessful");
}

- (void)tearDown
{
	user1 = nil;
	user2 = nil;
	user3 = nil;
	testGameGroup = nil;
}

- (void)testIdempotentAddRemove
{
	NSArray* array = [testGameGroup users];
	[testGameGroup addUsersObject:user2];
	[testGameGroup removeUsersObject:user2];
	STAssertTrue([array isEqualToArray:[testGameGroup users]], @"Add-remove pair should do nothing.");
}
- (void)testAdd
{
	[testGameGroup addUsersObject:user2];
	[testGameGroup addUsersObject:user3];
	NSArray* array = [testGameGroup users];
	NSLog(@"users: %@", array);
	STAssertEqualObjects([array objectAtIndex:0], user1, @"user1 not first in array.");
	STAssertEqualObjects([array objectAtIndex:1], user2, @"user2 not first in array.");
	STAssertEqualObjects([array objectAtIndex:2], user3, @"user3 not first in array.");
}
- (void)testRemove
{
	STAssertThrows([testGameGroup removeUsersObject:user2], @"remove should throw an exception if user not in group.");
	//FIXME: do we want to be able to remove the host?
	[testGameGroup removeUsersObject:user1];
	STAssertTrue([[testGameGroup users] count] == 0, @"users should be empty after removing only user.");
}

@end
