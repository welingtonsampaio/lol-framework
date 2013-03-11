LolFramework::Config.COMPONENTS_JS.iterate! do |js|
  js.library_underscore=            true
  js.library_backbone=              true
  js.library_date_functions=        true
  js.library_jquery_dataTables_min= true
  js.library_jquery_mobile=         true
  js.lol=                           true
  js.lang_en_us=                    true
  js.lang_pt_br=                    true
  js.i18n=                          true
  js.debug=                         true
  js.utils=                         true
  js.core=                          true
  js.alert=                         true
  js.button=                        true
  js.loader=                        true
  js.ajax=                          true
  js.modal=                         true
  js.model=                         true
  js.model_destroy=                 true
  js.datatable=                     true
end

LolFramework::Config.COMPONENTS_CSS.iterate! do |css|
  css.components_loader=    true
  css.components_datatable= true
  css.components_alert=     true
end
