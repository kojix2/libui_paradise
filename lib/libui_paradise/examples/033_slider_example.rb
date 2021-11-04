#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/033_slider_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('Slider Example', 250, 70, 1)

slider = ui_slider(0, 100)
slider_changed_callback = proc { |ptr|
  puts "New Slider value: #{UI.slider_value(ptr)}"
  0
}
slider.on_changed { slider_changed_callback }
# The original variant would go like this:
#   UI.slider_on_changed(slider, slider_changed_callback)

outer_vbox = ui_padded_vbox
outer_vbox << slider
window.add(outer_vbox)
window.intelligent_quit