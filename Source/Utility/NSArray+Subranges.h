//
//  NSArray+Subranges.h
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 \category NSArray(Subranges)
 A category on NSArray that adds a pair of methods useful for defining subranges of the array.
 */
@interface NSArray(Subranges)

//! Returns an array containing all elements of the receiver including and after the specified index.
- (NSArray*)subarrayFromIndex:(NSUInteger)index;

//! Returns an array containing all elements of the receiver up to and excluding the specified index.
- (NSArray*)subarrayToIndex:(NSUInteger)index;

@end
