//
//  PetriBoardCellLayer.m
//  Petri
//
//  Created by Alex Heinz on 11/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriBoardCellLayer.h"

#import "PetriBoardCell.h"

#import "PetriPlayerColorValueTransformer.h"
#import "PetriCellTypeDisplayTransformer.h"
#import "PetriItemIconDisplayTransformer.h"

/*!
 Private methods on PetriBoardCellLayer.
 */
@interface PetriBoardCellLayer(Private)

/*!
 Creates a CIFilter suitable for use in highlighting the layer. Specifically, this filter is a CIExposureAdjust filter, whose inputEV can be raised or lowered to darken or brighten the cell.
 */
- (CIFilter*)highlightFilter;

/*!
 Returns a CABasicAnimation used to animate the inputEV parameter of the cell's highlighting filter. Highlighting the cell as valid produces a fast-pulsing animation which brightens the cell; highlighting as invalid produces a slower-pulsing darkening animation.
 */
- (CAAnimation*)highlightAnimationForValidHighlight:(BOOL)valid;

@end

@implementation PetriBoardCellLayer

+ (id)boardCellLayerForCell:(PetriBoardCell*)displayedCell
{
	return [[self alloc] initWithCell:displayedCell];
}

- (id)initWithCell:(PetriBoardCell*)displayedCell
{
	if (![super init])
		return nil;
	
	// FIXME: TESTING Bind the background color to the owner's color
	[self bind:@"backgroundColor"
	  toObject:displayedCell
   withKeyPath:@"owner"
	   options:[NSDictionary dictionaryWithObject:[PetriPlayerColorValueTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	
	// FIXME: TESTING: Bind the layer's opacity to the cell's type
	[self bind:@"opacity"
	  toObject:displayedCell
   withKeyPath:@"cellType"
	   options:[NSDictionary dictionaryWithObject:[PetriCellTypeDisplayTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	
	// Bind the layer's contents to the icon for the cell's item pickup, if any
	[self bind:@"contents"
	  toObject:displayedCell
   withKeyPath:@"pickUp"
	   options:[NSDictionary dictionaryWithObject:[PetriItemIconDisplayTransformer valueTransformer]
										   forKey:NSValueTransformerBindingOption]];
	[self setContentsGravity:kCAGravityResizeAspect];
	
	// Disable edge antialiasing, since theses layers will abut one another, and antialiasing may create artifacts
	[self setEdgeAntialiasingMask:0];
	
	// Create a filter and animation to use for highlighting the cell
	highlighted = NO;
	highlightsAsValid = NO;
	highlightFilter = [self highlightFilter];
	highlightAnimation = [self highlightAnimationForValidHighlight:highlightsAsValid];
	
	cell = displayedCell;
	
	return self;
}

#pragma mark -
#pragma mark Highlighting

NSString* const PetriBoardCellLayerHighlightFilterName =	@"highlightFilter";

- (CIFilter*)highlightFilter
{
	CIFilter* filter = [CIFilter filterWithName:@"CIExposureAdjust"];
	[filter setDefaults];
	[filter setValue:[NSNumber numberWithDouble:0.0]
			  forKey:kCIInputEVKey];
	[filter setName:PetriBoardCellLayerHighlightFilterName];
	
	return filter;
}

NSString* const PetriBoardCellLayerHighlightAnimationKey =	@"highlightAnimation";
NSString* const PetriBoardCellLayerHighlightAnimationKeyPathFormat =	@"filters.%@.%@";

#define PetriBoardCellLayerValidHighlightAnimationFilterExposureFromValue	(1.0)
#define PetriBoardCellLayerValidHighlightAnimationFilterExposureToValue		(-0.2)

#define PetriBoardCellLayerInvalidHighlightAnimationFilterExposureFromValue	(-2.0)
#define PetriBoardCellLayerInvalidHighlightAnimationFilterExposureToValue	(-0.5)

#define PetriBoardCellLayerValidHighlightAnimationDuration		0.5		// Seconds
#define PetriBoardCellLayerInvalidHighlightAnimationDuration	0.75

- (CAAnimation*)highlightAnimationForValidHighlight:(BOOL)valid
{
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:PetriBoardCellLayerHighlightAnimationKeyPathFormat, PetriBoardCellLayerHighlightFilterName, kCIInputEVKey]];
	
	// Set the endpoint values of the animation to be lighter or darker, and the animation duration, depending on the validity of the highlight
	NSNumber* fromValue = nil, * toValue = nil;
	NSTimeInterval animationDuration;
	if (valid)
	{
		fromValue = [NSNumber numberWithDouble:PetriBoardCellLayerValidHighlightAnimationFilterExposureFromValue];
		toValue = [NSNumber numberWithDouble:PetriBoardCellLayerValidHighlightAnimationFilterExposureToValue];
		animationDuration = PetriBoardCellLayerValidHighlightAnimationDuration;
	}
	else
	{
		fromValue = [NSNumber numberWithDouble:PetriBoardCellLayerInvalidHighlightAnimationFilterExposureFromValue];
		toValue = [NSNumber numberWithDouble:PetriBoardCellLayerInvalidHighlightAnimationFilterExposureToValue];
		animationDuration = PetriBoardCellLayerInvalidHighlightAnimationDuration;
	}
	[animation setFromValue:fromValue];
	[animation setToValue:toValue];
	[animation setDuration:animationDuration];
	
	// Make the animation autoreverse and repeat forever
	[animation setRepeatCount:HUGE_VALF];	// CAMediaTiming interprets this as "infinity"
	[animation setAutoreverses:YES];
	
	// Make the animation use "ease-in ease-out" timing
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	return animation;
}

#pragma mark -
#pragma mark Accessors

// FIXME: testing purposes only
- (void)setValue:(id)value
		  forKey:(NSString*)key
{
	// Check for the backgroundColor key, since we need to convert from a CIColor to a CGColor
	if ([key isEqualToString:@"backgroundColor"] && [value isKindOfClass:[CIColor class]])
	{
		CIColor* colorValue = (CIColor*)value;
		CGColorRef color = CGColorCreateGenericRGB([colorValue red], [colorValue green], [colorValue blue], 1.0);
		[self setBackgroundColor:color];
		CGColorRelease(color);
		return;
	}
	
	[super setValue:value
			 forKey:key];
}

@synthesize cell;

- (void)setHighlighted:(BOOL)highlightCell
{
	// If not highlighted, remove the highlight filter and animation
	if (highlighted && !highlightCell)
	{
		// Remove the animation
		[self removeAnimationForKey:PetriBoardCellLayerHighlightAnimationKey];
		
		// Remove the filter
		[self setFilters:nil];
	}
	// If highlighted, add the filter and animation
	else if (!highlighted && highlightCell)
	{
		// Add the filter
		[self setFilters:[NSArray arrayWithObject:highlightFilter]];
		
		// Add the animation
		[self addAnimation:highlightAnimation
					forKey:PetriBoardCellLayerHighlightAnimationKey];
	}
	
	highlighted = highlightCell;
}
@synthesize highlighted;

- (void)setHighlightsAsValid:(BOOL)valid
{
	// Check that the value is changing, and short-circuit if not
	if ((highlightsAsValid && valid) || (!highlightsAsValid && !valid))
		return;
	
	// If currently highlighted, temporarily un-highlight, to remove the filter and animation
	BOOL wasHighlighted = [self isHighlighted];
	if (wasHighlighted)
		[self setHighlighted:NO];
	
	// Create an animation to make the highlight "pulse"
	highlightAnimation = [self highlightAnimationForValidHighlight:valid];
	
	// If the layer was highlighted before this call, re-apply the filter and animation
	if (wasHighlighted)
		[self setHighlighted:YES];
	
	highlightsAsValid = valid;
}
@synthesize highlightsAsValid;

@end
