/*
 *  PetriCellType.h
 *  Petri
 *
 *  Created by Alex Heinz on 10/12/10.
 *  Copyright 2010 Alex Heinz, Paul Martin, and Alex Rozenshteyn. All rights reserved.
 *
 */

/*! \file PetriCellType.h
 \brief Header file containing the PetriCellType enum type.
*/

/*!
 \brief Enum type listing kinds of cells.
 
 The PetriCellType enum type lists the various types of cells that may appear on a Petri game board. The four types are: invalidCell, unoccupiedCell, headCell, bodyCell.
 */
typedef enum
{
	invalidCell,	/*!< Invalid cells: cells not on the board, and which may not be controlled by any player. */
	unoccupiedCell,	/*!< Unoccupied cells: empty cells that have either not been claimed by a player, or were relinquished when a body or head cell died. This is the only cell type upon which pieces may be placed. May also contain items to be picked up when a piece is placed. */
	headCell,		/*!< Head cells: the head cell of a player in the game. Must belong to a player. */
	bodyCell		/*!< Body cells: any non-head cell controlled by a player in the game. Must belong to a player. */
} PetriCellType;
