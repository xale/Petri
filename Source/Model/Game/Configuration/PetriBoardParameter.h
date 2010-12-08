//
//  PetriBoardParameter.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 12/3/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 A user configurable parameter of a board.
 */
@interface PetriBoardParameter : NSObject
{
	NSString* parameterName;	/*!< The name of the parameter; displayed to the user. */
	double parameterValue;		/*!< The current value of the parameter. */
	double minValidValue;		/*!< The minimum allowed value of the parameter. */
	double maxValidValue;		/*!< The maximum allowed value of the parameter. */
}

/*!
 Class method that returns an initialized object with all instance variables set.
 @param name the name of the parameter displayed to the user
 @param initialValue the initial value of the parameter
 @param minValue the minimum allowed value of the parameter
 @param maxValue the maximum allowed value of the parameter
 */
+ (id)boardParameterWithName:(NSString*)name
					   value:(double)initialValue
					 minimum:(double)minValue
					 maximum:(double)maxValue;

/*!
 Initializer that sets all the instance variables.
 @param name the name of the parameter
 @param initialValue the initial value of the parameter
 @param minValue the minimum allowed value of the parameter
 @param maxValue the maximum allowed value of the parameter
 */

- (id)initWithName:(NSString*)name
			 value:(double)initialValue
		   minimum:(double)minValue
		   maximum:(double)maxValue;

@property (readonly) NSString* parameterName;
@property (readwrite) double parameterValue;
@property (readonly) double minValidValue;
@property (readonly) double maxValidValue;

@end
