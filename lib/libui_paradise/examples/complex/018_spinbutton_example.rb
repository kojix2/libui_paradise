#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example just shows a spinbutton example.
# =========================================================================== #
# require '018_spinbutton_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_main_window('Spinbutton Example', 250, 70, 1)

outer_vbox = padded_vbox
spinbutton = ui_spinbutton(0, 100)
spinbutton.set_value(42)

# =========================================================================== #
# Add the on-spin event next:
# =========================================================================== #
spinbox_changed_callback = proc { |pointer|
  # ========================================================================= #
  # Notify the user that the spinbox-value has changed.
  # ========================================================================= #
  puts "Changed value to: #{UI.spinbox_value(pointer)}"
  0
}

LibUI.spinbox_on_changed(spinbutton, spinbox_changed_callback, nil)

outer_vbox << spinbutton

window.child = outer_vbox
window.intelligent_quit