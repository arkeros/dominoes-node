do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-tile'
    ,
        left: 0
        right: 0
        value: 0

        ready: ->
            @value = @left + @right
            this

        reverse: ->
            @left = @right
            @right = @value - @left
            this

        contains: (number) ->
            number is @left or number is @right
