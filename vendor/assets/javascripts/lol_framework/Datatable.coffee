###
@summary     Lol Framework
@description Framework of RIAs applications
@version     1.0.0
@file        Datatable.js
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
Create a new instance of Datatable.

@classDescription This class creates a new Datatable.
@param  {Object}      Receives configuration to create the Datatable, @see Lol.datatable.defaults
@return {Datatable}   Returns a new Datatable.
@type   {Object}
@example
  *-* Auto configuration *-*
  <table id="lol-datatable" data-lol-datatable="true">
    <thead>
      <tr>
        <th>ID</th>
        <th>First Name</th>
        <th>Last Name</th>
      </tr>
    </thead>
    <tbody>
      <tr
        data-datatable-link="http://welington.zaez.net/"
        data-datatable-edit-link="#edit_my_page_ws"
        data-datatable-view-link="#view_my_page_ws"
        data-datatable-delete-link="#delete_my_page_ws">
        <td>1</td>
        <td>Welington</td>
        <td>Sampaio</td>
      </tr>
      <tr
        data-datatable-link="http://fabricio.zaez.net/"
        data-datatable-edit-link="#edit_my_page_fm"
        data-datatable-view-link="#view_my_page_fm"
        data-datatable-delete-link="#delete_my_page_fm">
        <td>2</td>
        <td>Fabricio</td>
        <td>Monte</td>
      </tr>
    </tbody>
  </table>
  *-* Setting manually configuration *-*
  var datatable = new Lol.Datatable({
    debug:         false,
    selectable:    true,
    target:        null,
    delayDblclick: 0,
    classes: {
      activeRow: 'active_row'
    },
    contextMenu: {
      "delete": function(row, object) {
        //see documentation
      },
      edit:     function(row, object) {
        //see documentation
      },
      view:     function(row, object) {
        //see documentation
      },
      iconView:   'icon-eye-open',
      iconEdit:   ' icon-edit',
      iconDelete: 'icon-remove',
      useIcons:   true,
      model: null
    },
    configuration: {
      aaSortingFixed: null,
      aoColumnDefs: null,
      aoColumns: null,
      asStripeClasses: null,
      bAutoWidth: true,
      bDeferRender: false,
      bDestroy: false,
      bFilter: false,
      bInfo: false,
      bJQueryUI: false,
      bLengthChange: false,
      bPaginate: false,
      bProcessing: false,
      bRetrieve: false,
      bScrollAutoCss: true,
      bScrollCollapse: false,
      bScrollInfinite: false,
      bServerSide: false,
      bSort: true,
      bSortCellsTop: false,
      bSortClasses: true,
      bStateSave: false,
      iCookieDuration: 7200,
      iDeferLoading: null,
      iDisplayLength: 20,
      iDisplayStart: 0,
      iScrollLoadGap: 100,
      iTabIndex: 0,
      sAjaxDataProp: "aaData",
      sAjaxSource: null,
      sCookiePrefix: "SpryMedia_DataTables_",
      sDom: "lfrtip",
      sPaginationType: "two_button",
      sScrollX: "",
      sScrollXInner: "",
      sScrollY: "",
      sServerMethod: "GET"
		}
  });
###
class Lol.Datatable extends Lol.Core
  # declaration of variables
  debugPrefix : 'Lol_Datatable'
  namespace   : '.datatable'
  table       : null
  # the methods
  constructor: (args={})->
    throw 'Required jQuery library' if jQuery == undefined
    @settings = jQuery.extend true, {}, Lol.datatable.defaults, args
    @id = Lol.Utils.uniqid()
    Lol.Utils.addObject @
    @dataset = Lol.datatable.private.dataset
    @setTable()
    @setConfigTable()
    @setModel()
    @setTranslation()
    @setAjax()
    @generate()
    @setEvents()
    @
  createMenuContext: (row, event)->
    if row.data(@dataset.deleteLink) or row.data(@dataset.editLink) or row.data(@dataset.viewLink)
      _this = @
      context = jQuery "<div class='dropdown context-menu' id='context-menu-#{@id}'></div>"
      context.css
        left : event.pageX - 15
        top  : event.pageY - 15
      context.bind
        mouseleave: (event)->
          jQuery(@).stop().delay(_this.settings.delayDblclick).animate {opacity: 0}, ->
            jQuery(@).remove()
        mouseenter: (event)->
          jQuery(@).stop(true).animate {opacity: 1}
      ul = jQuery '<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">'
      if ( row.data(@dataset.viewLink) )
        view = jQuery "<li><a tabindex='-1' href='#{row.data(@dataset.viewLink)}'>#{Lol.t('datatable_view')}</a></li>"
        jQuery("<i class='#{@settings.contextMenu.iconView}'></i>").prependTo view.find('a') if @settings.contextMenu.useIcons
        view.bind
          click: ->
            _this.settings.contextMenu.view row, _this
        view.appendTo ul
      if ( row.data(@dataset.editLink) )
        edit = jQuery "<li><a tabindex='-1' href='#{row.data(@dataset.editLink)}'>#{Lol.t('datatable_edit')}</a></li>"
        jQuery("<i class='#{@settings.contextMenu.iconEdit}'></i>").prependTo edit.find('a') if @settings.contextMenu.useIcons
        edit.bind
          click: ->
            _this.debug 'aki'
            _this.settings.contextMenu.edit row, _this
        edit.appendTo ul
      if ( row.data(@dataset.deleteLink) )
        remove = jQuery "<li><a tabindex='-1' href='#{row.data(@dataset.deleteLink)}'>#{Lol.t('datatable_delete')}</a></li>"
        jQuery("<i class='#{@settings.contextMenu.iconDelete}'></i>").prependTo remove.find('a') if @settings.contextMenu.useIcons
        remove.bind
          click: ->
            _this.settings.contextMenu.delete row, _this
        remove.appendTo ul
      ul.appendTo context
      context.appendTo 'body'
  generate: ->
    @table.dataTable @settings.configuration
    jQuery('.dataTables_filter input').attr('placeholder', Lol.t('datatable_search'))
    $("<em class='arrow'></em>").appendTo @table.find('th')
  getDt: ->
    @table.dataTable()
  goLink: (row)->
    link = jQuery(row).data(@dataset.link)
    Lol.Utils.redirector link if link
  isRowActive: (row)->
    row.hasClass @settings.classes.activeRow
  setActiveRow: (row)->
    @unsetActiveRow()
    row.addClass @settings.classes.activeRow
    row.data( @dataset.timeClicked, new Date().getTime() + @settings.delayDblclick )
  setAjax: ->
    if @table.data( @dataset.ajaxResource )
      @settings.configuration.sAjaxSource   = @table.data( @dataset.ajaxResource )
      @settings.configuration.bProcessing   = true
      @settings.configuration.sServerMethod = @table.data( @dataset.ajaxMethod ) if @table.data( @dataset.ajaxMethod )
      @settings.configuration.sAjaxDataProp = @table.data( @dataset.ajaxRoot )   if @table.data( @dataset.ajaxRoot )
  setConfigTable: ->
    @table.addClass 'lol-datatable'
  setEvents: ->
    _this = @
    rows = "tbody tr"
    @table.delegate rows, "click#{@namespace}", (e)->
      row = jQuery @
      if _this.isRowActive(row)
        if row.data(_this.dataset.timeClicked) > new Date().getTime()
          _this.goLink row
        else
          _this.unsetActiveRow(row)
      else
        _this.setActiveRow(row)
    @table.delegate rows, "contextmenu#{@namespace}", (e)->
      row = jQuery @
      _this.setActiveRow(row)
      _this.createMenuContext(row, event)
      false
  setModel: ->
    @settings.contextMenu.model = @table.data(Lol.datatable["private"].dataset.modelName)
  setTable: ->
    @table = @settings.target
  setTranslation: ->
    jQuery.extend(
      true,
      @settings.configuration,
      {
        oLanguage:
          oAria:
            sSortAscending : Lol.t 'datatable_oAria_sSortAscending'
            sSortDescending: Lol.t 'datatable_oAria_sSortDescending'
          oPaginate:
            sFirst   : Lol.t 'datatable_oPaginate_sFirst'
            sLast    : Lol.t 'datatable_oPaginate_sLast'
            sNext    : Lol.t 'datatable_oPaginate_sNext'
            sPrevious: Lol.t 'datatable_oPaginate_sPrevious'
          sEmptyTable    : Lol.t 'datatable_sEmptyTable'
          sInfo          : Lol.t 'datatable_sInfo'
          sInfoEmpty     : Lol.t 'datatable_sInfoEmpty'
          sInfoFiltered  : Lol.t 'datatable_sInfoFiltered'
          sInfoPostFix   : Lol.t 'datatable_sInfoPostFix'
          sInfoThousands : Lol.t 'datatable_sInfoThousands'
          sLengthMenu    : Lol.t 'datatable_sLengthMenu'
          sLoadingRecords: Lol.t 'datatable_sLoadingRecords'
          sProcessing    : Lol.t 'datatable_sProcessing'
          sSearch        : Lol.t 'datatable_sSearch'
          sUrl           : Lol.t 'datatable_sUrl'
          sZeroRecords   : Lol.t 'datatable_sZeroRecords'
      }
    )
  unsetActiveRow: ()->
    jQuery("tr.#{@settings.classes.activeRow}", @table).removeClass @settings.classes.activeRow


Lol.datatable =
  ## private configs
  private:
    dataset:
      autoGenerate: 'lolDatatable'
      link        : 'datatableLink'
      deleteLink  : 'datatableDeleteLink'
      editLink    : 'datatableEditLink'
      viewLink    : 'datatableViewLink'
      timeClicked : 'datatableClicked'
      modelName   : 'datatableModelName'
      modelId     : 'datatableModelId'
  defaults:
    debug         : true
    selectable    : true
    target        : null
    delayDblclick : 0
    classes:
      activeRow : 'active_row'
    contextMenu:
      delete: (row, object)->
        window.lol_temp_fn_model_destroy = [row,object]
        attrs =
          "data-datatable-model-name": object.settings.contextMenu.model
          "data-datatable-model-id"  : row.data(Lol.datatable.private.dataset.modelId)
        new Lol.Modal
          buttons  : 'OK_CANCEL'
          content  : Lol.t('datatable_confirm_delete')
          title    : Lol.t('datatable_confirm_delete_title')
          callbacks:
            buttonClick: (button, obj)->
              obj.destroy()
          buttonParams:
            attributes:
              OK: attrs
            fn:
              OK_CLICK: (event, obj)->
                model = new Lol.model.reference[obj.button.data(Lol.datatable.private.dataset.modelName)]
                model.set 'id', obj.button.data(Lol.datatable.private.dataset.modelId)
                model.destroy Lol.model.destroy
        false
      edit: (row, object)->
        object.debug row.data(object.dataset.editLink)
        window.location = row.data(object.dataset.editLink)
        false
      view: (row, object)->
        window.location = row.data(object.dataset.viewLink)
        false
      iconView : 'icon-eye-open'
      iconEdit : ' icon-edit'
      iconDelete : 'icon-remove'
      useIcons : true
      model    : null # typeof Lol.Model
    configuration:
      aaSortingFixed : null
      aoColumnDefs   : null
      aoColumns      : null
      asStripeClasses: null
      bAutoWidth     : true
      bDeferRender   : false
      bDestroy       : false
      bFilter        : false
      bInfo          : false
      bJQueryUI      : false
      bLengthChange  : false
      bPaginate      : false
      bProcessing    : false
      bRetrieve      : false
      bScrollAutoCss : true
      bScrollCollapse: false
      bScrollInfinite: false
      bServerSide    : false
      bSort          : true
      bSortCellsTop  : false
      bSortClasses   : true
      bStateSave     : false
      iCookieDuration: 7200
      iDeferLoading  : null
      iDisplayLength : 20
      iDisplayStart  : 0
      iScrollLoadGap : 100
      iTabIndex      : 0
      sAjaxDataProp  : "aaData"
      sAjaxSource    : null
      sCookiePrefix  : "SpryMedia_DataTables_"
      sDom           : "lfrtip"
      sPaginationType: "two_button"
      sScrollX       : ""
      sScrollXInner  : ""
      sScrollY       : ""
      sServerMethod  : "GET"

jQuery ->
  jQuery('[data-lol-datatable]').each ->
    new Lol.Datatable
      target: jQuery(@)