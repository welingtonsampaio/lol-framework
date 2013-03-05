###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Loader.js
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
Object loader

@param  {Object}     Receives configuration
@type   {Object}
###
Lol.Loader =
  ###
  Defines the hidden class
  @type {String}
  ###
  classHidden    : 'hidden'
  ###
  Defines the DOM id of container
  @type {String}
  ###
  containerId    : 'loader'
  ###
  Defines the class of DOMObject container
  @type {String}
  ###
  containerClass : ''
  ###
  Defines the DOM id object loader
  @type {String}
  ###
  loaderId       : 'loader_loader'
  ###
  Defines the class of object loader
  @type {String}
  ###
  loaderClass    : 'loader'
  ###
  DOM Loader object
  @type {DOMObject}
  ###
  object         : null
  ###
  Remove the class hidden to show loader
  ###
  show: ->
    @generateObject unless @object
    jQuery("##{@containerId}").removeClass @classHidden
  ###
  Add class hidden to remove Loader of browser
  ###
  remove: ->
    @generateObject unless @object
    jQuery("##{@containerId}").addClass @classHidden
  ###
  Generate Loader object
  ###
  generateObject: ->
    @object = jQuery("##{@containerId}") if jQuery("##{@containerId}")
    @object = jQuery '<div></div>'
    loader  = jQuery '<div></div>'
    @object.attr     'id', @containerId
    @object.addClass @containerClass
    loader.attr     'id', @loaderId
    loader.addClass @loaderClass
    loader.appendTo @object
    @object.appendTo jQuery('body')

