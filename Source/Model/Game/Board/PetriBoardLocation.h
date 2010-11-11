//
//  PetriBoardLocation.h
//  Petri
//
//  Created by Paul Martin on 10/11/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * Represents location on the petri board as an x, y coordinate pair
 */
@interface PetriBoardLocation : NSObject
{
	NSInteger x; /*!< The x coordinate of the location. */
	NSInteger y; /*!< The y coordinate of the location. */
}

/**
 * Initialize location with an integer for the x and an integer for the y coordinate
 * @param locX integral x coordinate
 * @param locY integral y coordinate
 */
- (id)initWithX:(NSInteger)locX
			  Y:(NSInteger)locY;

/**
 * Returns an allocated location
 * @param x integral x coordinate
 * @param y integral y coordinate
 */
+ (PetriBoardLocation*)locationWithX:(NSInteger)x
								   Y:(NSInteger)y;

/**
 * Rotates the location clockwise about the origin (x = y, y = -x)
 * @return new location rotated clockwise about the origin
 */
- (PetriBoardLocation*)locationRotatedClockwiseAboutOrigin;

/**
 * Rotates the location counterclockwise about the origin (x = -y, y = x)
 * @return new location rotated counterclockwise about the origin
 */
- (PetriBoardLocation*)locationRotatedCounterclockwiseAboutOrigin;

@property (readonly) NSInteger x;
@property (readonly) NSInteger y;

@end
