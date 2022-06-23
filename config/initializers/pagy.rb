# frozen_string_literal: true

Pagy::DEFAULT[:items] = (Rails.env.test? ? 1 : 20)
