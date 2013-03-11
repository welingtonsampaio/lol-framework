###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Modal.js
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
Create a new instance of Modal.

@classDescription This class creates a new Modal.
@param  {Object}      Receives configuration to create the Modal, @see Lol.modal.defaults
@return {Modal}       Returns a new Modal.
@type   {Object}
@example
  *-* JS Model *-*
  var modal = new Lol.Modal({
    buttons  : 'OK_CANCEL', # OK | OK_CANCEL | CANCEL | YES_NO
    content  : 'Body of Lol_Modal',
    close    : true,
    debug    : false,
    title    : 'My first Modal',
    buttonParams: {}, // @see Lol.Button
    callbacks: {
      initialize: function(object){},
      buttonClick: function(button, object){},
      afterDestroy: function(object){},
      beforeDestroy: function(object){}
    },
    containers: {
      buttons  : 'lol_modal_buttons',
      close    : 'lol_modal_close',
      content  : 'lol_modal_content',
      main     : 'lol_modal_main',
      overlay  : 'lol_modal_overlay',
      title    : 'lol_modal_title'
    },
    stylesheets: {
      buttons  : {},
      close    : {},
      content  : {},
      main     : {},
      overlay  : {},
      title    : {}
    },
    classes: {
      buttons  : 'lol-modal-buttons clearfix t-right',
      close    : 'lol-modal-close pull-right',
      content  : 'lol-modal-content clearfix',
      main     : 'lol-modal-main container afrelative',
      overlay  : 'lol-modal-overlay affix',
      title    : 'lol-modal-title clearfix'
    }
  });
###
class Lol.Modal extends Lol.Core
  # declaration of variables
  debugPrefix : 'Lol_Modal'
  namespace   : '.modal'
  # the methods
  constructor: (args={})->
    throw 'Required jQuery library' if jQuery == undefined
    @settings = jQuery.extend true, {}, Lol.modal.defaults, args
    @id = Lol.Utils.uniqid()
    Lol.Utils.addObject @
    @createContainers()
    @createButtons() if @settings.buttons
    @setContainersIds()
    @setContainersClasses()
    @setContainersStylesheets()
    @setTitleConfig()
    @setCloseConfig()
    @setContentConfig()
    @generate()
  createButtons: ->
    @settings.buttonParams.container     = @containerButtons
    @settings.buttonParams.buttons       = @settings.buttons
    @settings.buttonParams.use_button_el = false
    @buttons = new Lol.Button @settings.buttonParams
  createContainers: ->
    @debug 'Creating all containers elements of class'
    @containerMain     = jQuery '<div></div>'
    @containerTitle    = jQuery '<div></div>'
    @containerContent  = jQuery '<div></div>'
    @containerClose    = jQuery '<button></button>'
    @containerButtons  = jQuery '<div></div>' if @settings.buttons
  destroy: (hide=true)->
    if hide
      @containerMain.modal 'hide'
    else
      @debug 'Destroy all objects of modal'
      @containerTitle.remove()
      @containerContent.remove()
      @containerClose.remove()
      @containerMain.remove()
      super
  generate: ->
    @setEvents()
    @debug 'Generate modal and add to body'
    @containerMain.append      @containerTitle
    @containerMain.append      @containerContent
    @containerMain.append      @containerButtons if @settings.buttons
    @containerTitle.prepend    @containerClose   if @settings.close
    @containerMain.modal()
  setContainersClasses: ->
    @debug 'Setting the style class in all containers'
    @containerButtons.addClass  @settings.classes.buttons if @settings.buttons
    @containerClose.addClass    @settings.classes.close
    @containerContent.addClass  @settings.classes.content
    @containerMain.addClass     @settings.classes.main
    @containerTitle.addClass    @settings.classes.title
  setContainersIds: ->
    @debug 'Setting the ID in all containers'
    @containerButtons.attr  'id', @settings.containers.buttons
    @containerClose.attr    'id', @settings.containers.close
    @containerContent.attr  'id', @settings.containers.content
    @containerMain.attr     'id', @settings.containers.main
    @containerTitle.attr    'id', @settings.containers.title
  setContainersStylesheets: ->
    @debug 'Setting the custom style in all containers'
    @debug 'Setting the custom style to Close container, to: ', @settings.containers.close
    for key, value of @settings.containers.close
      @setStyle @containerClose, key, value
    @debug 'Setting the custom style to Content container, to: ', @settings.containers.content
    for key, value of @settings.containers.content
      @setStyle @containerContent, key, value
    @debug 'Setting the custom style to Main container, to: ', @settings.containers.main
    for key, value of @settings.containers.main
      @setStyle @containerMain, key, value
    @debug 'Setting the custom style to Overlay container, to: ', @settings.containers.overlay
    for key, value of @settings.containers.overlay
      @setStyle @containerOverlay, key, value
    @debug 'Setting the custom style to Title container, to: ', @settings.containers.title
    for key, value of @settings.containers.title
      @setStyle @containerTitle, key, value
  setEventButtons: ->
    _this = @
    @debug 'Reset events of all buttons'
    for button in @buttons
      button.setEvents()
      button.button.on "click#{@namespace}",{button:button}, (event)->
        _this.settings.callbacks.buttonClick event.data.button, _this
        false
  setEventClose: ->
    _this = @
    @containerMain.on "hidden#{@namespace}", ->
      _this.debug 'Dispath event close click'
      _this.destroy false
  setEvents: ->
    @unsetEvents()
    @setEventButtons() if @settings.buttons
    @setEventClose()
  setStyle: (element, style, value)-> element.css style, value
  setCloseConfig: ->
    @containerClose.attr 'data-dismiss', 'modal'
    @containerClose.attr 'aria-hidden',  'true'
    @containerClose.append '&times;'
  setTitleConfig: ->
    @containerTitle.append "<h3 id='myModalLabel'>#{@settings.title}</h3>"
  setContentConfig: ->
    @containerContent.append @settings.content
  unsetEvents: ->
    @debug "Remove all events, with namespace: '#{@namespace}'"
    @containerClose.off   @namespace
    @containerMain.off    @namespace
    @containerTitle.off   @namespace
    @containerContent.off @namespace

Lol.modal =
  defaults:
    # Informations and configurations
    buttons  : false # OK | OK_CANCEL | CANCEL | YES_NO
    content  : null
    close    : true
    debug    : false
    title    : null
    # button events
    buttonParams: {} # @see Lol.Button
    # Callbacks
    callbacks:
      initialize: (object)->
      buttonClick: (button, object)->
      afterDestroy: (object)->
      beforeDestroy: (object)->
    # containers
    containers:
      buttons  : 'lol_modal_buttons'
      close    : 'lol_modal_close'
      content  : 'lol_modal_content'
      main     : 'lol_modal_main'
      title    : 'lol_modal_title'
    # stylesheets
    stylesheets:
      buttons  : {}
      close    : {}
      content  : {}
      main     : {}
      title    : {}
    # classes
    classes:
      buttons  : 'modal-footer'
      close    : 'close'
      content  : 'modal-body'
      main     : 'modal hide fade'
      title    : 'modal-header'

