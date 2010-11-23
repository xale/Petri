//
//  PetriMockGridBoardTestCases.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriMockGridBoardTestCases.h"
#import "PetriMockGridBoard.h"

#define WIDTH 20
#define HEIGHT 25

@implementation PetriMockGridBoardTestCases

- (void)setUp
{
	board = [[PetriMockGridBoard alloc] initWithWidth:WIDTH height:HEIGHT];
	STAssertNotNil(board, @"Initializing PetriSquareGridBoard failed.");
}

- (void)tearDown
{
	board = nil;
}

- (void)testInitUsesCorrectDimensions
{
	STAssertTrue([board width]==WIDTH && [board height]==HEIGHT, @"Board width or height not assigned correctly.");
}

@end
