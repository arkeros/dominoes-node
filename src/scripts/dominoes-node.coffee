do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-node',
        ply: 0
        n_deck: 28

        currentHand: ->
            @hands[@ply]
            
        created: ->
            @hands = []
            @board = {"tiles": [], "root": []}
            this
            
        ready: ->
            @n_deck  = 28
            @n_deck -= @board.tiles.length
            @n_deck -= _.reduce @hands,
                (hand, n) -> n + hand.length,
                0

        move: (hand_index, movement) ->
            if hand_index isnt @ply
                return null  # TODO throw
            if not _.contains @currentHand(), movement.tile
                return null  # TODO throw
            @board.move(movement)

        toggleFullScreen: ->
            if screenfull.enabled
                screenfull.toggle()
            this
            