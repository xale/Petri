//
//  PetriPlayerStatusLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayerStatusLayer.h"

#import "PetriPlayer+DisplayName.h"
#import "PetriItem.h"

#import "PetriItemStackLayer.h"

NSString* const PetriPlayerStatusLayerNicknameFontName =	@"Arial Rounded MT Bold";
#define PetriPlayerStatusLayerNicknameFontScale			0.20
#define PetriPlayerStatusLayerNicknamePositionScale		0.80
#define PetriPlayerStatusLayerNicknameFieldWidthScale	0.88

#define PetriPlayerStatusLayerSelectionBorderWidth	4.0

/*!
 Private methods on PetriPlayerStatusLayer
 */
@interface PetriPlayerStatusLayer(Private)

- (CATextLayer*)nameLayerForPlayer:(PetriPlayer*)displayedPlayer;

- (NSArray*)itemStacksForPlayer:(PetriPlayer*)displayedPlayer;

@end

@implementation PetriPlayerStatusLayer

- (id)initWithPlayer:(PetriPlayer*)displayedPlayer
			selected:(BOOL)initiallySelected
{
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Create a text layer for the player's name
	nameLayer = [self nameLayerForPlayer:displayedPlayer];
	[self addSublayer:nameLayer];
	
	// Create "stacks" of the player's items
	itemStacks = [self itemStacksForPlayer:displayedPlayer];
	for (CALayer* layer in itemStacks)
	{
		[self addSublayer:layer];
	}
	
	// Set the background color of the layer to the player's color
	NSColor* playerColor = [displayedPlayer color];
	CGColorRef color = CGColorCreateGenericRGB([playerColor redComponent], [playerColor greenComponent], [playerColor blueComponent], 1.0);
	[self setBackgroundColor:color];
	CGColorRelease(color);
	
	// Set the border color for when the player is selected
	[self setBorderColor:CGColorGetConstantColor(kCGColorWhite)];
	
	// If the layer is selected, draw the border
	if (initiallySelected)
		[self setBorderWidth:PetriPlayerStatusLayerSelectionBorderWidth];
	else
		[self setBorderWidth:0.0];
	
	// FIXME: bindings for items
	
	// Maintain a reference to the player
	player = displayedPlayer;
	
	return self;
}

+ (id)playerStatusLayerForPlayer:(PetriPlayer*)displayedPlayer
						selected:(BOOL)initiallySelected
{
	return [[self alloc] initWithPlayer:displayedPlayer
							   selected:initiallySelected];
}

#pragma mark -
#pragma mark Layout

- (CATextLayer*)nameLayerForPlayer:(PetriPlayer*)displayedPlayer
{
	CATextLayer* layer = [CATextLayer layer];
	[layer setString:[displayedPlayer displayName]];
	
	// Set the font to the Petri title font
	CTFontRef nicknameFont = CTFontCreateWithName((CFStringRef)PetriPlayerStatusLayerNicknameFontName, 0.0, NULL);
	[layer setFont:nicknameFont];
	CFRelease(nicknameFont);
	
	// Set the text color to white
	[layer setForegroundColor:CGColorGetConstantColor(kCGColorWhite)];
	
	// Configure the size and position of the layer
	[layer setTruncationMode:kCATruncationEnd];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidX
													relativeTo:@"superlayer"
													 attribute:kCAConstraintMidX]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
													relativeTo:@"superlayer"
													 attribute:kCAConstraintHeight
														 scale:PetriPlayerStatusLayerNicknamePositionScale
														offset:0.0]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
													relativeTo:@"superlayer"
													 attribute:kCAConstraintWidth
														 scale:PetriPlayerStatusLayerNicknameFieldWidthScale
														offset:0.0]];
	
	return layer;
}

#define PetriPlayerStatusLayerItemStackSublayerSizeScale		0.45
#define PetriPlayerStatusLayerItemStackSublayerPositionScale	0.1

- (NSArray*)itemStacksForPlayer:(PetriPlayer*)displayedPlayer
{
	// Create stacks of items for each type in the player's inventory
	NSArray* items = [[displayedPlayer items] allKeys];
	NSUInteger itemTypesCount = [items count];
	NSMutableArray* layers = [NSMutableArray arrayWithCapacity:itemTypesCount];
	for (NSUInteger itemTypeIndex = 0; itemTypeIndex < itemTypesCount; itemTypeIndex++)
	{
		// Get an item from the collection
		PetriItem* item = [items objectAtIndex:itemTypeIndex];
		
		// Create a "stack" of that type of item
		PetriItemStackLayer* stackLayer = [PetriItemStackLayer itemStackWithItem:item
																		   count:[[[displayedPlayer items] objectForKey:item] unsignedIntegerValue]];
		
		// Configure the stack's size and position
		[stackLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriPlayerStatusLayerItemStackSublayerSizeScale
																 offset:0.0]];
		[stackLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintHeight
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriPlayerStatusLayerItemStackSublayerSizeScale
																 offset:0.0]];
		[stackLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinY
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintHeight
																  scale:PetriPlayerStatusLayerItemStackSublayerPositionScale
																 offset:0.0]];
		// FIXME: DOES NOT SCALE
		[stackLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintWidth
																  scale:(PetriPlayerStatusLayerItemStackSublayerPositionScale * (itemTypeIndex + 1))
																 offset:0.0]];
		
		[layers addObject:stackLayer];
	}
	
	return layers;
}

- (void)layoutSublayers
{
	[nameLayer setFontSize:(CGRectGetHeight([self bounds]) * PetriPlayerStatusLayerNicknameFontScale)];
	
	[super layoutSublayers];
}

#pragma mark -
#pragma mark Accessors

- (void)highlightTopItemOfStack:(PetriItemStackLayer*)stack
{
	// Un-highlight the old stack, if necessary
	[[highlightedStack topItemLayer] setHighlighted:NO];
	
	// Highlight the top item of the new stack
	[[stack topItemLayer] setHighlighted:YES];
	
	highlightedStack = stack;
}

@synthesize player;

- (void)setSelected:(BOOL)playerSelected
{
	// Show or hide the border to indicate selection
	if (playerSelected)
		[self setBorderWidth:PetriPlayerStatusLayerSelectionBorderWidth];
	else
		[self setBorderWidth:0.0];
	
	selected = playerSelected;
}
@synthesize selected;

@end
