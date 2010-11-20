//
//  PetriSquareLayer.h
//  Petri
//
//  Created by Alex Heinz on 11/20/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

/*!
 \brief A CALayer subclass that maintains a square aspect ratio when resized.
 
 The PetriSquareLayer class provides a convenient way to create a CALayer object that will maintain equal width and height, so that the layer will always display as square.
 */
@interface PetriSquareLayer : CALayer

/*!
 Override. Used to set the size of the layer.
 
 @param newBounds The desired bounds of the layer. The the new \c width and \c height of the layer will both be equal to \c MIN(\c newBounds.size.width, \c newBounds.size.height)
 */
- (void)setBounds:(CGRect)newBounds;

@end
