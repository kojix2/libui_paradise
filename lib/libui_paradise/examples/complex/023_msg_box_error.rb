#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '005_msg_box_error.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

TITLE = 'msg box error'
main_window = ui_padded_window(TITLE, 300, 200, 1)

button1 = ui_button('Text (click me)')
button1.on_clicked {
  LibuiParadise::Extensions.message_box_error(
    main_window,
    'Error',
    "You clicked \nthe button"
  )
  0
}

hbox = padded_hbox
hbox << button1
main_window.close_properly
main_window.child = hbox
main_window.control_show
UI.main_then_quit