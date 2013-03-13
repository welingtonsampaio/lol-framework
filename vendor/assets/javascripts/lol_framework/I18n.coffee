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
Create a new instance of I18n.

@classDescription This class creates a new I18n.
@param  {Object}     Receives configuration to create the I18n
@return {I18n}       Returns a new I18n.
@type   {Object}
###
class Lol.I18n
# the methods
  default_language: "en-us"
  constructor: ->
    throw 'Required jQuery library' if jQuery == undefined
    Lol.I18n.language = if not navigator.language then @default_language else new String(navigator.language).toLowerCase()
    Lol.I18n.language = @default_language if Lol.i18n[Lol.I18n.language] == undefined
    @tDate()
  tDate: ->
    Date.monthNames =
      [
        Lol.t "date_months_january"
        Lol.t "date_months_february"
        Lol.t "date_months_march"
        Lol.t "date_months_april"
        Lol.t "date_months_may"
        Lol.t "date_months_june"
        Lol.t "date_months_july"
        Lol.t "date_months_august"
        Lol.t "date_months_september"
        Lol.t "date_months_october"
        Lol.t "date_months_november"
        Lol.t "date_months_december"
      ]
    Date.dayNames =
      [
        Lol.t "date_days_sunday"
        Lol.t "date_days_monday"
        Lol.t "date_days_tuesday"
        Lol.t "date_days_wednesday"
        Lol.t "date_days_thursday"
        Lol.t "date_days_friday"
        Lol.t "date_days_saturday"
      ]
  ###
  Method translation framework
  @param {String}
  ###
  @translate: (name)->
    return Lol.i18n[Lol.I18n.language][name] if Lol.i18n[Lol.I18n.language].hasOwnProperty(name)
    return name

###
Method translation framework
@see    Lol.I18n.translate
@param  {String}
@example
  *-* translating *-*
  var january = Lol.t('date_months_january'); // January
###
Lol.t = (name)->
  return Lol.I18n.translate(name)

##  Initializing the Lol.I18n
new Lol.I18n()