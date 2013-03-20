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
  *-* Create manual alert *-*
  new Lol.FormValidate({
    target: "form",
    classActive: 'active-field',
    classError: 'error-field',
    classValid: 'valid-field',
    fieldSelectors: ':input:visible:not(:button):not(:disabled):not(.novalidate):not(:submit)',
    eventValidators: {
      focusout: true,
      focusin: false,
      change: true,
      keyup: false
    },
    runSubmitIsValid: true,
    focusFirstInvalidElementOnSubmit: true,
    validateOnSubmit: true,
    debug: false,
    callbacks: {
      invalidCallback: function(element, object) {},
      validCallback: function(element, object) {},
      invalidFormCallback: function(object) {},
      validFormCallback: function(object) {}
    },
    fn: {
      markInvalid: function(params) {},
      markValid: function(params) {},
      unmark: function(params) {}
    }
  });
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
    @patterns				= Lol.form_validate.private.patterns
    @errorMessages	= Lol.form_validate.private.errorMessages
    @functions			= Lol.form_validate.private.functions
    @setForm()
    @setFormElements()
    @form.data 'formValidate', @id
    @unsetAllEvents()
    @setEventForm()
    @setEventElements()
    @setClassConfiguration()
  ###
  Retrieve all validators element and checks sent
  @param {DOMObject} element
  @return {Boolean}
  ###
  elementValidate: (element)->
    @debug "Verify validators this element: ", element
    @validate element, @getOptsOfElement(element)
  ###
  Validates all elements of the form
  @return {Boolean}
  ###
  formValidate: ->
    @debug "Iniciando a verificacao de todos os elementos do formulario: ", @form
    _this = @
    _return = true
    @elements.each ->
      return if not _return
      element = $ @
      if not _this.elementValidate element
        _return = false
        element.focus() if _this.settings.focusFirstInvalidElementOnSubmit
    _return
  ###
  Parses the sent and creates an object
  containing all validators to examine
  this object
  @param {DOMObject} element
  @return {Object}
  ###
  getOptsOfElement: (element)->
    opts = new Object
    opts.validate = []
    for pattern of @patterns
      if element.data pattern
        opts.validate.push pattern
    opts.validate.push 'required'  if element.attr 'required'
    opts.validate.push 'max'       if element.attr 'max'
    opts.validate.push 'min'       if element.attr 'min'
    opts.validate.push 'maxlength' if element.attr 'maxlength'
    opts.validate.push 'minlength' if element.attr 'minlength'
    opts.validate.push 'function'  if element.data "function"
    opts.max        = element.attr "max"        if element.attr "max"
    opts.min        = element.attr "min"        if element.attr "min"
    opts.maxlength	= element.attr "maxlength"  if element.attr "maxlength"
    opts.minlength	= element.attr "minlength"  if element.attr "minlength"
    opts.function		= element.data "function"   if element.data "function"
    opts
  ###
  ###
  setClassConfiguration: ->
    settings = @settings
    @elements.on "focusin#{@namespace}", ->
      $(@).addClass	settings.classActive
    @elements.on "focusout#{@namespace}", ->
      $(@).removeClass	settings.classActive
  ###
  ###
  setEventElements: ->
    @debug 'Setting the events of the elements of the form'
    _this = @
    if @settings.eventValidators.focusout
      @elements.on "focusout#{@namespace}", ->
        _this.debug 'Event dispatch "focusout"', @
        _this.elementValidate($ @)
    if @settings.eventValidators.focusin
      @elements.on "focusin#{@namespace}", ->
        _this.debug 'Event dispatch "focusin"', @
        _this.elementValidate($ @)
    if @settings.eventValidators.change
      @elements.on "change#{@namespace}", ->
        _this.debug 'Event dispatch "change"', @
        _this.elementValidate($ @)
    if @settings.eventValidators.keyup
      @elements.on "keyup#{@namespace}", ->
        _this.debug 'Event dispatch "keyup"', @
        _this.elementValidate($ @)
  ###
  ###
  setEventForm: ->
    @debug 'Setting the events of the form'
    _this = @
    if @settings.validateOnSubmit
      @form.on "submit#{@namespace}", ->
        if not _this.formValidate()
          _this.debug "Form invalid"
          _this.settings.callbacks.invalidFormCallback _this
          return false
        _this.settings.callbacks.validFormCallback _this
        _this.settings.runSubmitIsValid
  ###
  ###
  setForm: ->
    @debug 'Setting the object form, with selector:', @settings.target
    @form = $ @settings.target
  ###
  ###
  setFormElements: ->
    @debug 'Configuring the elements of forms, with selector:', @settings.fieldSelectors
    @elements = $ @settings.fieldSelectors, @form
  ###
  ###
  unsetAllEvents: ->
    @form.off     @namespace
    @elements.off @namespace
  ###
  ###
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
          @settings.fn.markInvalid
            element : element
            error: k
            _this: @
            settings: @settings
          return false
    @settings.fn.markValid
      element : element
      settings: @settings
    true
  ###
  Advised to use along with the function isEmpty
  ###
  validateRequired: (element)->
    @debug "Validate called on '#{element.val()}', for required.", "Required test: #{(element.val()!='')}, required"
    not Lol.Utils.isEmpty element.val()
  ###
  ###
  validateFunction: (element, opts)->
    value = element.val()
    func = opts.function
    @debug "Validate called on '#{value}' with function '#{func}'", "Return test: #{@functions[func] element, opts }, by Function: '#{func}'"
    @functions[func] element, opts
  ###
  ###
  validateLength: (element, type, opts)->
    value = element.val()
    if type
      @debug "Validate called on '#{value}', with maxlength '#{opts.maxlength}'", "Return test: #{(value.length <= opts.maxlength)}, with maxlength: '#{opts.maxlength}'"
      ((value.length <= opts.maxlength) || (Lol.Utils.isEmpty(value) && element.attr('data-allow-empty')))
    else
      @debug  "Validate called on '#{value}', with minlength '#{opts.minlength}'",  "Return test: #{(value.length >= opts.minlength)}, with minlength: '#{opts.minlength}'"
      ((value.length >= opts.minlength) || (Lol.Utils.isEmpty(value) && element.attr('data-allow-empty')))
  ###

  ###
  validateMinMax: (element, max, opts)->
    value = element.val()
    if max
      @debug "Validate called on '#{value}', with max '#{opts.max}'", "Return test: #{(Number(value) <= opts.max)}"
      ((Number(value) <= opts.max) || (Lol.Utils.isEmpty(value) && element.attr('data-allow-empty')))
    else
      @debug "Validate called on '#{value}', with min '#{opts.min}'", "Return test: #{(Number(value) >= opts.min)}"
      ((Number(value) >= opts.min) || (Lol.Utils.isEmpty(value) && element.attr('data-allow-empty')))
  ###
  Validates the element through the pattern
  sent as validator using RegExp
  @param {DOMElement} element
  @param {RegExp} pattern
  @return {Boolean}
  ###
  validatePattern: (element, pattern)->
    re = new RegExp pattern
    value = element.val()
    @debug "Validate called on '#{value}' with regex '#{re}'.", "Regex test: #{re.test(value)}, Pattern: #{pattern}"
    (re.test(value) || (Lol.Utils.isEmpty(value) && element.attr('data-allow-empty')))

###
Adds a validator pattern of the existing
library, you can send as many patterns are
required for addition
@example
Lol.FormValidate.addPatterns({
  pattern_1: /^pattern_1(.)* /,
  pattern_2: /^pattern_2(.)* /
});
@param {Object}
@return {Object}
###
Lol.FormValidate.addPatterns          = (pattern)->
  for key of pattern
    Lol.form_validate.private.patterns[key] = pattern[key] if pattern.hasOwnProperty(key)
  Lol.form_validate.private.patterns
###
Adds the key traducao the name patterns,
can be sent as many names are required for
addition
@example
Lol.FormValidate.addErrorMessage({
  error_1: "name_equal_file_translate_1",
  error_2: "name_equal_file_translate_2"
});
@param {Object}
@return {Object}
###
Lol.FormValidate.addErrorMessage      = (errorMessage)->
  for key of errorMessage
    Lol.form_validate.private.errorMessages[key] = errorMessage[key] if errorMessage.hasOwnProperty(key)
  Lol.form_validate.private.errorMessages
###
Adds a function to validators, you can send
as many functions are necessary for addition
@example
Lol.FormValidate.addFunctionValidator({
  validate_test_1: function(element, opts){},
  validate_test_2: function(element, opts){}
});
@param {Object}
@return {Object}
###
Lol.FormValidate.addFunctionValidator = (functions)->
  for key of functions
    Lol.form_validate.private.functions[key] = functions[key] if functions.hasOwnProperty(key)
  Lol.form_validate.private.functions
###
Tests if the element is part of the
class sent FormValidate
@param {DOMElement}
@return {Boolean}
###
Lol.FormValidate.is_to_test           = (element)->
  $(element).data('formValidate') != true

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
    Contains references to the translation of messages
    @type {Object}
    ###
    errorMessages:
      required    : "form_validate_required"
      phone       : "form_validate_phone"
      email       : "form_validate_email"
      url         : "form_validate_url"
      alphaNumeric: "form_validate_alphaNumeric"
      alpha       : "form_validate_alpha"
      integer     : "form_validate_integer"
      max         : "form_validate_max"
      min         : "form_validate_min"
      maxlength   : "form_validate_maxlength"
      minlength   : "form_validate_minlength"
    ###
    Object containing the validations by function
    @type {Object}
    ###
    functions : {}

  defaults:
    ###
    DOMObject element that will receive the form validations
    @type {DOMObject}
    ###
    target: null
    ###
    Class added when the element is active
    @type {String}
    ###
    classActive: 'active-field'
    ###
    Class added after the validation of the element and
    the same is invalid
    @type {String}
    ###
    classError : 'error-field'
    ###
    Class added after the validation of the element and
    the same is valid
    @type {String}
    ###
    classValid : 'valid-field'
    ###
    Contains the selector element to be validated
    @type {String}
    ###
    fieldSelectors: ':input:visible:not(:button):not(:disabled):not(.novalidate):not(:submit)'
    ###
    Defines which events the elements of the form
    deve ser validado
    @type {Object}
    ###
    eventValidators:
      ###
      Defines if the validator should be tested in the event focusout
      @type {Boolean}
      ###
      focusout: true
      ###
      Defines if the validator should be tested in the event focusin
      @type {Boolean}
      ###
      focusin: false
      ###
      Defines if the validator should be tested in the event change
      @type {Boolean}
      ###
      change: true
      ###
      Defines if the validator should be tested in the event keyup
      @type {Boolean}
      ###
      keyup: false
    ###
    Reports whether the system should send the form after
    all validations are valid
    @type {Boolean}
    ###
    runSubmitIsValid: true
    ###
    Sets whether the focus should be placed on the first
    element of the form that is invalid when the event is
    triggered submit
    @type {Boolean}
    ###
    focusFirstInvalidElementOnSubmit: true
    ###
    When submitting, validate elements that haven't been
    validated yet?
    @type {Boolean}
    ###
    validateOnSubmit : true
    ###
    Sets whether to use the debug mode
    @type {Boolean}
    ###
    debug : false
    ###
    Callback stubs
    @type {Boolean}
    ###
    callbacks:
      ###
      Function called every time a field is marked as invalid
      @param {DOMObject} element
      @param {FormValidate} object
      @type {Function}
      ###
      invalidCallback : (element, object)->
      ###
      Function called every time a field is marked as valid
      @param {DOMObject} element
      @param {FormValidate} object
      @type {Function}
      ###
      validCallback: (element, object)->
      ###
      Function triggered whenever the form is submitted and all
      the fields are invalid
      @param {FormValidate} object
      @type {Function}
      ###
      invalidFormCallback: (object)->
        object.debug "invalid"
      ###
      Function triggered whenever the form is submitted and all
      the fields are valid
      @param {FormValidate} object
      @type {Function}
      ###
      validFormCallback: (object)->
        object.debug "valid"
    ###
    Object containing callback functions
    @type {Object}
    ###
    fn:
      ###
      Mark field invalid
      @param {Object} params
      @type {Function}
      ###
      markInvalid: (params)->
        element = $ params.element
        _this		= params._this
        errorMessage = element.data "errorMessage"
        params.settings.fn.unmark params
        if errorMessage
          element.data 'title', errorMessage
        else
          element.data 'title', Lol.t _this.errorMessages[params.error]
        element.tooltip()
        element.addClass params.settings.classError
        params.settings.callbacks.invalidCallback params
      ###
      Mark field valid
      @param {Object} params
      @type {Function}
      ###
      markValid: (params)->
        element = $ params.element
        params.settings.fn.unmark params
        element.addClass params.settings.classValid
        params.settings.callbacks.validCallback params
      ###
      Clears and removes all events of the element
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

# self instantiable
jQuery ->
  $("form[data-toggle='form_validate']:not(.novalidate)").each ->
    new Lol.FormValidate
      target: $ @
      runSubmitIsValid: false
      debug: true
