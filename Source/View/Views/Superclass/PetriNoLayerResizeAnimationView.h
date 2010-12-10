//
//  PetriNoLayerResizeAnimationView.h
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief An NSView subclass that does not animate hosted sublayers when the view is resized.
 
 This NSView subclass is intended to be used as a CALayer layer-hosting view which starts and stops CATransactions when the view is resized, for the purposes of disabling CALayer animations while the resize is in progress. It adds no new methods, but overrides -setFrame:.
 */
@interface PetriNoLayerResizeAnimationView : NSView

/*!
 Override. Sets the new frame of the view, wrapping the resize in a CATransaction that disables CALayer resize/move animations.
 
 @param frameRect The new frame for the view.
 */
- (void)setFrame:(NSRect)frameRect;

@end
