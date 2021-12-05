#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '028_password_entry_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = margined_window('Password Entry Example', 280, 80, 0)

outer_vbox = padded_vbox
entry_containing_the_password = ui_password_entry
outer_vbox.minimal(ui_text('Password: '), 0)
outer_vbox.minimal(entry_containing_the_password, 0)

button = ui_button('Show the password')
button.on_clicked {
  _ = entry_containing_the_password.text?.to_s
  e _
  LibuiParadise.msg_box(window, _)
}
outer_vbox.minimal(button, 0)

window.child = outer_vbox
window.intelligent_quit