###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Alert.js
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
Create a new instance of Alert.

@classDescription This class creates a new Alert.
@param  {Object}     Receives configuration to create the Alert, @see Lol.alert.defaults
@return {Alert}       Returns a new Alert.
@type   {Object}
@example
  *-* Create manual alert *-*
  var lol_alert = new Lol.Alert({
    autoRemove : true,
    type       : 'success',
    message    : 'Success to create a new object LolAlert',
    delayRemove: 7000,
    objects : {
      containerID: '#alerts',
      classes: {
        container: 'alerts',
        success  : 'alert-success',
        error    : 'alert-error',
        warning  : 'alert-warning',
        info     : 'alert-info'
      }
    }
  });
###
class Lol.Alert extends Lol.Core
# declaration of variables
  debugPrefix : 'Lol_Alert'
  namespace   : '.alert'
  # the methods
  constructor: (args={})->
    return false unless @verifyJQuery()
    @settings = jQuery.extend true, {}, Lol.alert.defaults, args
    @generateId()
    return false unless @setContainer()
    @createAlert()
    @setEvents()
    @setInterval()
  appendClose: ->
    @debug 'Create and append close button to alert'
    @close = jQuery "<span></span>"
    @close.append "x"
    @close.appendTo @alert
  createAlert: ->
    @debug 'Create an object Alert'
    @alert = jQuery '<div></div>'
    @alert.addClass "alert #{@settings.objects.classes[@settings.type]}"
    @alert.append @settings.message
    @appendClose()
    @alert.appendTo @container
  destroy: ->
    @debug 'Initializing the destroy method'
    @alert.slideUp ->
      jQuery(@).remove()
    clearInterval(@interval) if @settings.autoRemove
    super
  setContainer: ->
    @debug 'Setting a container object'
    if not jQuery( @settings.objects.containerID )
      throw  "Required container Alert: #{@settings.objects.containerID}"
      return false
    @container = jQuery @settings.objects.containerID
  setInterval: ->
    @debug 'Setting interval?',@settings.autoRemove, 'With delay:',@settings.delayRemove
    _this = @
    @interval = setInterval(->
      _this.destroy()
    , @settings.delayRemove) if @settings.autoRemove
  setEvents: ->
    @debug 'Setting all events'
    _this = @
    @close.bind "click#{@namespace}", ->
      _this.debug 'Dispatch event clickon close button'
      _this.destroy()

Lol.alert =
#  private:
#    dataset:

  defaults:
    autoRemove : true
    type       : 'success' # Options success | error | warning | info
    message    : null
    delayRemove: 7000
    objects :
      containerID: '#alerts'
      classes:
        container: 'alerts'
        success  : 'alert-success'
        error    : 'alert-error'
        warning  : 'alert-warning'
        info     : 'alert-info'
