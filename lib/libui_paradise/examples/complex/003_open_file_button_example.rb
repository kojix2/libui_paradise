#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example shows how to open a file via ruby-libui.
# =========================================================================== #
# require 'libui_paradise/complex/003_open_file_button_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_padded_main_window('An open-file button-example', 1200, 200, 15)

outer_vbox = ui_padded_vbox
button_open_file = ui_button('Open file')
button_open_file.on_clicked {
  begin
    #filename = ui_open_file(window).to_s
    filename = ::LibUI.open_file(main_window).to_s
    e "The filename was: #{filename}"
  rescue ArgumentError => error # Rescue from "NULL pointer given"
    pp error
  end
}
outer_vbox << button_open_file

window.child = outer_vbox
window.intelligent_quit


if false
LibUI.button_on_clicked(button) {
  result = ::LibUI.open_file(main_window).to_s
  if File.exist?(result)
    e 'The file exists. \o/'
  end
}

end