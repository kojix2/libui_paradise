#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/complex/013_form_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = margined_window('Form Example', 250, 150, 0)

outer_vbox = padded_vbox

hbox1 = padded_hbox
hbox1.minimal(text('First Name'), 0)
@first_name_entry = entry
hbox1.minimal(@first_name_entry, 0)
outer_vbox.minimal(hbox1, 0)

hbox2 = padded_hbox
hbox2.minimal(text('Last Name'), 0)
@last_name_entry = entry
hbox2.minimal(@last_name_entry, 0)
outer_vbox.minimal(hbox2, 0)

button_display_name = button('Display Name')
button_display_name.on_clicked {
  ui_msg_box(
    :default,
    'Name',
    "#{@first_name_entry.text?} #{@last_name_entry.text?}"
  )
}

outer_vbox.minimal(hsep, 0)
outer_vbox.minimal(button_display_name, 1)

window.child = outer_vbox
window.intelligent_quit