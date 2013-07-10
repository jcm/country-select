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

        return country_options + options_for_select(translated_countries(COUNTRIES).zip(COUNTRIES.values).sort, selected)
      end

      def translated_countries(countries)
        countries.map { |country, code| I18n.translate("countries.#{code}", :default => country) }
      end

      # All the countries included in the country_options output.
      COUNTRIES = {
          "Aaland Islands" => "ALA",
          "Afghanistan" => "AFG",
          "Albania" => "ALB",
          "Algeria" => "DZA",
          "American Samoa" => "ASM",
          "Andorra" => "AND",
          "Angola" => "AGO",
          "Anguilla" => "AIA",
          "Antarctica" => "ATA",
          "Antigua And Barbuda" => "ATG",
          "Argentina" => "ARG",
          "Armenia" => "ARM",
          "Aruba" => "ABW",
          "Australia" => "AUS",
          "Austria" => "AUT",
          "Azerbaijan" => "AZE",
          "Bahamas" => "BHS",
          "Bahrain" => "BHR",
          "Bangladesh" => "BGD",
          "Barbados" => "BRB",
          "Belarus" => "BLR",
          "Belgium" => "BEL",
          "Belize" => "BLZ",
          "Benin" => "BEN",
          "Bermuda" => "BMU",
          "Bhutan" => "BTN",
          "Bolivia" => "BOL",
          "Bosnia And Herzegowina" => "BIH",
          "Botswana" => "BWA",
          "Bouvet Island" => "BVT",
          "Brazil" => "BRA",
          "British Indian Ocean Territory" => "IOT",
          "Brunei Darussalam" => "BRN",
          "Bulgaria" => "BGR",
          "Burkina Faso" => "BFA",
          "Burundi" => "BDI",
          "Cambodia" => "KHM",
          "Cameroon" => "CMR",
          "Canada" => "CAN",
          "Cape Verde" => "CPV",
          "Cayman Islands" => "CYM",
          "Central African Republic" => "CAF",
          "Chad" => "TCD",
          "Chile" => "CHL",
          "China" => "CHN",
          "Christmas Island" => "CXR",
          "Cocos (keeling) Islands" => "CCK",
          "Colombia" => "COL",
          "Comoros" => "COM",
          "Congo, Democratic Republic Of (was Zaire)" => "COD",
          "Congo, Republic Of" => "COG",
          "Cook Islands" => "COK",
          "Costa Rica" => "CRI",
          "Cote D'ivoire" => "CIV",
          "Croatia (local Name: Hrvatska)" => "HRV",
          "Cuba" => "CUB",
          "Cyprus" => "CYP",
          "Czech Republic" => "CZE",
          "Denmark" => "DNK",
          "Djibouti" => "DJI",
          "Dominica" => "DMA",
          "Dominican Republic" => "DOM",
          "Ecuador" => "ECU",
          "Egypt" => "EGY",
          "El Salvador" => "SLV",
          "Equatorial Guinea" => "GNQ",
          "Eritrea" => "ERI",
          "Estonia" => "EST",
          "Ethiopia" => "ETH",
          "Falkland Islands (malvinas)" => "FLK",
          "Faroe Islands" => "FRO",
          "Fiji" => "FJI",
          "Finland" => "FIN",
          "France" => "FRA",
          "French Guiana" => "GUF",
          "French Polynesia" => "PYF",
          "French Southern Territories" => "ATF",
          "Gabon" => "GAB",
          "Gambia" => "GMB",
          "Georgia" => "GEO",
          "Germany" => "DEU",
          "Ghana" => "GHA",
          "Gibraltar" => "GIB",
          "Greece" => "GRC",
          "Greenland" => "GRL",
          "Grenada" => "GRD",
          "Guadeloupe" => "GLP",
          "Guam" => "GUM",
          "Guatemala" => "GTM",
          "Guinea" => "GIN",
          "Guinea-bissau" => "GNB",
          "Guyana" => "GUY",
          "Haiti" => "HTI",
          "Heard And Mc Donald Islands" => "HMD",
          "Honduras" => "HND",
          "Hong Kong" => "HKG",
          "Hungary" => "HUN",
          "Iceland" => "ISL",
          "India" => "IND",
          "Indonesia" => "IDN",
          "Iran (islamic Republic Of)" => "IRN",
          "Iraq" => "IRQ",
          "Ireland" => "IRL",
          "Israel" => "ISR",
          "Italy" => "ITA",
          "Jamaica" => "JAM",
          "Japan" => "JPN",
          "Jordan" => "JOR",
          "Kazakhstan" => "KAZ",
          "Kenya" => "KEN",
          "Kiribati" => "KIR",
          "Korea, Democratic People's Republic Of" => "PRK",
          "Korea, Republic Of" => "KOR",
          "Kuwait" => "KWT",
          "Kyrgyzstan" => "KGZ",
          "Lao People's Democratic Republic" => "LAO",
          "Latvia" => "LVA",
          "Lebanon" => "LBN",
          "Lesotho" => "LSO",
          "Liberia" => "LBR",
          "Libyan Arab Jamahiriya" => "LBY",
          "Liechtenstein" => "LIE",
          "Lithuania" => "LTU",
          "Luxembourg" => "LUX",
          "Macau" => "MAC",
          "Macedonia, The Former Yugoslav Republic Of" => "MKD",
          "Madagascar" => "MDG",
          "Malawi" => "MWI",
          "Malaysia" => "MYS",
          "Maldives" => "MDV",
          "Mali" => "MLI",
          "Malta" => "MLT",
          "Marshall Islands" => "MHL",
          "Martinique" => "MTQ",
          "Mauritania" => "MRT",
          "Mauritius" => "MUS",
          "Mayotte" => "MYT",
          "Mexico" => "MEX",
          "Micronesia, Federated States Of" => "FSM",
          "Moldova, Republic Of" => "MDA",
          "Monaco" => "MCO",
          "Mongolia" => "MNG",
          "Montserrat" => "MSR",
          "Morocco" => "MAR",
          "Mozambique" => "MOZ",
          "Myanmar" => "MMR",
          "Namibia" => "NAM",
          "Nauru" => "NRU",
          "Nepal" => "NPL",
          "Netherlands" => "NLD",
          "Netherlands Antilles" => "ANT",
          "New Caledonia" => "NCL",
          "New Zealand" => "NZL",
          "Nicaragua" => "NIC",
          "Niger" => "NER",
          "Nigeria" => "NGA",
          "Niue" => "NIU",
          "Norfolk Island" => "NFK",
          "Northern Mariana Islands" => "MNP",
          "Norway" => "NOR",
          "Oman" => "OMN",
          "Pakistan" => "PAK",
          "Palau" => "PLW",
          "Palestinian Territory, Occupied" => "PSE",
          "Panama" => "PAN",
          "Papua New Guinea" => "PNG",
          "Paraguay" => "PRY",
          "Peru" => "PER",
          "Philippines" => "PHL",
          "Pitcairn" => "PCN",
          "Poland" => "POL",
          "Portugal" => "PRT",
          "Puerto Rico" => "PRI",
          "Qatar" => "QAT",
          "Reunion" => "REU",
          "Romania" => "ROU",
          "Russian Federation" => "RUS",
          "Rwanda" => "RWA",
          "Saint Helena" => "SHN",
          "Saint Kitts And Nevis" => "KNA",
          "Saint Lucia" => "LCA",
          "Saint Pierre And Miquelon" => "SPM",
          "Saint Vincent And The Grenadines" => "VCT",
          "Samoa" => "WSM",
          "San Marino" => "SMR",
          "Sao Tome And Principe" => "STP",
          "Saudi Arabia" => "SAU",
          "Senegal" => "SEN",
          "Serbia And Montenegro" => "SCG",
          "Seychelles" => "SYC",
          "Sierra Leone" => "SLE",
          "Singapore" => "SGP",
          "Slovakia" => "SVK",
          "Slovenia" => "SVN",
          "Solomon Islands" => "SLB",
          "Somalia" => "SOM",
          "South Africa" => "ZAF",
          "South Georgia And The South Sandwich Islands" => "SGS",
          "Spain" => "ESP",
          "Sri Lanka" => "LKA",
          "Sudan" => "SDN",
          "Suriname" => "SUR",
          "Svalbard And Jan Mayen Islands" => "SJM",
          "Swaziland" => "SWZ",
          "Sweden" => "SWE",
          "Switzerland" => "CHE",
          "Syrian Arab Republic" => "SYR",
          "Taiwan" => "TWN",
          "Tajikistan" => "TJK",
          "Tanzania, United Republic Of" => "TZA",
          "Thailand" => "THA",
          "Timor-leste" => "TLS",
          "Togo" => "TGO",
          "Tokelau" => "TKL",
          "Tonga" => "TON",
          "Trinidad And Tobago" => "TTO",
          "Tunisia" => "TUN",
          "Turkey" => "TUR",
          "Turkmenistan" => "TKM",
          "Turks And Caicos Islands" => "TCA",
          "Tuvalu" => "TUV",
          "Uganda" => "UGA",
          "Ukraine" => "UKR",
          "United Arab Emirates" => "ARE",
          "United Kingdom" => "GBR",
          "United States" => "USA",
          "United States Minor Outlying Islands" => "UMI",
          "Uruguay" => "URY",
          "Uzbekistan" => "UZB",
          "Vanuatu" => "VUT",
          "Vatican City State (holy See)" => "VAT",
          "Venezuela" => "VEN",
          "Viet Nam" => "VNM",
          "Virgin Islands (british)" => "VGB",
          "Virgin Islands (u.s.)" => "VIR",
          "Wallis And Futuna Islands" => "WLF",
          "Western Sahara" => "ESH",
          "Yemen" => "YEM",
          "Zambia" => "ZMB",
          "Zimbabwe" => "ZWE"} unless const_defined?("COUNTRIES")
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
