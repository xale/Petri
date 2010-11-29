//
//  PetriGridPieceTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriMockGridPiece;

@interface PetriGridPieceTestCases : SenTestCase
{
	PetriMockGridPiece* testPiece;
	NSSet* testSet;
	NSSet* rotatedSet; // Should be testSet after one rotation
	NSSet* denormalizedSet; // Should be equivalent to testSet after normalization
}

- (void)testPieceEquality;
- (void)testPieceDimensions;
- (void)testPieceCopy;
- (void)testNormalization;
@end
