//
//  PetriItemIconDisplayTransformer.h
//  Petri
//
//  Created by Alex Heinz on 12/14/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief Maps a PetriItem to the image provided as its icon.
 
 The PetriItemIconDisplayTransformer is an NSValueTransformer subclass which takes a PetriItem as its input and returns the NSImage containing that item's \c icon as its output.
 */
@interface PetriItemIconDisplayTransformer : NSValueTransformer

/*!
 Convenience method. Creates a new PetriItemIconDisplayTransformer.
 */
+ (id)valueTransformer;

/*!
 Override. Returns \c NO.
 */
+ (BOOL)allowsReverseTransformation;

/*!
 Override. Returns [\c NSImage \c class].
 */
+ (Class)transformedValueClass;

/*!
 Override. Returns an NSImage taken from the input PetriItem's \c icon property.
 */
- (id)transformedValue:(id)value;

@end
