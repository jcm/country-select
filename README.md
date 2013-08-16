# Country-Select

Provides a simple helper to get an HTML select list of countries.  The list of countries comes from the ISO 3166 standard.  While it is a relatively neutral source of country names, it may still offend some users.

Users are strongly advised to evaluate the suitability of this list given their user base.

This project was forked to have a version of the gem which would use 2 letter ISO-3166 country codes, and allow
for internationalization. The translations can be set up under the "countries" key with the
ISO-3166 code as the sub-key. Thus: countries.US is the translation key for the United States of America.

## Latest Changes
**1.2.0**

- Converted COUNTRIES to a hash from default English name to ISO-3166 2 letter code.

**1.1.1**

- Fixed incompatibility with Rails 3.2.2 (thanks to [jmazzi](https://github.com/jamesds/country-select/pull/4))

**1.1.0**

- Updated the country list to change the name of *Libyan Arab Jamahiriya* to *Libya* according to the [latest ISO 3166 newsletter](http://www.iso.org/iso/nl_vi-11_name_change_for_libya.pdf)
- A country in the priority list will be selected there and not in the main list (thanks to [yyyc514](https://github.com/jamesds/country-select/pull/3))
- Removed relics from the pre-gem days

## Installation

Install as a gem using

    gem install country-select

Or put the following in your Gemfile

    gem 'country-select'

After installing the `gem`, you can run the generator to create the i18n files:

    rails g country_select:install

This will create, for now, the files `countries.en.yml` and `countries.pt-BR.yml`
in your `locales` folder.

## Example

Simple use supplying model and attribute as parameters:

    country_select("user", "country_name")

Supplying priority countries to be placed at the top of the list:

    country_select("user", "country_name", [ "BRA", "URY", "PRY" ])

Defining the currently selected country:

    country_select("user", "country_name", [ "BRA", "URY", "PRY" ], selected: 'BRA')

## Version History

 - **1.0.5** - runtime error raised if any of the user-supplied priority countries do not correlate with those in the main country list.
 - **1.0.4** - updated the country list to match the latest ISO 3166 specification
 - **1.0.3** - changed gem name from 'iso-3166-country-select' to just 'country-select'
 - **1.0.2** - forked the plugin and made it into a gem

Copyright (c) 2008 Michael Koziarski, released under the MIT license
