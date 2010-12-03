//
//  PetriBoardParameter.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/3/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PetriBoardParameter : NSObject
{
	NSString* parameterName;
	id parameterValue;
	NSSet* validValues;
}

+ (id)boardParameterWithName:(NSString*)name
					   value:(id)value
				 validValues:(NSSet*)set;


- (id)initWithName:(NSString*)name
			 value:(id)value
	   validValues:(NSSet*)set;

@property (readonly) NSString* parameterName;
@property (readwrite) id parameterValue;
@property (readonly) NSSet* validValues;

@end
