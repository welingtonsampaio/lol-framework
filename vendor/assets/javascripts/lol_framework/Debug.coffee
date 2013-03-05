###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Debug.js
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
Responsible for handling debug messages
@type   {Object}
###
Lol.Debug =
  ###
  Configuration default debug
  @type {Object}
  ###
  paramsDefault:
    debug    : false
    prefix   : 'Lol_Debug'
    object_id: ''
    index    : 1
    messages : []
  ###
  Paramenters traverses the past and
  prints everything in the browser console
  ###
  print: ( params )->
    params = $.extend true, {}, @paramsDefault, params
    if (params.debug or Lol.debug) and window.console
      message = ["#{params.prefix} #{params.object_id} - #{params.index}"]
      message.push params.messages[value] for value of params.messages
      console.log message
