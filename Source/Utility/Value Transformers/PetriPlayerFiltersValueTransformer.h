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
 \brief Maps a PetriPlayer to a CIColorMonochrome-type CIFilter whose inputColor property is the player's color.
 
 The PetriPlayerFiltersValueTransformer is an NSValueTransformer subclass intended to provide a colorizing filter for use on a CALayer's \c filters property, which colors the layer according to the player's \c color property.
 */
@interface PetriPlayerFiltersValueTransformer : NSValueTransformer

/*!
 Convenience method. Creates a new PetriPlayerFiltersValueTransformer.
 */
+ (id)valueTransformer;

/*!
 Override. Returns \c NO.
 */
+ (BOOL)allowsReverseTransformation;

/*!
 Override. Returns [\c NSArray \c class].
 */
+ (Class)transformedValueClass;

/*!
 Override. Returns an NSArray with a single item, a CIFilter that colorizes input images using the input PetriPlayer's \c color.
 */
- (id)transformedValue:(id)value;

@end
