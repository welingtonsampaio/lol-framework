###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Core.js
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
Create a new instance of Core.

@classDescription This class creates a new Core.
@return {Core}    Returns a new Core.
@type   {Object}
###
class Lol.Core
  ###
  ID of identification of object
  @type String      hash @see Lol.Utils.uniqid
  ###
  id          : null
  ###
  Atual Index of prints Debuging
  ###
  debugIndex  : 1
  ###
  Prefix debug message
  ###
  debugPrefix : null
  ###
  All settings
  ###
  settings:
    debug: false
  ###
  Checks if there is bibliotaco jQuery,
  returns false if there
  @exception If there jQuery
  @return Boolean
  ###
  verifyJQuery: ->
    if jQuery == undefined
      throw 'Required jQuery library'
      false
    else
      true
  ###
  Responsible for generating a unique
  id for the object in question
  @return String Id generated
  ###
  generateId: ->
    @id = Lol.Utils.uniqid()
    Lol.Utils.addObject @
  ###
  Destroy the object and cleaning of Utils
  @see Lol.Utils.removeObject()
  @return Boolean
  ###
  destroy: ->
    Lol.Utils.removeObject @id
  ###
  Print messages of debug
  @param (Mixin) ... All params are printed
  @return (Integer) Next index of message
  ###
  debug: ->
    Lol.Debug.print
      debug    : @settings.debug
      prefix   : @debugPrefix
      object_id: @id
      index    : @debugIndex
      messages : arguments
    @debugIndex += 1