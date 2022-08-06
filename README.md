![GitHub Workflow](https://github.com/andrewfoster73/catalogue_cleanser/actions/workflows/rubyonrails.yml/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/ab8fde07ac74a69788ef/maintainability)](https://codeclimate.com/github/andrewfoster73/catalogue_cleanser/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ab8fde07ac74a69788ef/test_coverage)](https://codeclimate.com/github/andrewfoster73/catalogue_cleanser/test_coverage)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
[![Known Vulnerabilities](https://snyk.io/test/github/andrewfoster73/catalogue_cleanser/badge.svg)](https://snyk.io/test/github/andrewfoster73/catalogue_cleanser)

# README

Requirements:
* Ruby 3.0.2
* Bundler

Installation:
* `bundle install`

Configuration:
* TODO

Database Initialisation:
* TODO

Generating Storybook Stories:

`rails view_component_storybook:write_stories_json`

Running Storybook:

`yarn storybook`

After adding new Stimulus controllers:

`rails stimulus:manifest:update`

Building JavaScript Assets:

`yarn build`

Running the test suite:

`rails test:all`

Running the linter:

`ruboocop`

Fixing any linting issues:

`rubocop -a` or `rubocop -A` (see Rubocop documentation for the difference)

Running the application:

`rails dev`

Deploying the application:
* TODO