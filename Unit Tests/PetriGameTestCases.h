//
//  PetriGameTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PetriGame;

@interface PetriGameTestCases : SenTestCase
{
	PetriGame* testGame;
}

- (void)testGameBoardNotNil;
- (void)testGameBoardHandlesEmptyPlayersArray;
- (void)testGameBoardHandlesNilPlayersArray;

@end