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

@type {FormValidate}
###
class Lol.FormValidate extends Lol.Core
# declaration of variables
  debugPrefix : 'Lol_FormValidate'
  namespace   : '.form_validate'
  # the methods
  constructor: (args={})->
    throw 'Required jQuery library' if jQuery == undefined
    @settings = jQuery.extend true, {}, Lol.form_validate.defaults, args
    @id = Lol.Utils.uniqid()
    Lol.Utils.addObject @
    @setForm()
    @setFormElements()
    @setEventForm()
    @setEventElements()
  elementValidate: (element)->
    console.log ["Element validate", element]
  formValidate: ->
    console.log "Form validate"
  setEventElements: ->
    @debug 'Configurando os eventos dos elementos do formulario'
    _this = @
    if @settings.eventValidators.focusout
      @elements.on "focusout#{@namespace}", ->
        _this.debug 'Event dispatch "focusout"', @
        _this.elementValidate(@)
    if @settings.eventValidators.focusin
      @elements.on "focusin#{@namespace}", ->
        _this.debug 'Event dispatch "focusin"', @
        _this.elementValidate(@)
    if @settings.eventValidators.change
      @elements.on "change#{@namespace}", ->
        _this.debug 'Event dispatch "change"', @
        _this.elementValidate(@)
    if @settings.eventValidators.keyup
      @elements.on "keyup#{@namespace}", ->
        _this.debug 'Event dispatch "keyup"', @
        _this.elementValidate(@)
  setEventForm: ->
    @debug 'Configurando os eventos do formulario'
    _this = @
    if @settings.validateOnSubmit
      @form.on "submit#{@namespace}", ->
        _return = _this.formValidate()
        return _return if _this.settings.runSubmitIsValid
        return false

  setForm: ->
    @debug 'Configurando o objeto de formulario'
    @form = $ @settings.target
  setFormElements: ->
    @debug 'Configurando os elemntos dos formularios'
    @elements = $ @settings.fieldSelectors, @form

Lol.FormValidate.addPatterns          = (pattern)->
Lol.FormValidate.addErrorMessage      = (errorMessage)->
Lol.FormValidate.addFunctionValidator = (functions)->

Lol.form_validate =
  private:
    ###
    taken from the plugin h5validate
    @link http://ericleads.com/h5validate
    HTML5-compatible validation pattern library that can be extended and/or overriden.
    ###
    patterns:
    # **TODO: password
      phone: /([\+][0-9]{1,3}([ \.\-])?)?([\(]{1}[0-9]{3}[\)])?([0-9A-Z \.\-]{1,32})((x|ext|extension)?[0-9]{1,4}?)/
      # Shamelessly lifted from Scott Gonzalez via the Bassistance Validation plugin http://projects.scottsplayground.com/email_address_validation/
      email: /((([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-zA-Z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?/
      # Shamelessly lifted from Scott Gonzalez via the Bassistance Validation plugin http://projects.scottsplayground.com/iri/
      url: /(https?|ftp):\/\/(((([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-zA-Z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-zA-Z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?/
      # Number, including positive, negative, and floating decimal. Credit: bassistance
      number: /-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?/
      # Date in ISO format. Credit: bassistance
      dateISO: /\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}/
      alpha: /[a-zA-Z]+/
      alphaNumeric: /\w+/
      integer: /\d+/
    ###
    Objeto contendo as validacoes por funcao
    ###
    functions : {}

  defaults:
    ###
    Selector ou DOMObject do elemento do formulario
    que receberá o as validacoes
    @type {String | DOMObject}
    ###
    target: null
    ###
    Classe adicionada quando o elemento estiver ativo
    @type {String}
    ###
    classActive: 'active-field'
    ###
    Classe adicionada apos a validacao do elemento e
    o mesmo for invalido
    @type {String}
    ###
    classError : 'error-field'
    ###
    Classe adicionada apos a validacao do elemento e
    o mesmo for valido
    @type {String}
    ###
    classValid : 'valid-field'
    ###
    Contem o seletor dos elementos a serem validados
    @type {String}
    ###
    fieldSelectors: ':input:visible:not(:button):not(:disabled):not(.novalidate):not(:submit)'
    ###
    Define em quais eventos os elementos do formulario
    deve ser validado
    @type {Object}
    ###
    eventValidators:
      ###
      Define se o validador deve ser testado no evento
      de focusout
      @type {Boolean}
      ###
      focusout: true
      ###
      Define se o validador deve ser testado no evento
      de focusin
      @type {Boolean}
      ###
      focusin: false
      ###
      Define se o validador deve ser testado no evento
      de change
      @type {Boolean}
      ###
      change: true
      ###
      Define se o validador deve ser testado no evento
      de keyup
      @type {Boolean}
      ###
      keyup: false
    ###
    Informa se o sistema deve enviar o formulario apos
    todas as validacoes forem validas
    @type {Boolean}
    ###
    runSubmitIsValid: true
    ###
    Define se deve ser colocado o foco no primeiro
    elemento do formulario que for invalido quando
    for disparado o evento de submit
    @type {Boolean}
    ###
    focusFirstInvalidElementOnSubmit: true
    ###
    When submitting, validate elements that haven't been validated yet?
    @type {Boolean}
    ###
    validateOnSubmit : true
    ###
    Define se deve ser usado o modo de debug
    @type {Boolean}
    ###
    debug : false
    ###
    Callback stubs
    @type {Boolean}
    ###
    callbacks:
      ###
      Funcao chamada toda vez que um campo
      é marcado como invalido
      @param {DOMObject} element
      @param {FormValidate} object
      @type {Function}
      ###
      invalidCallback : (element, object)->
      ###
      Funcao chamada toda vez que um campo
      é marcado como valido
      @param {DOMObject} element
      @param {FormValidate} object
      @type {Function}
      ###
      validCallback: (element, object)->

    fn:
      ###
      Mark field invalid
      @param {Object} params
      @type {Function}
      ###
      markInvalid: (params)->
        element = $ params.element
        _this		= params._this
        params.settings.unmark params
        if element.data "errorMessage"
          element.data 'title', element.data "errorMessage"
        else
          element.data 'title', params.settings.errorMessages[params.error]
        element.tooltip()
        element.addClass params.settings.classError
        params.settings.invalidCallback params
        element.bind "focusin#{_this.namespace}", ->
          $(@).tooltip 'show'
        element.bind "focusout#{_this.namespace}", ->
          $(@).tooltip 'hide'
      ###
      Mark field valid
      @param {Object} params
      @type {Function}
      ###
      markValid: (params)->
        element = $ params.element
        params.settings.unmark params
        element.addClass params.settings.classValid
        params.settings.validCallback params
      ###
      Desmarca e retira todos os
      eventos do elemento
      @param {Object} element
      @type {Function}
      ###
      unmark: (params)->
        element = $ params.element
        element.tooltip 'destroy'
        element.removeData 'title'
        element.removeData 'original-title'
        element.removeData 'errorMessage'
        element.removeClass params.settings.classError
        element.removeClass params.settings.classValid

# auto instaciavel
jQuery ->
  new Lol.FormValidate
    target: "form[data-toggle='form_validate']:not(.novalidate)"
    runSubmitIsValid: false
    debug: true

###
(($)->
  zaez =
    validate:
      defaults:

        defaultPrefixData : 'zvalidate'



  class ZValidate
  # declaration of variables
    debugMessage : 1
    debugPrefix: 'ZValidate'
    namespace	: '.zvalidate'
    # the methods
    constructor: (@form, @settings)->
      @patterns				= @settings.patterns
      @errorMessages	= @settings.errorMessages
      @functions			= @settings.functions
      @form.data 'zvalidate', @
      @setElements()
      @unsetAllEventsElements()
      @setClassConfiguration()
      @setAllEvents()
    debug: ->
      if @settings.debug and window.console
        message = ["#{@debugPrefix} - #{@debugMessage}"]
        message.push value for value in arguments
        console.log message
        @debugMessage += 1
    getDataParams: ->
      {
      object		: @
      settings	: @settings
      patterns	: @patterns
      errorMessages : @errorMessages
      functions	: @functions
      }
    getOptsOfElement: (element)->
      opts = new Object
      opts.validate = []
      for pattern of @patterns
        if element.data("#{@settings.defaultPrefixData}-#{pattern}")
          opts.validate.push pattern
      opts.validate.push 'required'  if element.attr 'required'
      opts.validate.push 'max'       if element.attr 'max'
      opts.validate.push 'min'       if element.attr 'min'
      opts.validate.push 'maxlength' if element.attr 'maxlength'
      opts.validate.push 'minlength' if element.attr 'minlength'
      opts.validate.push 'function'  if element.data "#{@settings.defaultPrefixData}-function"
      opts.max        = element.attr "max"        if element.attr "max"
      opts.min        = element.attr "min"        if element.attr "min"
      opts.maxlength	= element.attr "maxlength"  if element.attr "maxlength"
      opts.minlength	= element.attr "minlength"  if element.attr "minlength"
      opts.function		= element.data "#{@settings.defaultPrefixData}-function" if element.data "#{@settings.defaultPrefixData}-function"
      opts
    setAllEvents: ->
      @setAllEventsElements()
      @setFormEvent()
    setAllEventsElements: ->
      _this = @
      @elements.each (event)->
        _this.setElementEvent $(@)
    setClassConfiguration: ->
      settings = @settings
      @elements.bind "focusin#{@namespace}", ->
        $(@).addClass	settings.classActive
      @elements.bind "focusout#{@namespace}", ->
        $(@).removeClass	settings.classActive
    setElements: ->
      @elements = @form.find @settings.fieldSelectors
    setElementEvent: (element)->
      _this = @
      opts = @getOptsOfElement element
      element.bind("change#{_this.namespace}", ->
        _this.validate element, opts ) if @settings.change
      element.bind("focusout#{_this.namespace}", ->
        _this.validate element, opts ) if @settings.focusout
      element.bind("focusin#{_this.namespace}", ->
        _this.validate element, opts ) if @settings.focusin
      element.bind("keyup#{_this.namespace}", ->
        _this.validate element, opts ) if @settings.keyup
    setFormEvent: ->
      _this = @
      if @settings.validateOnSubmit
        settings = @settings
        @form.submit ->
          _this.debug 'Submit event triggered'
          if not $.zaezValidate.validateForm $(@)
            _this.debug 'This form is not valid'
            return false
          settings.runSubmitIsValid
    unsetAllEventsElements: ->
      _this = @
      @elements.each ->
        $(@).unbind _this.namespace
    validate: (element, opts)->
      @debug "Options of element:", element, opts
      element.data "errorMessage", false
      if opts.validate.length
        for item, k of opts.validate
          @debug "Test key validate: #{k}"
          r = @validateFunction element, opts					if k == 'function'
          r = @validateRequired element								if k == 'required'
          r = @validateMinMax   element, true,  opts	if k == 'max'
          r = @validateMinMax   element, false, opts	if k == 'min'
          r = @validateLength   element, true,  opts	if k == 'maxlength'
          r = @validateLength   element, false, opts	if k == 'minlength'
          r = @validatePattern  element, @patterns[k]	if @patterns.hasOwnProperty(k)
          if not r
            @settings.markInvalid
              element : element
              error: k
              _this: @
              settings: @settings
            return false
      @settings.markValid
        element : element
        settings: @settings
      true
    # Advised to use along with the function isEmpty
    validateRequired: (element)->
      @debug "Validate called on '#{element.val()}', for required.", "Required test: #{(element.val()!='')}, required"
      if typeof isEmpty == "function"
        not isEmpty element.val()
      else
        (element.val()!='')
    validateFunction: (element, opts)->
      value = element.val()
      func = opts.function
      @debug "Validate called on '#{value}' with function '#{func}'", "Return test: #{@functions[func] element, opts }, by Function: '#{func}'"
      @functions[func] element, opts
    validateLength: (element, type, opts)->
      value = element.val()
      if type
        @debug "Validate called on '#{value}', with maxlength '#{opts.maxlength}'", "Return test: #{(value.length <= opts.maxlength)}, with maxlength: '#{opts.maxlength}'"
        (value.length <= opts.maxlength)
      else
        @debug  "Validate called on '#{value}', with minlength '#{opts.minlength}'",  "Return test: #{(value.length >= opts.minlength)}, with minlength: '#{opts.minlength}'"
        (value.length >= opts.minlength)
    validateMinMax: (element, max, opts)->
      value = element.val()
      if max
        @debug "Validate called on '#{value}', with max '#{opts.max}'", "Return test: #{(Number(value) <= opts.max)}"
        (Number(value) <= opts.max)
      else
        @debug "Validate called on '#{value}', with min '#{opts.min}'", "Return test: #{(Number(value) >= opts.min)}"
        (Number(value) >= opts.min)
    validatePattern: (element, pattern)->
      re = new RegExp pattern
      value = element.val()
      @debug "Validate called on '#{value}' with regex '#{re}'.", "Regex test: #{re.test(value)}, Pattern: #{pattern}"
      re.test value

  $.zaezValidate =
    addPattern: (pattern)->
      for key of pattern
        zaez.validate.defaults.patterns[key] = pattern[key] if pattern.hasOwnProperty(key)
      zaez.validate.defaults.patterns
    addErrorMessage: (errorMessage)->
      for key of errorMessage
        zaez.validate.defaults.errorMessages[key] = errorMessage[key] if errorMessage.hasOwnProperty(key)
      zaez.validate.defaults.errorMessages
    addFunction: (func)->
      for key of func
        zaez.validate.defaults.functions[key] = func[key] if func.hasOwnProperty(key)
      zaez.validate.defaults.functions
    validateForm: (form)->
      _this = form.data 'zvalidate'
      _return = true
      _this.elements.each ->
        return if not _return
        element = $ @
        opts = _this.getOptsOfElement element
        if not _this.validate element, opts
          _return = false
          element.focus() if _this.settings.focusFirstInvalidElementOnSubmit
      _return
    is_to_test: (@element)->
      @element.data('zvalidate') != true


  # Só deve ser executado em um objeto DOM do tipo form
  $.fn.zvalidate = (settings)->
    settings = $.extend true, {}, zaez.validate.defaults, settings
    form = $ @
    new ZValidate form, settings
    true
)(jQuery)                     ###