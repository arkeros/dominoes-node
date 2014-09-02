do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-board'
    ,
        tiles: []
        length: ->
            @tiles.length        
        leftmost: ->
            if @length() > 0
                @tiles[0].left
            else
                null     
        rightmost: ->
            if @length() > 0
                @tiles[0].right
            else
                null
        move:   (movement) -> 
            switch movement.side
                when 'left' then @tiles.unshift(movement.tile)
                when 'right' then @tiles.push(movement.tile)
    #            else throw 
    #            console.log "Board moved #{movement}"
        isPlayable: (tile) ->
            @leftmost() is tile.left or @leftmost() is tile.right or @rightmost() is tile.left or @rightmost() is tile.right

        fireLasers: ->
            @fire 'seed-element-lasers-success', 
                sound: 'Pew pew pew!'
