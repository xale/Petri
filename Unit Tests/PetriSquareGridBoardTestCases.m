//
//  PetriSquareGridBoardTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/11/22.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriSquareGridBoardTestCases.h"
#import "PetriBoard.h"
#import "PetriGridBoard.h"
#import "PetriSquareGridBoard.h"
#import "PetriPlayer.h"
#import "PetriMockPlayer.h"
#import "Petri2DCoordinates.h"
#import "PetriSquareGridPiece.h"
#import "PetriBoardCell.h"
#import "PetriBoardParameter.h"

#define WIDTH	20
#define HEIGHT	25

@implementation PetriSquareGridBoardTestCases

- (void)setUp
{
	board = [[PetriSquareGridBoard alloc] initWithWidth:WIDTH height:HEIGHT];
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

- (void)testInitWithParameters
{
	NSDictionary* params = [[board class] setupParameters];
	[[params objectForKey:@"height"] setParameterValue:HEIGHT];
	[[params objectForKey:@"width"] setParameterValue:WIDTH];
	PetriSquareGridBoard* board2 = [PetriSquareGridBoard boardWithParameters:params];
	STAssertTrue([board2 width]==WIDTH && [board2 height]==HEIGHT, @"Board width or height not assigned correctly.");
}

- (void)testValidatePlacement
{
	PetriPlayer* player = [[PetriMockPlayer alloc] init];
	NSSet* set = [NSSet setWithObjects:[Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:0], [Petri2DCoordinates coordinatesWithXCoordinate:0 yCoordinate:1], nil];
	PetriSquareGridPiece* piece = [PetriSquareGridPiece pieceWithCellCoordinates:set];
	NSInteger headX = 3;
	NSInteger headY = 3;
	
	PetriBoardCell* cell = [board cellAtX:headX Y:headY];
	[cell setCellType:headCell];
	[cell setOwner:player];
	[player addControlledCellsObject:cell];
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:headX yCoordinate:headY]], @"Overlapping placement should be invalid.");
	STAssertTrue([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headX-1) yCoordinate:headY]], @"Adjacent placement should be valid.");
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headX-2) yCoordinate:headY]], @"Non-adjacent placement should be invalid.");
	STAssertFalse([board validatePlacementOfPiece:piece withOwner:player atCoordinates:[Petri2DCoordinates coordinatesWithXCoordinate:(headX-1) yCoordinate:(headY+1)]], @"Diagonal adjacency placement should be invalid.");
}

@end
