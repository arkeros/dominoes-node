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

        dragStart: (event, detail, sender) ->
            if detail.event.target.tagName is 'DOMINOES-TILE'
                tile = detail.event.target
                # TODO otros checks
                # NOTE not remove the original dragged element
                scope.console.log tile
                detail.avatar.appendChild tile.cloneNode true
                detail.avatar.style.cssText = 'border: 3px solid pink; width: 32px; height: 32px; border-radius: 32px; background-color: whitesmoke'
                detail.drag = ->
                detail.drop = ->
            false
