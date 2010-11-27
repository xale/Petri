//
//  PetriItemTestCases.h
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriItem;

@interface PetriItemTestCases : SenTestCase
{
	PetriItem* testItem;
}

- (void)testItemEquality;
- (void)testCopyItem;

@end
