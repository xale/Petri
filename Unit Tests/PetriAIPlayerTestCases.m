//
//  PetriAIPlayerTestCases.m
//  Petri
//
//  Created by Alex Heinz on 10/25/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriAIPlayerTestCases.h"
#import "PetriAIPlayer.h"

@implementation PetriAIPlayerTestCases

- (void)setUp
{
	testAIPlayer = [[PetriAIPlayer alloc] initWithColor:[NSColor redColor]];
}

- (void)tearDown
{
	testAIPlayer = nil;
}

@end
