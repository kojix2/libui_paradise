#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/033_slider_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('Slider Example', 250, 70, 1)

slider = ui_slider(0, 100)

# =========================================================================== #
# === callback_for_the_slider
# =========================================================================== #
def callback_for_the_slider
  proc { |pointer|
    puts "New Slider value: #{UI.slider_value(pointer)}"
  }
end
slider.on_changed { callback_for_the_slider }

# =========================================================================== #
# The original variant would go like this:
#
#   LibUI.slider_on_changed(slider, slider_changed_callback)
#
# =========================================================================== #
outer_vbox = ui_padded_vbox(slider)
window.add(outer_vbox)
window.intelligent_quit