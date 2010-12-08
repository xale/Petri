//
//  PetriCellTypeDisplayTransformer.h
//  Petri
//
//  Created by Alex Heinz on 12/8/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \brief Maps a PetriCellType to a layer-opacity value.
 
 The PetriCellTypeDisplayTransformer is an NSValueTransformer subclass which takes a PetriCellType as input and an opacity value (a \c float between \c 0.0 and \c 1.0) depending on the type, as follows: \c invalidCell: \c 0.0 (transparent), \c unoccupiedCell or \c bodyCell: \c 1.0 (opaque), \c headCell: \c 0.5.
 */
@interface PetriCellTypeDisplayTransformer : NSValueTransformer

/*!
 Convenience method. Creates a new PetriCellTypeDisplayTransformer.
 */
+ (id)valueTransformer;

/*!
 Override. Returns \c NO.
 */
+ (BOOL)allowsReverseTransformation;

/*!
 Override. Returns [\c NSNumber \c class].
 */
+ (Class)transformedValueClass;

/*!
 Override. Returns a \c float between \c 0.0 and \c 1.0, representing the opacity of a PetriBoardCellLayer, determined by a PetriBoardCell's \c cellType.
 */
- (id)transformedValue:(id)value;

@end
