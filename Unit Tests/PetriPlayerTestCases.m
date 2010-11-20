//
//  PetriPlayerTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayerTestCases.h"
#import "PetriMockPlayer.h"
#import "PetriBoardCell.h"
#import "PetriCellType.h"
#import "PetriItem.h"

@implementation PetriPlayerTestCases
- (void)setUp
{
	// Create a test instance
	testPlayer = [[PetriMockPlayer alloc] init];
	STAssertNotNil(testPlayer, @"PetriMockPlayer object creation unsuccessful");
}

- (void)tearDown
{
	testPlayer = nil;
}

- (void)testAddRemoveCountCells
{
	cellSet = [NSMutableSet setWithCapacity:50];
	PetriBoardCell* cell;
	for (NSInteger i = 0; i < 50; i++)
	{
		cell = [[PetriBoardCell alloc] initWithCellType:bodyCell owner:testPlayer pickUp:nil];
		[cellSet addObject:cell];
		[testPlayer addControlledCellsObject:cell];
	}
	cell = [[PetriBoardCell alloc] initWithCellType:headCell owner:testPlayer pickUp:nil];
	[cellSet addObject:cell];
	[testPlayer addControlledCellsObject:cell];
	
	//---
	NSSet* innnerSet;
	innnerSet = [NSSet setWithArray:[[testPlayer enumeratorOfControlledCells] allObjects]]
	STAssertTrue([innnerSet isEqualToSet:cellSet], @"Cells not added correctly to player.");
	
	cell = [cellSet anyObject];
	[cellSet removeObject:cell];
	[testPlayer removeControlledCellsObject:cell];
	innnerSet = [NSSet setWithArray:[[testPlayer enumeratorOfControlledCells] allObjects]];
	STAssertTrue([innnerSet isEqualToSet:cellSet], @"Cells not removed correctly from player.");
	
	STAssertTrue([cellSet count] == [testPlayer countOfControlledCells], @"CountOfControlledCells misbehaving");
}

@end
