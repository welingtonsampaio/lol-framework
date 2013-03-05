describe 'Lol.Lang', ->

  it 'should have a translation function', ->
    expect(Lol.t).toBeDefined()

  describe 'Lol.Lang.en-us', ->

    beforeEach ->
      Lol.I18n.language = 'en-us'

    it 'should have a standard for the common', ->
      expect(Lol.t 'search').toEqual('search')

    it 'should have a standard for the buttons', ->
      expect(Lol.t 'OK').toEqual('OK')
      expect(Lol.t 'CANCEL').toEqual('CANCEL')
      expect(Lol.t 'YES').toEqual('YES')
      expect(Lol.t 'NO').toEqual('NO')

    it 'should have a standard for the datatable', ->
      expect(Lol.t 'datatable_oAria_sSortAscending').toEqual(': activate to sort column ascending')
      expect(Lol.t 'datatable_oAria_sSortDescending').toEqual(': activate to sort column descending')
      expect(Lol.t 'datatable_oPaginate_sFirst').toEqual('First')
      expect(Lol.t 'datatable_oPaginate_sLast').toEqual('Last')
      expect(Lol.t 'datatable_oPaginate_sNext').toEqual('Next')
      expect(Lol.t 'datatable_oPaginate_sPrevious').toEqual('Previous')
      expect(Lol.t 'datatable_sEmptyTable').toEqual('No data available in table')
      expect(Lol.t 'datatable_sInfo').toEqual('Showing _START_ to _END_ of _TOTAL_ entries')
      expect(Lol.t 'datatable_sInfoEmpty').toEqual('Showing 0 to 0 of 0 entries')
      expect(Lol.t 'datatable_sInfoFiltered').toEqual('(filtered from _MAX_ total entries)')
      expect(Lol.t 'datatable_sInfoPostFix').toEqual('')
      expect(Lol.t 'datatable_sInfoThousands').toEqual(',')
      expect(Lol.t 'datatable_sLengthMenu').toEqual('Show _MENU_ entries')
      expect(Lol.t 'datatable_sLoadingRecords').toEqual('Loading...')
      expect(Lol.t 'datatable_sProcessing').toEqual('Processing...')
      expect(Lol.t 'datatable_sSearch').toEqual("<i class='icon-search'></i>")
      expect(Lol.t 'datatable_search').toEqual('search...')
      expect(Lol.t 'datatable_sUrl').toEqual('')
      expect(Lol.t 'datatable_sZeroRecords').toEqual('No matching records found')
      expect(Lol.t 'datatable_view').toEqual('view')
      expect(Lol.t 'datatable_edit').toEqual('edit')
      expect(Lol.t 'datatable_delete').toEqual('delete')
      expect(Lol.t 'datatable_confirm_delete').toEqual('Are you sure you want to delete this record?<br />This operation can not be undone.')
      expect(Lol.t 'datatable_confirm_delete_title').toEqual('Lol Framework')

    it 'should have a standard for the buttons', ->
      expect(Lol.t 'date_months_january').toEqual('January')
      expect(Lol.t 'date_months_february').toEqual('February')
      expect(Lol.t 'date_months_march').toEqual('March')
      expect(Lol.t 'date_months_april').toEqual('April')
      expect(Lol.t 'date_months_may').toEqual('May')
      expect(Lol.t 'date_months_june').toEqual('June')
      expect(Lol.t 'date_months_july').toEqual('July')
      expect(Lol.t 'date_months_august').toEqual('August')
      expect(Lol.t 'date_months_september').toEqual('September')
      expect(Lol.t 'date_months_october').toEqual('October')
      expect(Lol.t 'date_months_november').toEqual('November')
      expect(Lol.t 'date_months_december').toEqual('December')
      expect(Lol.t 'date_days_sunday').toEqual('Sunday')
      expect(Lol.t 'date_days_monday').toEqual('Monday')
      expect(Lol.t 'date_days_tuesday').toEqual('Tuesday')
      expect(Lol.t 'date_days_wednesday').toEqual('Wednesday')
      expect(Lol.t 'date_days_thursday').toEqual('Thursday')
      expect(Lol.t 'date_days_friday').toEqual('Friday')
      expect(Lol.t 'date_days_saturday').toEqual('Saturday')

  describe 'Lol.Lang.pt-br', ->

    beforeEach ->
      Lol.I18n.language = 'pt-br'

    it 'should have an identical alias', ->
      expect(Lol.i18n['pt-br']).toEqual(Lol.i18n['pt'])

    it 'should have a standard for the common', ->
      expect(Lol.t 'search').toEqual('pesquisa')

    it 'should have a standard for the buttons', ->
      expect(Lol.t 'OK').toEqual('OK')
      expect(Lol.t 'CANCEL').toEqual('CANCELAR')
      expect(Lol.t 'YES').toEqual('SIM')
      expect(Lol.t 'NO').toEqual('NÃO')

    it 'should have a standard for the datatable', ->
      expect(Lol.t 'datatable_oAria_sSortAscending').toEqual(": ativar para classificar coluna ascendente")
      expect(Lol.t 'datatable_oAria_sSortDescending').toEqual(": ativar para classificar coluna descendente")
      expect(Lol.t 'datatable_oPaginate_sFirst').toEqual("Primeiro")
      expect(Lol.t 'datatable_oPaginate_sLast').toEqual("Último")
      expect(Lol.t 'datatable_oPaginate_sNext').toEqual("Seguinte")
      expect(Lol.t 'datatable_oPaginate_sPrevious').toEqual("Anterior")
      expect(Lol.t 'datatable_sEmptyTable').toEqual("Não há dados disponíveis na tabela")
      expect(Lol.t 'datatable_sInfo').toEqual("Mostrando de _START_ até _END_ de _TOTAL_ registros")
      expect(Lol.t 'datatable_sInfoEmpty').toEqual("Mostrando de 0 até 0 de 0 registros")
      expect(Lol.t 'datatable_sInfoFiltered').toEqual("(filtrado de _MAX_ registros no total)")
      expect(Lol.t 'datatable_sInfoPostFix').toEqual("")
      expect(Lol.t 'datatable_sInfoThousands').toEqual(",")
      expect(Lol.t 'datatable_sLengthMenu').toEqual("Mostrar _MENU_ registros")
      expect(Lol.t 'datatable_sLoadingRecords').toEqual("Carregando...")
      expect(Lol.t 'datatable_sProcessing').toEqual("Processando...")
      expect(Lol.t 'datatable_sSearch').toEqual("<i class='icon-search'></i>")
      expect(Lol.t 'datatable_search').toEqual("buscar")
      expect(Lol.t 'datatable_sUrl').toEqual("")
      expect(Lol.t 'datatable_sZeroRecords').toEqual("Não foram encontrados resultados")
      expect(Lol.t 'datatable_view').toEqual('visualizar')
      expect(Lol.t 'datatable_edit').toEqual('editar')
      expect(Lol.t 'datatable_delete').toEqual('remover')
      expect(Lol.t 'datatable_confirm_delete').toEqual('Você tem certeza que deseja excluir este registro?<br />Esta operação não poderá ser desfeita.')
      expect(Lol.t 'datatable_confirm_delete_title').toEqual('Lol Framework')

    it 'should have a standard for the buttons', ->
      expect(Lol.t 'date_months_january').toEqual('Janeiro')
      expect(Lol.t 'date_months_february').toEqual('Fevereiro')
      expect(Lol.t 'date_months_march').toEqual('Março')
      expect(Lol.t 'date_months_april').toEqual('Abril')
      expect(Lol.t 'date_months_may').toEqual('Maio')
      expect(Lol.t 'date_months_june').toEqual('Junho')
      expect(Lol.t 'date_months_july').toEqual('Julho')
      expect(Lol.t 'date_months_august').toEqual('Agosto')
      expect(Lol.t 'date_months_september').toEqual('Setembro')
      expect(Lol.t 'date_months_october').toEqual('Outubro')
      expect(Lol.t 'date_months_november').toEqual('Novembro')
      expect(Lol.t 'date_months_december').toEqual('Dezembro')
      expect(Lol.t 'date_days_sunday').toEqual('Domingo')
      expect(Lol.t 'date_days_monday').toEqual('Segunda')
      expect(Lol.t 'date_days_tuesday').toEqual('Terça')
      expect(Lol.t 'date_days_wednesday').toEqual('Quarta')
      expect(Lol.t 'date_days_thursday').toEqual('Quinta')
      expect(Lol.t 'date_days_friday').toEqual('Sexta')
      expect(Lol.t 'date_days_saturday').toEqual('Sábado')

