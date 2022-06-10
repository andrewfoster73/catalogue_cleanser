# frozen_string_literal: true

json.array!(@collection, partial: 'tasks/task', as: :task)
