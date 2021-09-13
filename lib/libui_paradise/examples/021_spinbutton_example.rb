#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example just shows a spinbutton example.
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('Spinbutton Example', 200, 100, 1)

outer_vbox = ui_padded_vbox
spinbutton = ui_spinbutton(0, 100)
spinbutton.set_value(42)

spinbox_changed_callback = proc { |ptr|
  puts "Changed value to: #{UI.spinbox_value(ptr)}"
  0
}

UI.spinbox_on_changed(spinbutton, spinbox_changed_callback, nil)

outer_vbox << spinbutton

window.child = outer_vbox
window.intelligent_quit