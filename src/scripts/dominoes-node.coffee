do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-node',
        hands: []
        board: []
        ply: 0
        n_deck: 28

        currentHand: ->
            @hands[@ply]

        ready: ->
            @n_deck  = 28
            @n_deck -= _.size board
            @n_deck -= _.reduce @hands,
                (hand, n) -> n + hand.length,
                0

        move: (hand_index, movement) ->
            if hand_index isnt @ply
                null  # TODO throw
            if not _.contains @currentHand(), movement.tile
                null  # TODO throw
            @board.move(movement)

        toggleFullScreen: ->
            if screenfull.enabled
                screenfull.toggle()
            this
            