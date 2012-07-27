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

        if priority_countries
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

        return country_options + options_for_select(translated_countries(COUNTRIES).zip(COUNTRIES.values), selected)
      end

      def translated_countries(countries)
        countries.map { |country, code| I18n.translate("countries.#{code}", :default => country) }
      end

      # All the countries included in the country_options output.
      COUNTRIES = {
          "Afghanistan" => "AF",
          "Aland Islands" => "AX",
          "Albania" => "AL",
          "Algeria" => "DZ",
          "American Samoa" => "AS",
          "Andorra" => "AD",
          "Angola" => "AO",
          "Anguilla" => "AI",
          "Antarctica" => "AQ",
          "Antigua And Barbuda" => "AG",
          "Argentina" => "AR",
          "Armenia" => "AM",
          "Aruba" => "AW",
          "Australia" => "AU",
          "Austria" => "AT",
          "Azerbaijan" => "AZ",
          "Bahamas" => "BS",
          "Bahrain" => "BH",
          "Bangladesh" => "BD",
          "Barbados" => "BB",
          "Belarus" => "BY",
          "Belgium" => "BE",
          "Belize" => "BZ",
          "Benin" => "BJ",
          "Bermuda" => "BM",
          "Bhutan" => "BT",
          "Bolivia, Plurinational State of" => "BO",
          "Bonaire, Sint Eustatius and Saba" => "BQ",
          "Bosnia and Herzegovina" => "BA",
          "Botswana" => "BW",
          "Bouvet Island" => "BV",
          "Brazil" => "BR",
          "British Indian Ocean Territory" => "IO",
          "Brunei Darussalam" => "BN",
          "Bulgaria" => "BG",
          "Burkina Faso" => "BF",
          "Burundi" => "BI",
          "Cambodia" => "KH",
          "Cameroon" => "CM",
          "Canada" => "CA",
          "Cape Verde" => "CV",
          "Cayman Islands" => "KY",
          "Central African Republic" => "CF",
          "Chad" => "TD",
          "Chile" => "CL",
          "China" => "CN",
          "Christmas Island" => "CX",
          "Cocos (Keeling) Islands" => "CC",
          "Colombia" => "CO",
          "Comoros" => "KM",
          "Congo" => "CG",
          "Congo, the Democratic Republic of the" => "CD",
          "Cook Islands" => "CK",
          "Costa Rica" => "CR",
          "Cote d'Ivoire" => "CI",
          "Croatia" => "HR",
          "Cuba" => "CU",
          "Curacao" => "CW",
          "Cyprus" => "CY",
          "Czech Republic" => "CZ",
          "Denmark" => "DK",
          "Djibouti" => "DJ",
          "Dominica" => "DM",
          "Dominican Republic" => "DO",
          "Ecuador" => "EC",
          "Egypt" => "EG",
          "El Salvador" => "SV",
          "Equatorial Guinea" => "GQ",
          "Eritrea" => "ER",
          "Estonia" => "EE",
          "Ethiopia" => "ET",
          "Falkland Islands (Malvinas)" => "FK",
          "Faroe Islands" => "FO",
          "Fiji" => "FJ",
          "Finland" => "FI",
          "France" => "FR",
          "French Guiana" => "GF",
          "French Polynesia" => "PF",
          "French Southern Territories" => "TF",
          "Gabon" => "GA",
          "Gambia" => "GM",
          "Georgia" => "GE",
          "Germany" => "DE",
          "Ghana" => "GH",
          "Gibraltar" => "GI",
          "Greece" => "GR",
          "Greenland" => "GL",
          "Grenada" => "GD",
          "Guadeloupe" => "GP",
          "Guam" => "GU",
          "Guatemala" => "GT",
          "Guernsey" => "GG",
          "Guinea" => "GN",
          "Guinea-Bissau" => "GW",
          "Guyana" => "GY",
          "Haiti" => "HT",
          "Heard Island and McDonald Islands" => "HM",
          "Holy See (Vatican City State)" => "VA",
          "Honduras" => "HN",
          "Hong Kong" => "HK",
          "Hungary" => "HU",
          "Iceland" => "IS",
          "India" => "IN",
          "Indonesia" => "ID",
          "Iran, Islamic Republic of" => "IR",
          "Iraq" => "IQ",
          "Ireland" => "IE",
          "Isle of Man" => "IM",
          "Israel" => "IL",
          "Italy" => "IT",
          "Jamaica" => "JM",
          "Japan" => "JP",
          "Jersey" => "JE",
          "Jordan" => "JO",
          "Kazakhstan" => "KZ",
          "Kenya" => "KE",
          "Kiribati" => "KI",
          "Korea, Democratic People's Republic of" => "KP",
          "Korea, Republic of" => "KR",
          "Kuwait" => "KW",
          "Kyrgyzstan" => "KG",
          "Lao People's Democratic Republic" => "LA",
          "Latvia" => "LV",
          "Lebanon" => "LB",
          "Lesotho" => "LS",
          "Liberia" => "LR",
          "Libya" => "LY",
          "Liechtenstein" => "LI",
          "Lithuania" => "LT",
          "Luxembourg" => "LU",
          "Macao" => "MO",
          "Macedonia, The Former Yugoslav Republic Of" => "MK",
          "Madagascar" => "MG",
          "Malawi" => "MW",
          "Malaysia" => "MY",
          "Maldives" => "MV",
          "Mali" => "ML",
          "Malta" => "MT",
          "Marshall Islands" => "MH",
          "Martinique" => "MQ",
          "Mauritania" => "MR",
          "Mauritius" => "MU",
          "Mayotte" => "YT",
          "Mexico" => "MX",
          "Micronesia, Federated States of" => "FM",
          "Moldova, Republic of" => "MD",
          "Monaco" => "MC",
          "Mongolia" => "MN",
          "Montenegro" => "ME",
          "Montserrat" => "MS",
          "Morocco" => "MA",
          "Mozambique" => "MZ",
          "Myanmar" => "MM",
          "Namibia" => "NA",
          "Nauru" => "NR",
          "Nepal" => "NP",
          "Netherlands" => "NL",
          "New Caledonia" => "NC",
          "New Zealand" => "NZ",
          "Nicaragua" => "NI",
          "Niger" => "NE",
          "Nigeria" => "NG",
          "Niue" => "NU",
          "Norfolk Island" => "NF",
          "Northern Mariana Islands" => "MP",
          "Norway" => "NO",
          "Oman" => "OM",
          "Pakistan" => "PK",
          "Palau" => "PW",
          "Palestinian Territory, Occupied" => "PS",
          "Panama" => "PA",
          "Papua New Guinea" => "PG",
          "Paraguay" => "PY",
          "Peru" => "PE",
          "Philippines" => "PH",
          "Pitcairn" => "PN",
          "Poland" => "PL",
          "Portugal" => "PT",
          "Puerto Rico" => "PR",
          "Qatar" => "QA",
          "Reunion" => "RE",
          "Romania" => "RO",
          "Russian Federation" => "RU",
          "Rwanda" => "RW",
          "Saint Barthelemy" => "BL",
          "Saint Helena, Ascension and Tristan da Cunha" => "SH",
          "Saint Kitts and Nevis" => "KN",
          "Saint Lucia" => "LC",
          "Saint Martin (French part)" => "MF",
          "Saint Pierre and Miquelon" => "PM",
          "Saint Vincent and the Grenadines" => "VC",
          "Samoa" => "WS",
          "San Marino" => "SM",
          "Sao Tome and Principe" => "ST",
          "Saudi Arabia" => "SA",
          "Senegal" => "SN",
          "Serbia" => "RS",
          "Seychelles" => "SC",
          "Sierra Leone" => "SL",
          "Singapore" => "SG",
          "Sint Maarten (Dutch part)" => "SX",
          "Slovakia" => "SK",
          "Slovenia" => "SI",
          "Solomon Islands" => "SB",
          "Somalia" => "SO",
          "South Africa" => "ZA",
          "South Georgia and the South Sandwich Islands" => "GS",
          "South Sudan" => "SS",
          "Spain" => "ES",
          "Sri Lanka" => "LK",
          "Sudan" => "SD",
          "Suriname" => "SR",
          "Svalbard and Jan Mayen" => "SJ",
          "Swaziland" => "SZ",
          "Sweden" => "SE",
          "Switzerland" => "CH",
          "Syrian Arab Republic" => "SY",
          "Taiwan" => "TW",
          "Tajikistan" => "TJ",
          "Tanzania, United Republic of" => "TZ",
          "Thailand" => "TH",
          "Timor-Leste" => "TL",
          "Togo" => "TG",
          "Tokelau" => "TK",
          "Tonga" => "TO",
          "Trinidad and Tobago" => "TT",
          "Tunisia" => "TN",
          "Turkey" => "TR",
          "Turkmenistan" => "TM",
          "Turks and Caicos Islands" => "TC",
          "Tuvalu" => "TV",
          "Uganda" => "UG",
          "Ukraine" => "UA",
          "United Arab Emirates" => "AE",
          "United Kingdom" => "GB",
          "United States" => "US",
          "United States Minor Outlying Islands" => "UM",
          "Uruguay" => "UY",
          "Uzbekistan" => "UZ",
          "Vanuatu" => "VU",
          "Venezuela, Bolivarian Republic of" => "VE",
          "Viet Nam" => "VN",
          "Virgin Islands, British" => "VG",
          "Virgin Islands, U.S." => "VI",
          "Wallis and Futuna" => "WF",
          "Western Sahara" => "EH",
          "Yemen" => "YE",
          "Zambia" => "ZM",
          "Zimbabwe" => "ZW"} unless const_defined?("COUNTRIES")
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
