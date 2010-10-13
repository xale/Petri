* Player executing a "bite" action
    * Player satisfies requirements (above) to be able to bite
    * Player chooses to bite (clicks a button)
    * Player chooses which cell to bite (clicks the cell)
    * Game verifies that the bite is legal
    * Game provides visual feedback as to whether the bite succeeded.
    * Bitten cells are killed.
    * Board is updated, bite count is decreased
    * Player may bite again if preconditions are still satisfied; otherwise, he/she may place a piece

* Player placing a piece
    * Player clicks on piece
    * Player moves mouse to where he/she wants to drop it
    * Player optionally rotates the piece (spacebar)
    * Piece is displayed translucently where it would be placed, optionally differently if the move is illegal
    * If the move is legal, the piece is placed and captures (if any) occur; turn ends
    * If the move is illegal, an animation of the piece returning to the bank occurs and the player may attempt to make another move
