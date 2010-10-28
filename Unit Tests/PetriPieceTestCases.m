//
//  PetriPieceTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/10/27.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPieceTestCases.h"


@implementation PetriPieceTestCases

- (id)testCreatePetriPiece
{
	PetriPiece* testPetriPiece = [[PetriPiece alloc] init];
	STAssertNotNil(testPetriPiece, @"PetriPiece object creation unsuccessful");
}


@end
