do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-hand'
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

        dragStart: (event, detail, sender) ->
            scope.console.log detail.event.target

        fireLasers: ->
            @fire 'seed-element-lasers-success',
                sound: 'Pew pew pew!'
