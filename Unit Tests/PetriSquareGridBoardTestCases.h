//
//  PetriSquareGridBoardTestCases.h
//  Petri
//
//  Created by Paul Martin on 10/11/22.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriSquareGridBoard;

@interface PetriSquareGridBoardTestCases : SenTestCase
{
	PetriSquareGridBoard* board;
}

- (void)testInitUsesCorrectDimensions;
- (void)testInitWithParameters;
- (void)testValidatePlacement;

@end
