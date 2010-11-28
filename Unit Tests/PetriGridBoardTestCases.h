//
//  PetriBoardTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/27/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriGridBoard;

@interface PetriGridBoardTestCases : SenTestCase
{
	PetriGridBoard* testGridBoard;
}

- (void)testInitUsesCorrectDimensions;
- (void)testGridBoardCopy;
- (void)testPlacePiece;

@end
