//
//  PetriPlayerStatusLayer.m
//  Petri
//
//  Created by Alex Heinz on 12/10/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import "PetriPlayerStatusLayer.h"

#import "PetriPlayer+DisplayName.h"

NSString* const PetriPlayerStatusLayerNicknameFontName =	@"Arial Rounded MT Bold";
#define PetriPlayerStatusLayerNicknameFontScale			0.20
#define PetriPlayerStatusLayerNicknamePositionScale		0.80
#define PetriPlayerStatusLayerNicknameFieldWidthScale	0.88

#define PetriPlayerStatusLayerSelectionBorderWidth	4.0

@implementation PetriPlayerStatusLayer

- (id)initWithPlayer:(PetriPlayer*)displayedPlayer
			selected:(BOOL)initiallySelected
{
	if (![super init])
		return nil;
	
	// Create a layout manager
	[self setLayoutManager:[CAConstraintLayoutManager layoutManager]];
	
	// Get the player's name
	NSString* playerName = [displayedPlayer displayName];
	
	// Create a text layer for the player's name
	nameLayer = [CATextLayer layer];
	[nameLayer setString:playerName];
	
	// Set the font to the Petri title font
	CTFontRef nicknameFont = CTFontCreateWithName((CFStringRef)PetriPlayerStatusLayerNicknameFontName, 0.0, NULL);
	[nameLayer setFont:nicknameFont];
	CFRelease(nicknameFont);
	
	// Set the text color to white
	[nameLayer setForegroundColor:CGColorGetConstantColor(kCGColorWhite)];
	
	// Configure the size and position of the layer
	[nameLayer setTruncationMode:kCATruncationEnd];
	[nameLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidX
														relativeTo:@"superlayer"
														 attribute:kCAConstraintMidX]];
	[nameLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintMidY
														relativeTo:@"superlayer"
														 attribute:kCAConstraintHeight
															 scale:PetriPlayerStatusLayerNicknamePositionScale
															offset:0.0]];
	[nameLayer addConstraint:[CAConstraint constraintWithAttribute:kCAConstraintWidth
														relativeTo:@"superlayer"
														 attribute:kCAConstraintWidth
															 scale:PetriPlayerStatusLayerNicknameFieldWidthScale
															offset:0.0]];
	[self addSublayer:nameLayer];
	
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
	
	// FIXME: bindings
	
	// Maintain a reference to the player
	player = displayedPlayer;
	
	return self;
}



- (void)setBounds:(CGRect)newBounds
{
	[super setBounds:newBounds];
	
	[nameLayer setFontSize:(newBounds.size.height * PetriPlayerStatusLayerNicknameFontScale)];
}

+ (id)playerStatusLayerForPlayer:(PetriPlayer*)displayedPlayer
						selected:(BOOL)initiallySelected
{
	return [[self alloc] initWithPlayer:displayedPlayer
							   selected:initiallySelected];
}

#pragma mark -
#pragma mark Accessors

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
