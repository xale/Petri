//
//  PetriItemStackLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/12/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriItemStackLayer.h"

#import "PetriItemLayer.h"

#import "CALayer+ConstraintSets.h"

#define PetriItemStackLayerMaxStackedLayers	3

/*!
 Private methods on PetriItemStackLayer.
 */
@interface PetriItemStackLayer(Private)

- (NSArray*)stackOfLayersForItem:(PetriItem*)itemType
						   count:(NSUInteger)count;

- (CATextLayer*)stackCountLabelLayerForCount:(NSUInteger)count;

- (NSString*)stackLabelStringForCount:(NSUInteger)count;

@end

@implementation PetriItemStackLayer

- (id)initWithItem:(PetriItem*)itemType
			 count:(NSUInteger)initialCount
{
	// If the count is zero, do not create a stack
	if (initialCount == 0)
		return nil;
	
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Create the stack of layers
	[self setSublayers:[self stackOfLayersForItem:itemType
											count:initialCount]];
	
	// Create a label for the number of items in the stack
	stackCountLabel = [self stackCountLabelLayerForCount:initialCount];
	[self addSublayer:stackCountLabel];
	
	item = itemType;
	itemCount = initialCount;
	
	return self;
}

+ (id)itemStackWithItem:(PetriItem*)itemType
				  count:(NSUInteger)initialCount
{
	return [[self alloc] initWithItem:itemType
								count:initialCount];
}

#pragma mark -
#pragma mark Layout
		
- (NSArray*)stackOfLayersForItem:(PetriItem*)itemType
						   count:(NSUInteger)count
{
	// Create some Item sublayers, up to a maximum number
	NSMutableArray* layers = [NSMutableArray arrayWithCapacity:MIN(count, (NSUInteger)PetriItemStackLayerMaxStackedLayers)];
	
	// Anchor the first layer in the lower-left
	PetriItemLayer* layer = [PetriItemLayer itemLayerForItem:itemType];
	[layer addConstraintsFromSet:[CAConstraint superlayerLowerLeftCornerConstraintSet]];
	[layers addObject:layer];
	
	if (count > 1)
	{
		// Anchor the second layer in the center
		layer = [PetriItemLayer itemLayerForItem:itemType];
		[layer addConstraintsFromSet:[CAConstraint superlayerCenterConstraintSet]];
		[layers addObject:layer];
		
		if (count > 2)
		{
			// Anchor the third layer to the top-right
			layer = [PetriItemLayer itemLayerForItem:itemType];
			[layer addConstraintsFromSet:[CAConstraint superlayerUpperRightCornerConstraintSet]];
			[layers addObject:layer];
		}
	}
	
	return [layers copy];
}

NSString* const PetriItemStackLayerCountLabelFontName =		@"Arial Rounded MT Bold";

- (CATextLayer*)stackCountLabelLayerForCount:(NSUInteger)count
{
	// Create a text layer
	CATextLayer* label = [CATextLayer layer];
	[label setString:[self stackLabelStringForCount:count]];
	
	// Set the font to the Petri title font
	CTFontRef nicknameFont = CTFontCreateWithName((CFStringRef)PetriItemStackLayerCountLabelFontName, 0.0, NULL);
	[label setFont:nicknameFont];
	CFRelease(nicknameFont);
	
	// Make the text black-on-white
	[label setForegroundColor:CGColorGetConstantColor(kCGColorBlack)];
	[label setBackgroundColor:CGColorGetConstantColor(kCGColorWhite)];
	
	// Configure the size and position of the layer
	[label setAlignmentMode:kCAAlignmentRight];
	[label setTruncationMode:kCATruncationStart];
	[label addConstraintsFromSet:[CAConstraint superlayerLowerRightCornerConstraintSet]];
	[label setCornerRadius:3.0];
	
	// Conditionally show or hide the label
	[label setHidden:(count <= PetriItemStackLayerMaxStackedLayers)];
	
	return label;
}

NSString* const PetriItemStackLayerCountLabelFormat =	@"x%d";

- (NSString*)stackLabelStringForCount:(NSUInteger)count
{
	return [NSString stringWithFormat:PetriItemStackLayerCountLabelFormat, count];
}

#define PetriItemStackLayerCountLabelFontSizeScale	0.3
#define PetriItemStackLayerSublayerScale			0.85

- (void)layoutSublayers
{
	// Change the label font size
	[stackCountLabel setFontSize:(CGRectGetHeight([self bounds]) * PetriItemStackLayerCountLabelFontSizeScale)];
	
	// Re-layout the sublayers
	// Determine whether the new bounds are taller than wide, or vice-versa
	CGFloat minorDimension = MIN(CGRectGetWidth([self bounds]), CGRectGetHeight([self bounds]));
	
	// Scale the other sublayers to a proportion of the minor dimension
	CGFloat scaledDimension = (minorDimension * PetriItemStackLayerSublayerScale);
	for (CALayer* sublayer in [self sublayers])
	{
		if (![sublayer isEqual:stackCountLabel])
		{
			[sublayer setBounds:CGRectMake(0.0, 0.0, scaledDimension, scaledDimension)];
		}
	}
	
	[super layoutSublayers];
}

#pragma mark -
#pragma mark Accessors

- (PetriItemLayer*)topItemLayer
{
	for (CALayer* sublayer in [[self sublayers] reverseObjectEnumerator])
	{
		if ([sublayer isKindOfClass:[PetriItemLayer class]])
			return (PetriItemLayer*)sublayer;
	}
	
	// FIXME: should throw an NSInternalInconsistencyException
	return nil;	// Note that this should never happen, since this layer should not exist if the number of items in the stack is zero
}

@synthesize item;

- (void)setItemCount:(NSUInteger)newCount
{
	// If there are no items left in the stack, remove the layer from its superlayer
	if (newCount == 0)
	{
		[self removeFromSuperlayer];
		return;
	}
	
	// Re-create the stacked sublayers
	[self setSublayers:[self stackOfLayersForItem:[self item]
											count:newCount]];
	
	// Position the stack count on top
	stackCountLabel = [self stackCountLabelLayerForCount:newCount];
	[self addSublayer:stackCountLabel];
	
	itemCount = newCount;
}
@synthesize itemCount;

@end
