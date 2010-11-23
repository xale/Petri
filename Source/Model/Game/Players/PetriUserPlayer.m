//
//  PetriUserPlayer.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserPlayer.h"

@implementation PetriUserPlayer

- (id)initWithColor:(NSColor*)playerColor
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithControllingUser:(PetriUser*)user
						color:(NSColor*)playerColor
{
	if (![super initWithColor:playerColor])
	{
		return nil;
	}

	if (user == nil)
		[NSException raise:@"user must not be nil" format:@""];
	
	controllingUser = user;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize controllingUser;

@end
