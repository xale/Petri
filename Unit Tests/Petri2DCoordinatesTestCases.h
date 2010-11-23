//
//  Petri2DCoordinatesTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class Petri2DCoordinates;

@interface Petri2DCoordinatesTestCases : SenTestCase
{
	Petri2DCoordinates* coordinates;
}

- (void)testRotateIdentities;

@end
