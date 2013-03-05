describe 'Lol.Alert', ->
  alert = null

  beforeEach ->
    alert = new Lol.Alert
      message: 'My Alert'

  it 'should be a function', ->
    expect(Lol.Alert).toEqual(jasmine.any Function)

  it 'should be able to calling Lol.Core methods', ->
    expect(alert.generateId).toBeDefined()
    expect(alert.debug).toBeDefined()
    expect(alert.destroy).toBeDefined()

  it 'should have a standard settings', ->
    expect(alert.debugPrefix).toEqual('Lol_Alert')
    expect(alert.namespace).toEqual('.alert')

  it 'should be able a methods', ->
    expect(alert.appendClose).toBeDefined()
    expect(alert.createAlert).toBeDefined()
    expect(alert.setContainer).toBeDefined()
    expect(alert.setInterval).toBeDefined()
    expect(alert.setEvents).toBeDefined()

  it 'should be able to create a close button', ->
    expect(alert.appendClose()).toEqual(alert.close)

  it 'should be able to create a alert object', ->
    expect(alert.createAlert()).toEqual(alert.alert)



#            createAlert: ->
#              @debug 'Create an object Alert'
#              @alert = jQuery '<div></div>'
#              @alert.addClass "alert #{@settings.objects.classes[@settings.type]}"
#              @alert.append @settings.message
#              @appendClose()
#              @alert.appendTo @container
#            destroy: ->
#              @debug 'Initializing the destroy method'
#              @alert.slideUp ->
#                jQuery(@).remove()
#              clearInterval(@interval) if @settings.autoRemove
#              super
#            setContainer: ->
#              @debug 'Setting a container object'
#              if not jQuery( @settings.objects.containerID )
#                throw  "Required container Alert: #{@settings.objects.containerID}"
#                return false
#              @container = jQuery @settings.objects.containerID
#            setInterval: ->
#              @debug 'Setting interval?',@settings.autoRemove, 'With delay:',@settings.delayRemove
#              _this = @
#              @interval = setInterval(->
#                _this.destroy()
#              , @settings.delayRemove) if @settings.autoRemove
#            setEvents: ->
#              @debug 'Setting all events'
#              _this = @
#              @close.bind "click#{@namespace}", ->
#                _this.debug 'Dispatch event clickon close button'
#                _this.destroy()
#
#          Lol.alert =
#          #  private:
#          #    dataset:
#
#            defaults:
#              autoRemove : true
#              type       : 'success' # Options success | error | warning | info
#              message    : null
#              delayRemove: 7000
#              objects :
#                containerID: '#alerts'
#                classes:
#                  container: 'alerts'
#                  success  : 'alert-success'
#                  error    : 'alert-error'
#                  warning  : 'alert-warning'
#                  info     : 'alert-info'
