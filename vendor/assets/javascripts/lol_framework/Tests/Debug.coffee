describe 'Lol.Debug', ->

  it 'should be an object', ->
    expect(Lol.Debug).toEqual(jasmine.any Object)

  it 'should have set standards', ->
    expect(Lol.Debug.paramsDefault.debug).toEqual(false)
    expect(Lol.Debug.paramsDefault.prefix).toEqual('Lol_Debug')
    expect(Lol.Debug.paramsDefault.object_id).toEqual('')
    expect(Lol.Debug.paramsDefault.index).toEqual(1)
    expect(Lol.Debug.paramsDefault.messages).toEqual([])

  it 'should have a function of impression', ->
    expect(typeof Lol.Debug.print).toEqual('function')
