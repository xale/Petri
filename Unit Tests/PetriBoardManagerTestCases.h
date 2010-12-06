//
//  PetriBoardManagerTestCases.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/6/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class PetriBoardManager;

@interface PetriBoardManagerTestCases : SenTestCase
{
	PetriBoardManager* manager;
}

- (void)testSingleton;
- (void)testRegister;

@end
