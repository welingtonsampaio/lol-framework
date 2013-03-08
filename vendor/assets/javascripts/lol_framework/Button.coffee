###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Button.js
@author      Welington Sampaio (http://welington.zaez.net/)
@contact     http://welington.zaez.net/site/contato

@copyright Copyright 2012 Welington Sampaio, all rights reserved.

This source file is free software, under the license MIT, available at:
http://lolframework.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://welington.zaez.net
###

###
Create a new instance of Button.

@classDescription This class creates a new Button.
@param  {Object}     Receives configuration to create the Button, @see Lol.button.defaults
@return {Button}       Returns a new Button.
@type   {Object}
###
class Lol.Button extends Lol.Core
  # Variables declaration
  debugPrefix	: 'Lol_Button'
  namespace		: '.button'
  # The methods
  constructor: (args={})->
    return false unless @verifyJQuery()
    @settings = jQuery.extend true, {}, Lol.button.defaults, args
    @generateId()
    @buttons = []
    @createButtons()
    return @buttons if @buttons.length
    @createButton()
    @addAttributes()
    @setEvents()
    @addToContainer()
  ###
  Adds attributes to the button
  ###
  addAttributes: ->
    @debug "Add attributes to button: ", @settings.atribute
    for key,value of @settings.atribute
      @button.attr key, value
  ###
  Adds attributes to the button
  ###
  addToContainer: ->
    @container = $ @settings.container
    if @buttons.length
      for btn in @buttons
        @container.append btn
    else
      @container.append @button
  ###
  Creates the buttons on block
  options: OK | CANCEL | YES | NO
  ###
  createButtons: ->
    throw 'Invalid button' if not @settings.buttons and not @settings.text
    if @settings.buttons
      @debug 'Creating buttons:', @settings.buttons
      text = new String @settings.buttons
      if text.indexOf('YES') isnt -1
        @buttons.push new Lol.Button
          text : 'YES'
          attribute: @settings.attributes.YES
          container: @settings.container
          class: @settings.classes.YES
          debug: @settings.debug
          callback:
            click: @settings.fn.YES_CLICK
      if text.indexOf('NO') isnt -1
        @buttons.push new Lol.Button
          text : 'NO'
          attribute: @settings.attributes.NO
          container: @settings.container
          class: @settings.classes.NO
          debug: @settings.debug
          callback:
            click: @settings.fn.NO_CLICK
      if text.indexOf('OK') isnt -1
        @buttons.push new Lol.Button
          text : 'OK'
          attribute: @settings.attributes.OK
          container: @settings.container
          class: @settings.classes.OK
          debug: @settings.debug
          callback:
            click: @settings.fn.OK_CLICK
      if text.indexOf('CANCEL') isnt -1
        @buttons.push new Lol.Button
          text : 'CANCEL'
          attribute: @settings.attributes.CANCEL
          container: @settings.container
          class: @settings.classes.CANCEL
          debug: @settings.debug
          callback:
            click: @settings.fn.CANCEL_CLICK
  ###
  Creates the button specified in the settings
  ###
  createButton: (text)->
    @debug 'Creating button: ', @settings.text
    @debug "Add class '#{@settings.class}' to current button"
    @button = $ '<a></a>'
    @button.html Lol.t(@settings.text)
    @button.addClass @settings.class
  ###
  Creates the button specified in the settings
  ###
  unsetEvents: ->
    @debug "Remove all events with namespace: '#{@namespace}'"
    @button.unbind @namespace
  ###
  Adds all events related to this button
  ###
  setEvents: ->
    @unsetEvents()
    @debug "Add click event with namespace: '#{@namespace}'"
    _this = @
    @button.bind("click#{@namespace}", (event)->
      _this.debug "Dispath click event, with return: ", _this.settings.return_handler
      r_callback = _this.settings.callback.click(event, _this)
      return r_callback if _this.settings.return_handler
      _this.settings.return_handler
    )

###
Contains the definitions of standards Lol.Button
@type {Object}
###
Lol.button =
  defaults:
    ###
    It contains attributes related
    to the button in question
    @type {Object}
    ###
    attribute     : {}
    ###
    String with the text referring to
    the block to create buttons
    @options YES | NO | OK | CANCEL
    @type {String}
    ###
    buttons       : null
    ###
    Contains CSS classes to add to the button
    @type {String}
    ###
    class         : ''
    ###
    Object or container where the button
    should be added
    @type {String or DOMObject}
    ###
    container     : 'body'
    ###
    Specifies whether the object should
    print debug messages
    @type {Boolean}
    ###
    debug         : false
    ###
    Specifies what should be the return of
    the event after shooting
    @type {Boolean}
    ###
    return_handler: false
    ###
    Enter the text within the button
    @type {String}
    ###
    text          : null
    ###
    Object that contains the attributes
    of the buttons on the block
    @type {Object}
    ###
    attributes:
      ###
      Attributes for the CANCEL button
      @type {Object}
      ###
      CANCEL : {}
      ###
      Attributes for the NO button
      @type {Object}
      ###
      NO     : {}
      ###
      Attributes for the OK button
      @type {Object}
      ###
      OK     : {}
      ###
      Attributes for the YES button
      @type {Object}
      ###
      YES    : {}
    ###
    Specifies the events for the button
    @type {Object}
    ###
    callback:
      ###
      Click event to the button
      @type {Function}
      ###
      click: ->
    ###
    Contains classes to add buttons on the block
    @type {Object}
    ###
    classes:
      ###
      Contains CSS classes to add to the OK button
      @type {String}
      ###
      OK    : 'btn'
      ###
      Contains CSS classes to add to the CANCEL button
      @type {String}
      ###
      CANCEL: 'btn btn-danger'
      ###
      Contains CSS classes to add to the YES button
      @type {String}
      ###
      YES   : 'btn'
      ###
      Contains CSS classes to add to the NO button
      @type {String}
      ###
      NO    : 'btn'
    ###
    Contains events to add buttons on the block
    @type {String}
    ###
    fn:
      ###
      Click event to the OK button
      @type {Function}
      ###
      OK_CLICK: ->
      ###
      Click event to the CANCEL button
      @type {Function}
      ###
      CANCEL_CLICK: ->
      ###
      Click event to the YES button
      @type {Function}
      ###
      YES_CLICK: ->
      ###
      Click event to the NO button
      @type {Function}
      ###
      NO_CLICK: ->