//
//  NSArray+Subranges.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "NSArray+Subranges.h"

@implementation NSArray(Subranges)

- (NSArray*)subarrayFromIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(index, ([self count] - index))];
}

- (NSArray*)subarrayToIndex:(NSUInteger)index
{
	return [self subarrayWithRange:NSMakeRange(0, index)];
}

@end
