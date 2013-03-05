describe 'Requirements framework', ->

  it 'should have a modification of the Date object', ->
    expect(Date.parseDate).toBeDefined()

  it 'should have the jquery library', ->
    expect(jQuery).toBeDefined()

  it 'should have the datatable jquery plugin', ->
    expect(jQuery.fn.dataTable).toBeDefined()

  it 'should have the browser mobile jquery plugin', ->
    expect(jQuery.browser.mobile).toBeDefined()
