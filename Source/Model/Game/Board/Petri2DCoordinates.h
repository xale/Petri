	//
//  Petri2DCoordinates.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/23/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Petri2DCoordinates : NSObject
{
	NSInteger xCoordinate;
	NSInteger yCoordinate;
}

- (id)initWithXCoordinate:(NSInteger)x
			  yCoordinate:(NSInteger)y;

+ (id)coordinatesWithXCoordinate:(NSInteger)x
					 yCoordinate:(NSInteger)y;

- (Petri2DCoordinates*)rotatedClockwiseAboutOrigin;
- (Petri2DCoordinates*)rotatedCounterclockwiseAboutOrigin;

@property (readonly) NSInteger xCoordinate;
@property (readonly) NSInteger yCoordinate;

@end
