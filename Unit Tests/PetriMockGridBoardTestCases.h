//
//  PetriMockGridBoardTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriMockGridBoard;

@interface PetriMockGridBoardTestCases : SenTestCase
{
	PetriMockGridBoard* board;
}

- (void)testInitUsesCorrectDimensions;
- (void)testPlacePiece;

@end
