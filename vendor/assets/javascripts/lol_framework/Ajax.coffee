###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Ajax.js
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
Create a new instance of Ajax.

@classDescription This class creates a new Ajax.
@param  {Object}     Receives configuration to create the Ajax, @see Lol.ajax.defaults
@return {Ajax}       Returns a new Ajax.
@type   {Object}
@example
  *-* Manual Configuration *-*
  var lol_ajax = new Lol.Ajax({
    autoExecute: true,
    useLoader  : true,
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    url        : 'http://www.google.com/',
    method     : 'GET',
    data       : {},
    dataType   : 'html',
    callbacks: {
      beforeSend: function(jqXHR, settings){},
      complete:   function(jqXHR, textStatus){},
      error:      function(jqXHR, textStatus, errorThrown){},
      success:    function(data, textStatus, jqXHR){}
    }
  });
###
class Lol.Ajax extends Lol.Core
  # declaration of variables
  debugPrefix : 'Lol_Ajax'
  namespace   : '.ajax'
  # the methods
  constructor: (args={})->
    return false unless @verifyJQuery()
    @settings = jQuery.extend true, {}, Lol.ajax.defaults, args
    @generateId()
    @execute() if @settings.autoExecute
  ###
  Get all the configuration data
  sent and configures sending
  @see http://api.jquery.com/jQuery.ajax/
  ###
  execute: ->
    @debug 'Executing the ajax requisition', @
    if not @settings.url or not @settings.callbacks.error or not @settings.callbacks.success
      throw 'Fields requireds not setting'
    _this = @
    Lol.Loader.show() if @settings.userLoader
    jQuery.ajax
      contentType: @settings.contentType
      url        : @settings.url
      type       : @settings.method
      data       : jQuery.param @settings.data
      dataType   : @settings.dataType
      beforeSend : _this.settings.callbacks.beforeSend
      complete   : _this.settings.callbacks.complete
      error      : (jqXHR, textStatus, errorThrown)->
        Lol.Loader.remove()
        _this.settings.callbacks.error(jqXHR, textStatus, errorThrown)
      success    : (data, textStatus, jqXHR)->
        Lol.Loader.remove()
        _this.settings.callbacks.success(data, textStatus, jqXHR)
  ###
  Set a new ContentType
  @see http://api.jquery.com/jQuery.ajax/
  @param  {String}
  @return {String}
  ###
  setContentType: (value)-> @settings.contentType = value
  ###
  Indicates whether to lock the screen with a loader
  @param  {Boolean}
  @return {Boolean}
  ###
  setUseLoader:   (value)-> @settings.useLoader   = value
  ###
  Set a new Url
  @see http://api.jquery.com/jQuery.ajax/
  @param  {String}
  @return {String}
  ###
  setUrl:         (value)-> @settings.url         = value
  ###
  Set a new Method
  @see http://api.jquery.com/jQuery.ajax/
  @param  {String}
  @return {String}
  ###
  setMethod:      (value)-> @settings.method      = value
  ###
  Set a new Data content
  @see http://api.jquery.com/jQuery.ajax/
  @param  {Object}
  @return {Object}
  ###
  setData:        (value)-> @settings.data        = value
  ###
  Set a new DataType
  @see http://api.jquery.com/jQuery.ajax/
  @param  {String}
  @return {String}
  ###
  setDataType:    (value)-> @settings.dataType    = value

###
Contains the definitions of standards Lol.Ajax
@type {Object}
###
Lol.ajax =
  defaults:
    ###
    Indicates whether the object should
    be executed at the end of its creation
    @type {Boolean}
    ###
    autoExecute: true
    ###
    Indicates whether the object should use
    a loader to stop, until the completion
    of the request
    @type {Boolean}
    ###
    useLoader  : true
    ###
    Indicates the content type of the request
    @type {String}
    ###
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
    ###
    Indicates the url of the request
    @type {String}
    ###
    url        : null
    ###
    Indicates the method of the request
    options : GET | POST | PUT | DELETE
    @type {String}
    ###
    method     : 'GET'
    ###
    Indicates the content of the request
    @type {Object}
    ###
    data       : {}
    ###
    Indicates the type of expected return
    after the completion of request
    @type {String}
    ###
    dataType   : 'json'
    ###
    Callbacks run through the requisition
    @see http://api.jquery.com/jQuery.ajax/
    ###
    callbacks:
      beforeSend: (jqXHR, settings)->
      complete: (jqXHR, textStatus)->
      error: (jqXHR, textStatus, errorThrown)->
      success: (data, textStatus, jqXHR)->

# if is rails application and using csrf-token
jQuery ->
  jQuery(document).ajaxSend (e, xhr, options)->
    token = $("meta[name='csrf-token']").attr "content"
    xhr.setRequestHeader("X-CSRF-Token", token)