require 'sort_alphabetical'
require 'countries'

# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
      end
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      # The priority_countries should be a list of ISO-3166 country codes.
      def country_options_for_select(selected = nil, priority_countries = nil)
        country_options = ""

        if priority_countries && !priority_countries.empty?
          if (unlisted = priority_countries - COUNTRIES.values).any?
            raise RuntimeError.new("Supplied priority countries are not in the main list: #{unlisted}")
          end
          translated_priorty_countries = translated_countries(priority_countries.map {|code| [COUNTRIES.key(code), code]})
          country_options += options_for_select(translated_priorty_countries.zip(priority_countries), selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"

          # prevents selected from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority country
          selected = nil if priority_countries.include?(selected)
        end

        country_options = country_options.html_safe if country_options.respond_to?(:html_safe)

        return country_options + options_for_select(SortAlphabetical.sort(
            translated_countries(COUNTRIES).zip(COUNTRIES.values)), selected)
      end

      def translated_countries(countries)
        countries.map { |country, code| I18n.translate("countries.#{code}", :default => country) }
      end

    end

    class InstanceTag
      def to_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
