###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Model.js
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
Create a new instance of Model.

@classDescription This class creates a new Model.
@param  {Object}      Receives configuration to create the Model, @see Lol.model.defaults
@return {Model}       Returns a new Model.
@type   {Object}
###
class Lol.Model extends Lol.Core
  # declaration of variables
  id          : null
  debugIndex  : 1
  debugPrefix : 'Lol_Model'
  namespace   : '.model'
  # the methods
  constructor: (args={})->
    return false unless @verifyJQuery()
    @settings = jQuery.extend true, {}, Lol.model.defaults, args
    @generateId()


Lol.model =
  defaults :
    ###
    Defines whether the class should print
    debug messages
    ###
    debug   : true
    ###
    Name of table on ralational database or
    name of module to rest applications
    @type String
    ###
    name    : null
    ###
    Fields of relational model
    @type object
    @example
        fields : {
          {name: "id"       , type: 'integer' , hide: true , dateFormat: null},
          {name: "fullname" , type: 'string'  , hide: false, dateFormat: null},
          {name: "password" , type: 'password', hide: false, dateFormat: null},
          {name: "create_at", type: 'date'    , hide: false, dataFormat: 'Y-m-d H:i:s'}
        }
    ###
    fields  : {}
    ###
    Specifies whether the class will use
    the rest of the standard application
    ###
    useRest : true