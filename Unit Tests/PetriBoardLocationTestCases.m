//
//  PetriBoardLocationTestCases.m
//  Petri
//
//  Created by Paul Martin on 10/11/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardLocationTestCases.h"
#import "PetriBoardLocation.h"

@implementation PetriBoardLocationTestCases

- (id)testCreatePetriBoardLocation
{
	PetriBoardLocation* testPetriBoardLocation = [[PetriBoardLocation alloc] init];
	STAssertNotNil(testPetriBoardLocation, @"PetriBoardLocation object creation unsuccessful");
}

- (id)testRotatePetriPiece
{
	PetriBoardLocation* testPetriBoardLocation = [[PetriBoardLocation alloc] init];
	PetriBoardLocation* testPetriBoardLocation2 = [[PetriBoardLocation alloc] init];
	
	[testPetriBoardLocation2 locationRotatedClockwiseAboutOrigin];
	[testPetriBoardLocation2 locationRotatedCounterclockwiseAboutOrigin];
	
	STAssertEqualObjects(testPetriBoardLocation, testPetriBoardLocation2, @"Both pieces should have equivalent positions");
}

@end
