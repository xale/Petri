	//
//  Petri2DCoordinates.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 Parameter object for storing coordinates on a 2D cartesian plane and performing operations on them.
 */
@interface Petri2DCoordinates : NSObject
{
	NSInteger xCoordinate;		/*!< The x coordinate stored by the object */
	NSInteger yCoordinate;		/*!< The y coordinate stored by the object */
}

/*!
 Throws an exception; use initWithXCoordinate:yCoordinate: instead.
 */
- (id)init;

/*!
 Initializes a point with x and y coordinates
 
 @param x the x coordinate
 @param y the y coordinate
 */
- (id)initWithXCoordinate:(NSInteger)x
			  yCoordinate:(NSInteger)y;

/*!
 Convenience constructor; allocates a Petri2DCoordinates object and initializes it with the coordinates given.
 
 @param x the x coordinate
 @param y the y coordinate
 */
+ (id)coordinatesWithXCoordinate:(NSInteger)x
					 yCoordinate:(NSInteger)y;

/*!
 Returns a point that is the rotation of this one clockwise around the origin.
 */
- (Petri2DCoordinates*)rotatedClockwiseAboutOrigin;

/*!
 Returns a point that is the rotation of this one counterclockwise around the origin.
 */
- (Petri2DCoordinates*)rotatedCounterclockwiseAboutOrigin;

/*!
 Comparator for coordinates; equivalent to checking that the x coordinates are equal and that the y coordinates are equal.
 */
- (BOOL)isEqualToCoordinates:(Petri2DCoordinates*)coordinates;

@property (readonly) NSInteger xCoordinate;
@property (readonly) NSInteger yCoordinate;

@end
