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
					   value:(id)value
				 validValues:(NSArray*)allowedValues
{
	return [[self alloc] initWithName:name
								value:value
						  validValues:allowedValues];
}

- (id)initWithName:(NSString*)name
			 value:(id)value
	   validValues:(NSArray*)allowedValues
{
	parameterName = name;
	parameterValue = value;
	validValues = allowedValues;
	return self;
}

@synthesize parameterName;
@synthesize parameterValue;
@synthesize validValues;

@end
