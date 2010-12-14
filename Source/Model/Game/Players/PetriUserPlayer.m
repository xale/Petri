//
//  PetriUserPlayer.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUserPlayer.h"

#import "PetriUser.h"

@implementation PetriUserPlayer

/*!
 Override. Throws an exception; use -initWithPlayerID:controllingUser:color: instead.
 */
- (id)initWithPlayerID:(NSInteger)ID
				 color:(NSColor*)playerColor
{
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithPlayerID:(NSInteger)ID
	   controllingUser:(PetriUser*)user
{
	if (user == nil)
	{
		[NSException raise:NSInternalInconsistencyException
					format:@"User must not be nil."];
	}
	
	if (![super initWithPlayerID:ID color:[user playerColor]])
		return nil;
	
	controllingUser = user;
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize controllingUser;

@end
