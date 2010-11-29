//
//  PetriPiece.h
//  Petri
//
//  Created by Alexander Rozenshteyn on 11/29/10.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 The PetriPiece protocol describes an interface for collections of cells that can be placed on a PetriBoard during a players turn, to acquire territory and attempt captures; the placement of pieces is the primary way in which gameplay proceeds. Since a given board's implementation can radically change the way in which its associated pieces behave, the interface itself is quite sparse, defining only methods that are common to most imaginable pieces, and pertain primarily to the requirement that the user be able to rotate the piece before it is placed on the board.
 */
@protocol PetriPiece <NSObject, NSCopying>

/*!
 Default "copy constructor." Initializes a PetriPiece using data from the specified piece, after rotating the piece a specified number of times.
 \note The new piece's \c orientation will be zero, regardless of the value of \c numRotations.
 @param piece The PetriPiece to copy.
 @param numRotations The number of times to rotate the copied piece before copying it.
 */
- (id)initWithPiece:(id<PetriPiece>)piece
		  rotations:(NSUInteger)numRotations;

/*!
 Returns the current orientation of the piece; updated by calls to \c -rotate
 */
- (NSUInteger)orientation;

/*!
 Returns the number of different orientations this piece type supports.
 Individual pieces might have fewer unique orientations, but any piece of this type is guaranteed return to its initial orientation if rotated this many times.
 */
+ (NSUInteger)orientationsCount;

/*!
 Rotates the piece, and updates the value of \c orientation
 */
- (void)rotate;

@end
