
class Lol.model.Rest extends Lol.Core
  update: (model,id)->
  delete: (model,id)->
  insert: (model,data)->

  @destroy: (url)->

    new Lol.Ajax
      method: 'delete'
      url   : url
      callbacks:
        success: (data, textStatus, jqXHR)->
          new Lol.Alert
            message: Lol.t 'rest_registry_destroy_ok'
