//
//  CALayer+ConstraintSets.h
//  Petri
//
//  Created by Alex Heinz on 11/21/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief Allows a set of CAConstraints to be added to a CALayer with a single call.
 */
@interface CALayer(ConstraintSets)

/*!
 Adds the CAConstraints from the given set to the receiver's constraints.
 @param constraintSet An NSSet of CAConstraints to add to the layer.
 */
- (void)addConstraintsFromSet:(NSSet*)constraintSet;

@end

/*!
 \brief Provides methods for generating sets of related CAConstraints.
 */
@interface CAConstraint(ConstraintSets)

/*!
 Generates a set of CAConstraints that constrains a layer's center to the center of its superlayer.
 */
+ (NSSet*)superlayerCenterConstraintSet;

/*!
 Generates a set of CAConstraints that constrains a layer's lower-left corner to the lower-left corner of its superlayer.
 */
+ (NSSet*)superlayerLowerLeftCornerConstraintSet;

/*!
 Generates a set of CAConstraints that constrains a layer's lower-right corner to the lower-right corner of its superlayer.
 */
+ (NSSet*)superlayerLowerRightCornerConstraintSet;

/*!
 Generates a set of CAConstraints that constrains a layer's upper-left corner to the upper-left corner of its superlayer.
 */
+ (NSSet*)superlayerUpperLeftCornerConstraintSet;

/*!
 Generates a set of CAConstraints that constrains a layer's upper-right corner to the upper-right corner of its superlayer.
 */
+ (NSSet*)superlayerUpperRightCornerConstraintSet;

/*!
 Generates a set of CAConstraints that constrains a layer's size (i.e., \c width and \c height) to its superlayer's size.
 */
+ (NSSet*)superlayerSizeConstraintSet;

@end