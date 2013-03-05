describe 'Lol.I18n', ->

  it 'should have a function translate', ->
    expect(Lol.I18n.translate).toEqual(jasmine.any Function)

  it 'should be an alias of the function of translation', ->
    expect(Lol.t 'search').toEqual(Lol.I18n.translate 'search')