#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

main_window = UI.window('hello world', 300, 200, 1)

font_button = UI.font_button
# =========================================================================== #
# === font_descriptor
#
# The font_descriptor will contain all the important information about the
# font at hand. It will be updated via UI.font_button_font().
# =========================================================================== #
font_descriptor = UI::FFI::FontDescriptor.malloc
UI.font_button_on_changed(font_button) {
  UI.font_button_font(font_button, font_descriptor)
  # ========================================================================= #
  # The following line will output something like:
  #
  #   {:family=>"Georgia", :size=>12.0, :weight=>700, :italic=>0, :stretch=>4}
  #
  # ========================================================================= #
  p family:  font_descriptor.Family.to_s,
    size:    font_descriptor.Size,
    weight:  font_descriptor.Weight,
    italic:  font_descriptor.Italic,
    stretch: font_descriptor.Stretch
}
main_window.close_properly
main_window.child = font_button
main_window.control_show
UI.main_then_quit
