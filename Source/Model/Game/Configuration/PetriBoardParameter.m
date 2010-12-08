//
//  PetriBoardParameter.m
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/3/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardParameter.h"

@implementation PetriBoardParameter

+ (id)boardParameterWithName:(NSString*)name
					   value:(double)initialValue
					 minimum:(double)minValue
					 maximum:(double)maxValue
{
	return [[self alloc] initWithName:name
								value:initialValue
							  minimum:minValue
							  maximum:maxValue];
}

- (id)initWithName:(NSString*)name
			 value:(double)initialValue
		   minimum:(double)minValue
		   maximum:(double)maxValue
{
	parameterName = name;
	parameterValue = initialValue;
	minValidValue = minValue;
	maxValidValue = maxValue;
	
	return self;
}

@synthesize parameterName;
@synthesize parameterValue;
@synthesize minValidValue;
@synthesize maxValidValue;

@end
