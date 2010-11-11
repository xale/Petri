//
//  PetriBoardLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardLayer.h"

#import "PetriBoardCellLayer.h"

#import "NSArray+Subranges.h"

/*!
 Private methods on PetriBoardLayer.
 */
@interface PetriBoardLayer (Private)

/*!
 Returns one of this layer's Cell sublayers, specified by a key of the form \c x\@y , where \c x and \c y are the coordinates of the layer.
 */
- (PetriBoardCellLayer*)sublayerForCoordinateKey:(NSString*)key;

@end

@implementation PetriBoardLayer

#pragma mark -
#pragma mark KVC Accessors

NSString* const PetriBoardLayerCellSublayersKey	=	@"cellSublayers";

- (id)valueForUndefinedKey:(NSString*)key
{
	// Check if the key is referring to one of our cell sublayers
	if (![key hasPrefix:PetriBoardLayerCellSublayersKey])
	{
		// Key isn't of interest to us; see if our superclass cares
		return [super valueForUndefinedKey:key];
	}
	
	// Split the key into path components
	NSArray* pathComponents = [key componentsSeparatedByString:@"."];
	
	// Get the cell sublayer corresponding to the "coordinates" key
	PetriBoardCellLayer* sublayer = [self sublayerForCoordinateKey:[pathComponents objectAtIndex:1]];
	
	// Pass the rest of the path on to the sublayer
	return [sublayer valueForKey:[[pathComponents subarrayFromIndex:2] componentsJoinedByString:@"."]];
}

- (void)setValue:(id)value
 forUndefinedKey:(NSString*)key
{
	// Check if the key is referring to one of our cell sublayers
	if (![key hasPrefix:PetriBoardLayerCellSublayersKey])
	{
		// Key isn't of interest to us; see if our superclass cares
		[super setValue:value
		forUndefinedKey:key];
		return;
	}
	
	// Split the key into path components
	NSArray* pathComponents = [key componentsSeparatedByString:@"."];
	
	// Get the cell sublayer corresponding to the "indices" key
	PetriBoardCellLayer* sublayer = [self sublayerForCoordinateKey:[pathComponents objectAtIndex:1]];
	
	// Pass the rest of the path on to the sublayer
	[sublayer setValue:value
				forKey:[[pathComponents subarrayFromIndex:2] componentsJoinedByString:@"."]];
}

- (PetriBoardCellLayer*)sublayerForCoordinateKey:(NSString*)key
{
	// Determine the location of the cell sublayer
	NSArray* locationComponents = [key componentsSeparatedByString:@"@"];
	NSUInteger x = [[locationComponents objectAtIndex:0] integerValue];
	NSUInteger y = [[locationComponents objectAtIndex:1] integerValue];
	
	// Return the cell, if it exists
	if ((x < [cellSublayers count]) && (y < [[cellSublayers objectAtIndex:x] count]))
		return [[cellSublayers objectAtIndex:x] objectAtIndex:y];
	
	return nil;
}

@end
