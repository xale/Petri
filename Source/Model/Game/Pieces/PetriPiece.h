//
//  PetriPiece.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol PetriPiece <NSObject, NSCopying>

/*!
 Returns the current orientation of the piece; updated by calls to -rotate:
 */
- (NSUInteger)orientation;

/*!
 Returns the number of different orientations this piece type supports.
 Certain pieces might have fewer unique orientations, but any piece of this type is guaranteed return to its initial orientation if rotated this many times.
 */
+ (NSUInteger)orientationCount;
/*!
 Rotates a piece; updates the value of -orientation:
 */
- (void)rotate;

@end
