//
//  PetriPieceTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceTestCases.h"
#import "PetriPiece.h"

@implementation PetriPieceTestCases

- (id)testCreatePetriPiece
{
	PetriPiece* testPetriPiece = [[PetriPiece alloc] init];
	STAssertNotNil(testPetriPiece, @"PetriPiece object creation unsuccessful");
}

- (id)testRotatePetriPiece
{
	PetriPiece* testPetriPiece = [[PetriPiece alloc] init];
	PetriPiece* testPetriPiece2 = [[PetriPiece alloc] init];
	
	[testPetriPiece2 pieceRotatedClockwise];
	[testPetriPiece2 pieceRotatedCounterclockwise];
	
	STAssertEqualObjects([testPetriPiece cellLocations], [testPetriPiece2 cellLocations], @"Both pieces should have equivalent positions");
}

@end
