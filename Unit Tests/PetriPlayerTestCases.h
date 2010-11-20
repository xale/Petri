//
//  PetriPlayerTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriMockPlayer;

@interface PetriPlayerTestCases : SenTestCase
{
	PetriMockPlayer* testPlayer;
	NSMutableSet* cellSet;
}
/* Test cases it might be good to add:
 Check that we have exactly one head
 Check that we don't own unowned cells
 Check that we don't own cells owned by other players
 */

- (void)testAddRemoveCountCells;
//TODO: test item; blocking on items existing.
@end
