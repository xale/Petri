//
//  PetriAspectRatioLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief A CALayer subclass that maintains an aspect ratio when resized.
 
 The PetriAspectRatioLayer class provides a convenient way to create a CALayer object that will maintain a proportional width and height, so that the layer will always display with the same aspect ratio.
 */
@interface PetriAspectRatioLayer : CALayer
{
	CGFloat aspectRatio;	/*!< The ratio of the layer's width to its height. */
}

/*!
 Initializes a PetriAspectRatioLayer with the specified aspect ratio.
 
 @param ratio The aspect ratio that the new layer should maintain.
 */
- (id)initWithAspectRatio:(CGFloat)ratio;

/*!
 Creates a new PetriAspectRatioLayer with the specified aspect ratio.
 
 @param ratio The aspect ratio that the new layer should maintain.
 */
+ (id)layerWithAspectRatio:(CGFloat)ratio;

/*!
 Initializes a PetriAspectRatioLayer with an aspect ratio of 1.0.
 */
- (id)initWithSquareAspectRatio;

/*!
 Creates a new PetriAspectRatioLayer with an aspect ratio of 1.0.
 */
+ (id)squareLayer;

/*!
 Override. Used to set the size of the layer.
 
 @param newBounds The desired bounds of the layer. The size will be adjusted such that \c width \c = \c (\c height \c * \c aspectRatio).
 */
- (void)setBounds:(CGRect)newBounds;

@property (readonly) CGFloat aspectRatio;

@end
