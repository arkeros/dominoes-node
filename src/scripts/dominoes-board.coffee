do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-board'
    ,
        #computed only fired when new object replace value. NO USE Array.shift() or similar
        computed:
            length: 'tiles.length'
            leftmost: 'tiles.length ? tiles[0][0] : null'
            rightmost: 'tiles.length ? tiles[-1][1] : null'
            rootIndex: 'index(tiles, root)'
        created: ->
            @tiles = []
            @root = []
        move: (movement) ->
            switch movement.side
                when 'left'
                    @tiles = [movement.tile].concat @tiles
                when 'right'
                    @tiles = @tiles.concat [movement.tile]
    #            else throw
    #            console.log "Board moved #{movement}"
        isPlayable: (tile) ->
            @leftmost is tile.left or @leftmost is tile.right or @rightmost is tile.left or @rightmost is tile.right
        index: (tiles, tile) ->
            # TODO function for equaling tiles...
            return index for index, match of tiles when match[0] is tile[0] and match[1] is tile[1]
            -1
        fireLasers: ->
            @fire 'seed-element-lasers-success',
                sound: 'Pew pew pew!'
