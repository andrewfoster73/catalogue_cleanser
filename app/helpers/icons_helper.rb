# frozen_string_literal: true

module IconsHelper
  # @see https://heroicons.com/ Available Heroicon names
  # @see https://tailwindcss.com/docs/customizing-colors Standard TailwindCSS colours
  # @param [Symbol] name the name of the Heroicon to display
  # @param [Symbol] colour the TailwindCSS colour the icon will use
  # @param [Boolean] active the style of the icon will change depending on whether it is active or not
  # @param [Hash] options additional configuration options for the icon
  # @option options [String] :style The Heroicon style to use.
  #   By default this is "outline". Unsupported alternative is "solid".
  # @option options [String] :size
  # @option options [String] :classes TailwindCSS colour related classes to add
  # @example Basic icon
  #   icon(name: :trash, colour: :white)
  # @example With a different size specified
  #   icon(name: :question_mark_circle, colour: :blue, options: { size: 5 })
  def icon(name:, colour:, active: false, options: {})
    options.reverse_merge!(default_icon_options)
    content_tag(:svg, {
      class: icon_class(classes: options[:classes], active: active, colour: colour, size: options[:size]),
      xmlns: 'http://www.w3.org/2000/svg',
      fill: 'none',
      viewBox: '0 0 24 24',
      stroke: 'currentColor',
      "aria-hidden": 'true'
    }
    ) { safe_join(heroicons[options[:style]][name].map { |d| concat(svg_path_content(draw: d)) }) }
  end

  private

  def default_icon_options
    { style: :outline, size: 6, classes: 'mr-3' }
  end

  def svg_path_content(draw:)
    content_tag(
      :path,
      nil,
      {
        "stroke-linecap": 'round',
        "stroke-linejoin": 'round',
        "stroke-width": '2',
        "d": draw
      }
    )
  end

  def icon_class(classes:, active:, colour:, size:)
    [
      (active ? icon_colour_classes[:active][colour] : icon_colour_classes[:inactive][colour]),
      classes,
      "flex-shrink-0 h-#{size} w-#{size}"
    ].join(' ')
  end

  # rubocop:disable Layout/LineLength
  def heroicons
    {
      outline: {
        arrow_left: ['M10 19l-7-7m0 0l7-7m-7 7h18'],
        calendar: ['M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z'],
        check_circle: ['M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z'],
        chevron_left: ['M15 19l-7-7 7-7'],
        chevron_right: ['M9 5l7 7-7 7'],
        clipboard_list: ['M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01'],
        cog: [
          'M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z',
          'M15 12a3 3 0 11-6 0 3 3 0 016 0z'
        ],
        collection: ['M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10'],
        database: ['M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4'],
        exclamation: ['M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z'],
        eye: [
          'M15 12a3 3 0 11-6 0 3 3 0 016 0z',
          'M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z'
        ],
        fast_forward: ['M11.933 12.8a1 1 0 000-1.6L6.6 7.2A1 1 0 005 8v8a1 1 0 001.6.8l5.333-4zM19.933 12.8a1 1 0 000-1.6l-5.333-4A1 1 0 0013 8v8a1 1 0 001.6.8l5.333-4z'],
        folder: ['M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z'],
        folder_open: ['M5 19a2 2 0 01-2-2V7a2 2 0 012-2h4l2 2h4a2 2 0 012 2v1M5 19h14a2 2 0 002-2v-5a2 2 0 00-2-2H9a2 2 0 00-2 2v5a2 2 0 01-2 2z'],
        home: ['M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6'],
        identification: ['M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2'],
        inbox_in: ['M8 4H6a2 2 0 00-2 2v12a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-2m-4-1v8m0 0l3-3m-3 3L9 8m-5 5h2.586a1 1 0 01.707.293l2.414 2.414a1 1 0 00.707.293h3.172a1 1 0 00.707-.293l2.414-2.414a1 1 0 01.707-.293H20'],
        information_circle: ['M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z'],
        library: ['M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z'],
        login: ['M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1'],
        logout: ['M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1'],
        pencil: ['M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z'],
        plus: ['M12 4v16m8-8H4'],
        question_mark_circle: ['M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z'],
        save: ['M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4'],
        sort_ascending: ['M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12'],
        sort_descending: ['M3 4h13M3 8h9m-9 4h9m5-4v12m0 0l-4-4m4 4l4-4'],
        trash: ['M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16'],
        users: ['M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z'],
        x: ['M6 18L18 6M6 6l12 12'],
        x_circle: ['M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z']
      }
    }
  end

  # rubocop:enable Layout/LineLength

  def icon_colour_classes
    # Tailwind UI
    {
      active: {
        white: 'text-white',
        gray: 'text-gray-300',
        red: 'text-red-300',
        orange: 'text-orange-300',
        amber: 'text-amber-300',
        yellow: 'text-yellow-300',
        green: 'text-green-300',
        emerald: 'text-emerald-300',
        sky: 'text-sky-300',
        blue: 'text-blue-300',
        indigo: 'text-indigo-300',
        rose: 'text-rose-300'
      },
      inactive: {
        white: 'text-white group-hover:text-white',
        gray: 'text-gray-400 group-hover:text-gray-300',
        red: 'text-red-400 group-hover:text-red-300',
        orange: 'text-orange-400 group-hover:text-orange-300',
        amber: 'text-amber-400 group-hover:text-amber-300',
        yellow: 'text-yellow-400 group-hover:text-yellow-300',
        green: 'text-green-400 group-hover:text-green-300',
        emerald: 'text-emerald-400 group-hover:text-emerald-300',
        sky: 'text-sky-400 group-hover:text-sky-300',
        blue: 'text-blue-400 group-hover:text-blue-300',
        indigo: 'text-indigo-400 group-hover:text-indigo-300',
        rose: 'text-rose-400 group-hover:text-rose-300'
      }
    }
  end
end
