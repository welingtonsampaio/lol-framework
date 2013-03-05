describe 'Lol.Core', ->
  core = null

  beforeEach ->
    core = new Lol.Core()

  it 'should have standards settings', ->
    expect(core.id).toEqual(null)
    expect(core.debugIndex).toEqual(1)
    expect(core.debugPrefix).toEqual(null)

  it 'should be able to verify if there is a library jQuery', ->
    expect(core.verifyJQuery()).toEqual(true)

  it 'should generate its ID', ->
    id = core.id
    core.generateId()
    expect(core.id).not.toEqual(id)

  it 'should be able to create an unique ID', ->
    id = core.id
    core.generateId()
    expect(core.id).not.toEqual(id)

  it 'should be able to treat a object', ->
    core.generateId()
    expect(Lol.Utils.getObject core.id).toEqual(core)
    core.destroy()
    expect(Lol.Utils.getObject core.id).toEqual(null)

  it 'should be able to print messages on console', ->
    index = core.debugIndex
    core.debug()
    expect(core.debugIndex).not.toEqual(index)

