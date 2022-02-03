#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === 'libuiparadise/examples/simple/001_open_file_example.rb'
# =========================================================================== #
require 'libui'

LibUI.init

alias e puts

main_window = LibUI.new_window('hello world', 200, 50, 1)

button = LibUI.new_button('Open File')

LibUI.button_on_clicked(button) {
  result = ::LibUI.open_file(main_window).to_s
  if File.exist?(result)
    e 'The file exists. \o/'
  end
}

LibUI.window_on_closing(main_window) {
  e 'Exiting.'
  LibUI.control_destroy(main_window)
  LibUI.quit
  0
}

LibUI.window_set_child(main_window, button)
LibUI.control_show(main_window)

LibUI.main
LibUI.quit