do (scope = window) ->
    'use strict'
    scope.Polymer 'dominoes-tile'
    ,
        left: 0
        right: 0
        computed:
            value: 'left + right'
            double: 'left == right'

        reverse: ->
            @left = @right
            @right = @value - @left
            this

        contains: (number) ->
            number is @left or number is @right
