###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        FormValidate.js
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
Class for validation of forms
@example
  *-* Create manual FormValidate *-*

@type {FormValidate}
###
class Lol.Masked extends Lol.Core
# declaration of variables
  debugPrefix : 'Lol_Masked'
  namespace   : '.masked'
  # the methods
  constructor: (args={})->
    throw 'Required jQuery library' if jQuery == undefined
    @settings = jQuery.extend true, {}, Lol.masked.defaults, args
    @id = Lol.Utils.uniqid()
    Lol.Utils.addObject @
    @setVariables()
    @setEvents()
  applyPlaceholder: ->
    @debug "Aplicando a mascara caso o valor seja nulo"
    if Lol.Utils.isEmpty @target.val()
      @debug "Criando a mascara para forma humana"
      return @target.val( @getHumanMask() )
    false
  ###
  Funcao para a selecao de conteudo do input
  @param {Integer} begin
  @param {Integer} end
  @return {Mixed}
  ###
  caret: (begin, end)->
    npt = if @target.jquery && @target.length > 0 then @target[0] else input
    return unless typeof begin == 'number'
    return unless @target.is ':visible'
    end = if typeof end == 'number' then end else begin
    ++end if @settings.insertMode == true and begin == end
    if npt.setSelectionRange
      if end == begin
        npt.focus()
        npt.setSelectionRange begin, end
      else
        npt.select()
        npt.selectionStart = begin
        npt.selectionEnd =  if @android534 then begin else end
    else if npt.createTextRange
      range = npt.createTextRange()
      range.collapse  true
      range.moveEnd   'character', end
      range.moveStart 'character', begin
      range.select()
    npt.focus()
  changeCursorPosition: ->
    _this = @
    setTimeout( ->
      _this.caret(1,1)
    , 10)
  eventKeyBlur: (event)->
    @debug "Evento de blur disparado com o conteudo e mascara:",     @target.val(), @mask
    @removePlaceholder()
  eventKeyChange: (event)->
    @debug "Evento de change disparado com o conteudo e mascara:",   @target.val(), @mask
  eventKeyDown: (event)->
    @debug "Evento de keydown disparado com o conteudo e mascara:",  @target.val(), @mask
  eventKeyFocus: (event)->
    @debug "Evento de focus disparado com o conteudo e mascara:",    @target.val(), @mask
    @applyPlaceholder()
    @changeCursorPosition()
  eventKeyPress: (event)->
    @debug "Evento de keypress disparado com o conteudo e mascara:", @target.val(), @mask
  eventKeyUp: (event)->
    @debug "Evento de keyup disparado com o conteudo e mascara:",    @target.val(), @mask
  getHumanMask: ->
    _m = "#{@mask}"
    for key, value of @definitions
      _m = _m.replace(eval("/#{key}/g"), @settings.placeholder)
    _m
  multiplyChar: (count, char=" ")->
    _r = ""
    ++count
    while count -= 1
      _r = "#{_r}#{char}"
    _r
  getPosition: ->

  removePlaceholder: ->
    @debug "Removendo a mascara ou o excedente"
    return @target.val "" if @target.val() == @getHumanMask()
    false
  setEvents: ->
    @target.on "keyup#{@namespace}"   , $.proxy(@eventKeyUp    , @)
    @target.on "keypress#{@namespace}", $.proxy(@eventKeyPress , @)
    @target.on "keydown#{@namespace}" , $.proxy(@eventKeyDown  , @)
    @target.on "blur#{@namespace}"    , $.proxy(@eventKeyBlur  , @)
    @target.on "focus#{@namespace}"   , $.proxy(@eventKeyFocus , @)
    @target.on "change#{@namespace}"  , $.proxy(@eventKeyChange, @)
  setVariables: ->
    @debug "Configurando as variaveis e elementos da classe"
    @target = jQuery @settings.target
    @mask   = new String @target.data('mask')
    @atualV = 0
    @atualM = 0
    @definitions = Lol.masked.definitions
    @iphone     = navigator.userAgent.match(/iphone/i) != null
    @android    = navigator.userAgent.match(/android.*safari.*/i) != null
    @android534 = null
    if @android
      browser  = navigator.userAgent.match /safari.*/i
      version  = parseInt new RegExp(/[0-9]+/).exec(browser)
      @android = version <= 533
      @android534 = 533 < version <= 534

Lol.Masked.addDefinition = ->
Lol.masked =
  match_op: /(\[[^\[]*\])/g
  match_ma: /(\{[^\{]*\})/g
  definitions:
    "9": /[0-9]/
    "a": /[A-Za-z]/
    "@": /./
    "d": /(0|1|2|3)[0-9]/
    "m": /(0|1)[0-9]/
    "y": /[0-9]{2,2}/
    "Y": /[0-9]{4,4}/
    "h": /^#?[a-fA-F0-9]{6}/
  defCounts:
    "9": 1
    "a": 1
    "@": 1
    "d": 2
    "m": 2
    "y": 2
    "Y": 4
    "h": 6
  defaults:
    debug       : false
    insertMode  : true
    placeholder : "_"
    target      : null

jQuery ->
  $("[data-mask]").each ->
    new Lol.Masked
      debug : true
      target: $ @