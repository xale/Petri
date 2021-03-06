//
//  PetriUser.m
//  Petri
//
//  Created by Alex Heinz on 10/13/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriUser.h"


@implementation PetriUser

- (id)initWithNickname:(NSString*)userNickname
		   playerColor:(NSColor*)color
{
	nickname = [userNickname copy];
	playerColor = [color copy];
	
	return self;
}

#pragma mark -
#pragma mark Accessors

@synthesize nickname;
@synthesize playerColor;

@end
