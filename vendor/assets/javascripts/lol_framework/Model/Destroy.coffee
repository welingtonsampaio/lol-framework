Lol.model.destroy =

  error: (model, xhr, options)->
    new Lol.Alert
      type   : "error"
      message: new String(Lol.t("model_destroy_error")).replace("_STATUS_TEXT_",xhr.statusText)
    Lol.model.destroy.callback('error')

  success: (model, response, options)->
    new Lol.Alert
      message: new String(Lol.t("model_destroy_success"))
    Lol.model.destroy.callback('success')

  callback: (type)->
    if type == "success"
      row   = window.lol_temp_fn_model_destroy[0]
      table = window.lol_temp_fn_model_destroy[1]
      oTable = table.table
      window.t = table.table
      aPos = oTable.fnGetPosition( row.find('td')[0] )
      oTable.fnDeleteRow( aPos[0] )
