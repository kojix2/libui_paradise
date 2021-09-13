#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

main_window = ui_main_window('hello world', 300, 200, 1)

button = ui_button('Button')
button.on_clicked {|widget| # is a <Fiddle::Pointer:0x00005590774f1ca0 ptr=0x0000559077484c90 size=0 free=0x0000000000000000>
  e 'The button was clicked.'
  ui_msg_box(main_window, 'Information', 'You clicked the button')
  0
}

main_window.child = button
main_window.intelligent_exit