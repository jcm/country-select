module CountrySelect
  module Generators
    class InstallGenerator < Rails::Generators::Base
      TEMPLATE_DIR = File.expand_path("../../templates", __FILE__)
      source_root TEMPLATE_DIR

      desc "Copies the i18n files to locales."
      def copy_i18n
        Dir.glob("#{TEMPLATE_DIR}/*.yml") do |file|
          template file, "config/locales/#{file}"
        end
      end
    end
  end
end
