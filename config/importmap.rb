# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/components', under: 'components'
pin 'stimulus-use', to: 'https://ga.jspm.io/npm:stimulus-use@0.50.0/dist/index.js'
pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js'
pin 'hotkeys-js', to: 'https://ga.jspm.io/npm:hotkeys-js@3.9.4/dist/hotkeys.esm.js'
pin 'cash-dom', to: 'https://ga.jspm.io/npm:cash-dom@8.1.1/dist/cash.js'
pin '@rails/request.js', to: 'https://ga.jspm.io/npm:@rails/request.js@0.0.6/src/index.js'
pin 'el-transition', to: 'https://ga.jspm.io/npm:el-transition@0.0.7/index.js'
