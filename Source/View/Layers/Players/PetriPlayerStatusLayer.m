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

#define PetriPlayerStatusLayerSelectionBorderWidth	4.0

/*!
 Private methods on PetriPlayerStatusLayer
 */
@interface PetriPlayerStatusLayer(Private)

/*!
 Creates a CATextLayer configured to display the specified player's nickname, positioned in the top-left corner of its superlayer.
 */
- (CATextLayer*)nameLayerForPlayer:(PetriPlayer*)displayedPlayer;

/*!
 Creates a CATextLayer configured to display the specified player's controlled percentage of the board, positioned in the top-right corner of its superlayer.
 */
- (CATextLayer*)percentageLayerForPlayer:(PetriPlayer*)displayedPlayer;

/*!
 Returns a string of the format X%, where X is the specified player's controlled percentage of the board.
 */
- (NSString*)controlPercentageStringForPlayer:(PetriPlayer*)displayedPlayer;

/*!
 Creates an array of PetriItemStackLayers displaying the specified player's inventory, and arranged across the bottom of their superlayer.
 */
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
	
	percentageLayer = [self percentageLayerForPlayer:displayedPlayer];
	[self addSublayer:percentageLayer];
	
	// Create "stacks" of the player's items
	itemStacks = [self itemStacksForPlayer:displayedPlayer];
	for (CALayer* layer in itemStacks)
	{
		[self addSublayer:layer];
	}
	
	// Monitor the player's list of items and number and percentage of controlled cells
	[displayedPlayer addObserver:self
					  forKeyPath:@"items"
						 options:0
						 context:NULL];
	[displayedPlayer addObserver:self
					  forKeyPath:@"controlledCells"
						 options:0
						 context:NULL];
	[displayedPlayer addObserver:self
					  forKeyPath:@"controlPercentage"
						 options:0
						 context:NULL];
	
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

NSString* const PetriPlayerStatusLayerNicknameFontName =	@"Arial Rounded MT Bold";
#define PetriPlayerStatusLayerNicknameVerticalPositionScale	0.80
#define PetriPlayerStatusLayerNicknameFieldLeftEdgeScale	0.05
#define PetriPlayerStatusLayerNicknameFieldRightEdgeScale	0.75

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
	[layer setAlignmentMode:kCAAlignmentLeft];
	[layer setTruncationMode:kCATruncationEnd];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
													relativeTo:@"superlayer"
													 attribute:kCAConstraintHeight
														 scale:PetriPlayerStatusLayerNicknameVerticalPositionScale
														offset:0.0]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
													relativeTo:@"superlayer"
													 attribute:kCAConstraintWidth
														 scale:PetriPlayerStatusLayerNicknameFieldLeftEdgeScale
														offset:0.0]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxX
													relativeTo:@"superlayer"
													 attribute:kCAConstraintWidth
														 scale:PetriPlayerStatusLayerNicknameFieldRightEdgeScale
														offset:0.0]];
	
	return layer;
}

NSString* const PetriPlayerStatusLayerPercentageFontName =	@"Arial Rounded MT Bold";
#define PetriPlayerStatusLayerPercentageVerticalPositionScale	0.80
#define PetriPlayerStatusLayerPercentageFieldLeftEdgeScale		0.80
#define PetriPlayerStatusLayerPercentageFieldRightEdgeScale		0.95

- (CATextLayer*)percentageLayerForPlayer:(PetriPlayer*)displayedPlayer
{
	// Create a text layer
	CATextLayer* layer = [CATextLayer layer];
	[layer setString:[self controlPercentageStringForPlayer:displayedPlayer]];
	
	// Set the font to the Petri title font
	CTFontRef percentageFont = CTFontCreateWithName((CFStringRef)PetriPlayerStatusLayerPercentageFontName, 0.0, NULL);
	[layer setFont:percentageFont];
	CFRelease(percentageFont);
	
	// Set the text color to white
	[layer setForegroundColor:CGColorGetConstantColor(kCGColorWhite)];
	
	// Configure the size and position of the layer
	[layer setAlignmentMode:kCAAlignmentRight];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
													relativeTo:@"superlayer"
													 attribute:kCAConstraintHeight
														 scale:PetriPlayerStatusLayerPercentageVerticalPositionScale
														offset:0.0]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
													relativeTo:@"superlayer"
													 attribute:kCAConstraintWidth
														 scale:PetriPlayerStatusLayerPercentageFieldLeftEdgeScale
														offset:0.0]];
	[layer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMaxX
													relativeTo:@"superlayer"
													 attribute:kCAConstraintWidth
														 scale:PetriPlayerStatusLayerPercentageFieldRightEdgeScale
														offset:0.0]];
	
	return layer;
}

NSString* const PetriPlayerStatusLayerControlPercentageFormat =	@"%d%%";

- (NSString*)controlPercentageStringForPlayer:(PetriPlayer*)displayedPlayer
{
	return [NSString stringWithFormat:PetriPlayerStatusLayerControlPercentageFormat, [displayedPlayer controlPercentage]];
}

#define PetriPlayerStatusLayerItemStackSublayerSizeScale				0.40
#define PetriPlayerStatusLayerItemStackSublayerVerticalPositionScale	0.12
#define PetriPlayerStatusLayerItemStackSublayerHorizontalPositionScale	0.07

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
																  scale:PetriPlayerStatusLayerItemStackSublayerVerticalPositionScale
																 offset:0.0]];
		// FIXME: DOES NOT SCALE
		[stackLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMinX
															 relativeTo:@"superlayer"
															  attribute:kCAConstraintWidth
																  scale:(PetriPlayerStatusLayerItemStackSublayerHorizontalPositionScale * (itemTypeIndex + 1))
																 offset:0.0]];
		
		[layers addObject:stackLayer];
	}
	
	return layers;
}

#define PetriPlayerStatusLayerDeadPlayerOpacity 0.4

- (void)observeValueForKeyPath:(NSString*)keyPath
					  ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void*)context
{
	if ([keyPath isEqualToString:@"items"])
	{
		for (CALayer* layer in itemStacks)
		{
			[layer removeFromSuperlayer];
		}
		itemStacks = [self itemStacksForPlayer:object];
		for (CALayer* layer in itemStacks)
		{
			[self addSublayer:layer];
		}
	}
	else if ([keyPath isEqualToString:@"controlledCells"])
	{
		[self setOpacity:(([[self player] countOfControlledCells] == 0) ? PetriPlayerStatusLayerDeadPlayerOpacity : 1.0)];
	}
	else if ([keyPath isEqualToString:@"controlPercentage"])
	{
		[percentageLayer setString:[self controlPercentageStringForPlayer:[self player]]];
	}
}

#define PetriPlayerStatusLayerNicknameFontScale		0.18
#define PetriPlayerStatusLayerPercentageFontScale	0.12

- (void)layoutSublayers
{
	// Resize the font size of the text layers
	CGFloat height = CGRectGetHeight([self bounds]);
	[nameLayer setFontSize:(height * PetriPlayerStatusLayerNicknameFontScale)];
	[percentageLayer setFontSize:(height * PetriPlayerStatusLayerPercentageFontScale)];
	
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
