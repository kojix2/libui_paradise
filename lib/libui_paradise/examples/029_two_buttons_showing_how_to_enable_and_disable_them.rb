#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '029_two_buttons_showing_how_to_enable_and_disable_them.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

main_window = padded_main_window(
  'Two buttons showing how to enable and disable them', 300, 60, 0
)

outer_hbox = padded_hbox

button1 = button('Button #1')
button2 = button('Button #2')
button2.disable # Start-state for this button.

outer_hbox.minimal(button1, 1)
outer_hbox.minimal(button2, 1)

button1.on_clicked {|widget|
  button2.enable
  button1.disable
}
button2.on_clicked {|widget|
  button1.enable
  button2.disable
}

main_window.child = outer_hbox
main_window.intelligent_exit
