module LolFramework
  module Config
    module Components
      class Js < LolFramework::Common
        defaulted_attributes({
          library_underscore:            false,
          library_backbone:              false,
          library_date_functions:        false,
          library_jquery_dataTables_min: false,
          library_jquery_mobile:         false,
          library_caret:                 false,
          lol:                           false,
          lang_en_us:                    false,
          lang_pt_br:                    false,
          i18n:                          false,
          debug:                         false,
          utils:                         false,
          core:                          false,
          alert:                         false,
          button:                        false,
          loader:                        false,
          ajax:                          false,
          modal:                         false,
          model:                         false,
          model_destroy:                 false,
          datatable:                     false,
          form_validate:                 false,
          masked:                        false})

        def generate
          # removes the current JavaScript file
          File.delete("#{LolFramework::Config::LOL_ASSETS_PATH}/javascripts/lol.js") if
              File.exists?("#{LolFramework::Config::LOL_ASSETS_PATH}/javascripts/lol.js")

          # defines the all dependencies of components
          dependencies = {
            ajax:          %w{core},
            alert:         %w{core},
            button:        %w{core},
            datatable:     %w{core library_jquery_dataTables_min},
            core:          %w{lol utils  i18n  lang_en_us debug library_underscore library_backbone},
            masked:        %w{core library_caret},
            modal:         %w{core button},
            model:         %w{core},
            model_destroy: %w{model alert}
          }
          begin
            test_one = instance_variables
            instance_variables.each do |v|
              dependencies[v.to_s.sub("@", "").to_sym].each do |attr|
                instance_variable_set("@#{attr}", true)
              end if dependencies.key? v.to_s.sub("@", "").to_sym
            end
            test_two = instance_variables
          end while test_one != test_two
          lol = File.new("#{LolFramework::Config::LOL_ASSETS_PATH}/javascripts/lol.js", "w")
          lol.write "//= require ./lol_framework/Library/underscore\n"            if library_underscore
          lol.write "//= require ./lol_framework/Library/backbone\n"              if library_backbone
          lol.write "//= require ./lol_framework/Library/caret\n"                 if library_caret
          lol.write "//= require ./lol_framework/Library/date-functions\n"        if library_date_functions
          lol.write "//= require ./lol_framework/Library/date-functions\n"        if library_date_functions
          lol.write "//= require ./lol_framework/Library/jquery.dataTables.min\n" if library_jquery_dataTables_min
          lol.write "//= require ./lol_framework/Library/jquery.mobile\n"         if library_jquery_mobile
          lol.write "//= require ./lol_framework/Lol\n"                           if lol
          lol.write "//= require ./lol_framework/Lang/en-us\n"                    if lang_en_us
          lol.write "//= require ./lol_framework/Lang/pt-br\n"                    if lang_pt_br
          lol.write "//= require ./lol_framework/I18n\n"                          if i18n
          lol.write "//= require ./lol_framework/Debug\n"                         if debug
          lol.write "//= require ./lol_framework/Utils\n"                         if utils
          lol.write "//= require ./lol_framework/Core\n"                          if core
          lol.write "//= require ./lol_framework/Alert\n"                         if alert
          lol.write "//= require ./lol_framework/Button\n"                        if button
          lol.write "//= require ./lol_framework/Loader\n"                        if loader
          lol.write "//= require ./lol_framework/Ajax\n"                          if ajax
          lol.write "//= require ./lol_framework/Modal\n"                         if modal
          lol.write "//= require ./lol_framework/Model\n"                         if model
          lol.write "//= require ./lol_framework/Model/Destroy\n"                 if model_destroy
          lol.write "//= require ./lol_framework/Datatable\n"                     if datatable
          lol.write "//= require ./lol_framework/FormValidate\n"                  if form_validate
          lol.write "//= require ./lol_framework/Masked\n"                        if masked
          lol.close
        end
      end
    end
  end
end


