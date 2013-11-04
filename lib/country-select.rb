require 'sort_alphabetical'
require 'countries'

module ActionView
  module Helpers
    module FormOptionsHelper
      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        country_options = []

        cnt = COUNTRIES.dup
        if priority_countries && !priority_countries.empty?
          if (unlisted = priority_countries - cnt.values).any?
            raise RuntimeError.new("Supplied priority countries are not in the main list: #{unlisted}")
          end

          sep = "-------------"
          translated_priority_countries = translated_countries(priority_countries.map {|code| [cnt.key(code), code]})
          country_options.unshift(sep)
          country_options.unshift(*translated_priority_countries.zip(priority_countries))

          disabled = Array.wrap(options.fetch(:disabled, []))
          disabled |= [sep]
          options[:disabled] = disabled
          cnt.delete_if { |k,v| priority_countries.include? v }
        end

        Tags::Select.new(object, method, self, country_options + SortAlphabetical.sort(
            translated_countries(cnt).zip(cnt.values)), options, html_options).render
      end

      def translated_countries(countries)
        countries.map { |country, code| I18n.translate("countries.#{code}", :default => country) }
      end

    end

    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
