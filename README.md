![GitHub Workflow](https://github.com/andrewfoster73/catalogue_cleanser/actions/workflows/rubyonrails.yml/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/ab8fde07ac74a69788ef/maintainability)](https://codeclimate.com/github/andrewfoster73/catalogue_cleanser/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ab8fde07ac74a69788ef/test_coverage)](https://codeclimate.com/github/andrewfoster73/catalogue_cleanser/test_coverage)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
[![Known Vulnerabilities](https://snyk.io/test/github/andrewfoster73/catalogue_cleanser/badge.svg)](https://snyk.io/test/github/andrewfoster73/catalogue_cleanser)

# README

####Philosophy:
* Products are taken from the PurchasePlus goods_products table and exist as a "shadow" version of those products.
* The shadow products are examined for issues, such as extra whitespace, missing or incorrect attributes, or whether the product is considered a duplicate.
* These issues can spawn self-repairing tasks if a known solution is available.
* Otherwise a human user can edit the products manually to resolve other types of issues where the system cannot determine the correct solution alone.

####Requirements:
* Ruby 3.0.4
* Bundler

####Installation:
* `bundle install`

####Configuration:
* TODO

####Database Initialisation:
* TODO

`psql -h localhost -d external_test -U postgres -f db/external_database_schema.sql`

####Generating Storybook Stories:

`rails view_component_storybook:write_stories_json`

####Running Storybook:

`export NODE_OPTIONS=--openssl-legacy-provider`
`yarn storybook`

####After adding/deleting Stimulus controllers:

`rails stimulus:manifest:update`

####I18n tasks:

`i18n-tasks health`

`i18n-tasks translate-missing --from=base th` (uses Google Translate, has more language options)

See: https://cloud.google.com/translate/docs/languages

_OR_

`i18n-tasks translate-missing --backend=deepl --from=en de` (uses DeepL, has less language options, no Thai for instance)

See: https://www.deepl.com/docs-api/translate-text/translate-text/

`i18n-tasks normalize`

####Building JavaScript Assets:

`yarn build`

####Running the test suite:

`rails test:all`

####Running the linter:

`ruboocop`

####Fixing any linting issues:

`rubocop -a` or `rubocop -A` (see Rubocop documentation for the difference)

####Running the RDocs

`yard server -r`

####Running the application:

`rails dev`

####Deploying the application:
* TODO