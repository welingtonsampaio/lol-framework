describe 'Lol.Utils', ->

  it 'should be an object', ->
    expect(typeof Lol.Utils).toEqual('object')

  it 'should generate unique ids', ->
    expect(Lol.Utils.uniqid).toBeDefined()
    expect(Lol.Utils.uniqid()).not.toEqual(Lol.Utils.uniqid())

  it 'should be able to convert objects to string', ->
    expect(Lol.Utils.toString 123 ).toEqual(jasmine.any String)

  it 'should be able to treat the objects framework', ->
    obj =
      id: Lol.Utils.uniqid()
    expect(Lol.Utils.addObject obj ).toEqual(obj)
    expect(Lol.Utils.getObject obj.id ).toEqual(obj)
    expect(Lol.Utils._object_id.hasOwnProperty obj.id ).toEqual(true)
    expect(Lol.Utils.removeObject obj.id ).toEqual(null)

  it 'should redirect a function', ->
    expect(Lol.Utils.redirector).toBeDefined()
