//
//  PetriPlayerFiltersValueTransformer.h
//  Petri
//
//  Created by Alex Heinz on 11/22/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief Maps a PetriPlayer to a CIColor representation of the player's color.
 
 The PetriPlayerColorValueTransformer is an NSValueTransformer subclass which converts takes a PetriPlayer as input and returns the player's \c color as a CIColor as output.
 */
@interface PetriPlayerColorValueTransformer : NSValueTransformer

/*!
 Convenience method. Creates a new PetriPlayerColorValueTransformer.
 */
+ (id)valueTransformer;

/*!
 Override. Returns \c NO.
 */
+ (BOOL)allowsReverseTransformation;

/*!
 Override. Returns [\c CIColor \c class].
 */
+ (Class)transformedValueClass;

/*!
 Override. Returns a CIColor taken from the input PetriPlayer's \c color.
 */
- (id)transformedValue:(id)value;

@end
