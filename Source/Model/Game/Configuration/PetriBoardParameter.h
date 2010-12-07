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
	id parameterValue;			/*!< The current value of the parameter. */
	NSArray* validValues;		/*!< A list of all valid values for the parameter. */
}

/*!
 Class method that returns an initialized object with all instance variables set.
 @param name the name of the parameter
 @param value the initial value of the parameter
 @param allowedValues a set of all permissible values of the parameter
 */
+ (id)boardParameterWithName:(NSString*)name
					   value:(id)value
				 validValues:(NSArray*)allowedValues;

/*!
 Initializer that sets all the instance variables.
 @param name the name of the parameter
 @param value the initial value of the parameter
 @param allowedValues an array of all permissible values of the parameter
 */

- (id)initWithName:(NSString*)name
			 value:(id)value
	   validValues:(NSArray*)allowedValues;

@property (readonly) NSString* parameterName;
@property (readwrite) id parameterValue;
@property (readonly) NSArray* validValues;

@end
