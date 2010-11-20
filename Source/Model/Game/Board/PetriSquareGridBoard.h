//
//  PetriSquareGridBoard.h
//  Petri
//
//  Created by Paul Martin on 10/11/20.
//  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PetriSquareGridBoard : PetriGridBoard
{
}

- (id)init;
- (id)initWithWidth:(NSInteger)boardWidth
			  Height:(NSInteger)boardHeight;

@end
