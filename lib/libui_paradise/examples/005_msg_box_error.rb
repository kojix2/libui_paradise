#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

TITLE = 'msg box error'
main_window = UI.window(TITLE, 300, 200, 1)

button1 = UI.button('Text (click me)')
button1.on_clicked {
  UI.msg_box_error(
    main_window,
    'Error',
    "You clicked \nthe button"
  )
  0
}

hbox = UI.hbox
hbox.append(button1, 1)
main_window.close_properly
main_window.child = hbox
main_window.control_show
UI.main_then_quit