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
	NSInteger horizontalCoordinate;
	NSInteger verticalCoordinate;
}

- (id)initWithHorizontalCoordinate:(NSInteger)x
				verticalCoordinate:(NSInteger)y;

+ (id)coordinatesWithHorizontalCoordinate:(NSInteger)x
					   verticalCoordinate:(NSInteger)y;

- (Petri2DCoordinates*)rotatedClockwise;
- (Petri2DCoordinates*)rotatedCounterClockwise;

@property (readonly) NSInteger horizontalCoordinate;
@property (readonly) NSInteger verticalCoordinate;

@end
