//
//  PetriBoardLocation.h
//  Petri
//
//  Created by Paul Martin on 10/11/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PetriBoardLocation : NSObject
{
	NSInteger x;
	NSInteger y;
}

@property (readonly) NSInteger x;
@property (readonly) NSInteger y;

@end
