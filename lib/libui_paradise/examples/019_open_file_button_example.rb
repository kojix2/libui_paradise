#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example shows how to use the grid-related aspects of ruby-libui.
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_padded_main_window('An open-file button-example', 1200, 200, 15)

outer_vbox = ui_padded_vbox
button_open_file = ui_button('Open file')
button_open_file.on_clicked {
  begin
    filename = ui_open_file(window).to_s
    e "The filename was: #{filename}"
  rescue ArgumentError => error # Rescue from "NULL pointer given"
    pp error
  end
}
outer_vbox << button_open_file

window.child = outer_vbox
window.intelligent_quit