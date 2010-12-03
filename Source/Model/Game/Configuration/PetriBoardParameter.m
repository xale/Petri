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
				 validValues:(NSSet*)set
{
	return [[self alloc] initWithName:name value:value validValues:set];
}


- (id)initWithName:(NSString*)name
			 value:(id)value
	   validValues:(NSSet*)set
{
	parameterName = name;
	parameterValue = value;
	validValues = set;
	return self;
}

@synthesize parameterName;
@synthesize parameterValue;
@synthesize validValues;

@end
