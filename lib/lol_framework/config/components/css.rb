module LolFramework
  module Config
    module Components
      class Css < LolFramework::Common
        defaulted_attributes({
          components_loader:    false,
          components_datatable: false,
          components_alert:     false
        })

        def generate
          # removes the current JavaScript file
          File.delete("#{LolFramework::Config::LOL_ASSETS_PATH}/stylesheets/lol.scss") if
              File.exists?("#{LolFramework::Config::LOL_ASSETS_PATH}/stylesheets/lol.scss")

          lol = File.new("#{LolFramework::Config::LOL_ASSETS_PATH}/stylesheets/lol.scss", "w")

          lol.write "// -------------------------------------------------------\n"
          lol.write "//\n" 
          lol.write "//  The LolFramework\n"   
          lol.write "//\n"
          lol.write "//  @date #{LolFramework::UPDATED_AT}\n"
          lol.write "//  @author Welington Sampaio\n"
          lol.write "//  @version #{LolFramework::VERSION}\n"                     
          lol.write "//\n"
          lol.write "// -------------------------------------------------------\n\n"
          lol.write "// -------------------------------------------------------\n"      
          lol.write "//  Initialize\n"     
          lol.write "// -------------------------------------------------------\n"
          lol.write %[@import "./lol_framework/variable";\n]
          lol.write %[@import "./lol_framework/mixin";\n\n]
          lol.write %[html.lol {\n]
          lol.write %[@import "./lol_framework/commom";\n]
          lol.write %[@import "./lol_framework/components/loader";\n]     if components_loader
          lol.write %[@import "./lol_framework/components/datatable";\n]  if components_datatable
          lol.write %[@import "./lol_framework/components/alert";\n]      if components_alert
          lol.write %[}]
          lol.close
        end
      end
    end
  end
end