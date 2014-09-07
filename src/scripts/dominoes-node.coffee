do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-node',
        ply: 0
        computed:
            currentHand: 'hands[ply]'
            n_deck: '+28 - board.tiles.length - sumLength(hands)'

        created: ->
            @hands = []
            @board = {"tiles": [], "root": []}
            this

        move: (hand_index, movement) ->
            if hand_index isnt @ply
                return null  # TODO throw
            if movement.tile not in @currentHand
                return null  # TODO throw
            @$.board.move(movement)

        sumLength: (iterable) ->
            # TODO make abstract sum function like python
            iterable.reduce (n, item) ->
                    n + item.length
                , 0

        dragStart: (event, detail, sender) ->
            scope.console.log detail.event.relatedTarget
            that = this
            detail.avatar.innerHTML = ''
            if detail.event.target.tagName is 'DOMINOES-TILE'  # TODO otros checks
                tile = detail.event.target
                #clone tile
                clone = new DominoesTile()
                clone.left = tile.left
                clone.right = tile.right
                #add to avatar
                tile.style.display = 'none'  # NOTE not remove the original dragged element
                detail.avatar.appendChild clone
                #
                detail.drag = ->
                detail.drop = (dragInfo) ->
                    dropTarget = dragInfo.event.relatedTarget
                    tile = dragInfo.avatar.children[0]
                    scope.console.log dropTarget
                    if dropTarget.id is 'board'
                        dropTarget.move
                            side: 'left'
                            tile: [tile.left, tile.right]
                    else
                        handTile.display = '' for handTile in that.$.hand0.children


            false
