//
//  CALayer+ConstraintSets.m
//  Petri
//
//  Created by Alex Heinz on 11/21/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "CALayer+ConstraintSets.h"

@implementation CALayer(ConstraintSets)

- (void)addConstraintsFromSet:(NSSet*)constraintSet
{
	for (CAConstraint* constraint in constraintSet)
		[self addConstraint:constraint];
}

@end

@implementation CAConstraint(ConstraintSets)

+ (NSSet*)superlayerLowerLeftCornerConstraintSet
{
	return [NSSet setWithObjects:
			[CAConstraint constraintWithAttribute:kCAConstraintMinX
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMinX],
			[CAConstraint constraintWithAttribute:kCAConstraintMinY
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMinY],
			nil];
}

+ (NSSet*)superlayerLowerRightCornerConstraintSet
{
	return [NSSet setWithObjects:
			[CAConstraint constraintWithAttribute:kCAConstraintMaxX
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMaxX],
			[CAConstraint constraintWithAttribute:kCAConstraintMinY
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMinY],
			nil];
}

+ (NSSet*)superlayerUpperLeftCornerConstraintSet
{
	return [NSSet setWithObjects:
			[CAConstraint constraintWithAttribute:kCAConstraintMinX
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMinX],
			[CAConstraint constraintWithAttribute:kCAConstraintMaxY
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMaxY],
			nil];
}

+ (NSSet*)superlayerUpperRightCornerConstraintSet
{
	return [NSSet setWithObjects:
			[CAConstraint constraintWithAttribute:kCAConstraintMaxX
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMaxX],
			[CAConstraint constraintWithAttribute:kCAConstraintMaxY
									   relativeTo:@"superlayer"
										attribute:kCAConstraintMaxY],
			nil];
}

+ (NSSet*)superlayerSizeConstraintSet
{
	return [NSSet setWithObjects:
			[CAConstraint constraintWithAttribute:kCAConstraintWidth
									   relativeTo:@"superlayer"
										attribute:kCAConstraintWidth],
			[CAConstraint constraintWithAttribute:kCAConstraintHeight
									   relativeTo:@"superlayer"
										attribute:kCAConstraintHeight],
			nil];
}

@end
