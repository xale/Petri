//
//  PetriPieceTestCases.h
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriSquareGridPiece;

@interface PetriSquareGridPieceTestCases : SenTestCase
{
	PetriSquareGridPiece* testPiece;
}

- (void)testPieceEquality;
- (void)testPieceDimensions;
- (void)testPieceCopy;
- (void)testPieceIdempotentRotateRevert;
- (void)testPieceIdempotentRepeatedRotate;

@end
