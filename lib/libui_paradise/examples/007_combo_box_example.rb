#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

TITLE  = 'Combo Box Example'
WIDTH  = 500
HEIGHT = 250
main_window = ui_main_window(TITLE, WIDTH, HEIGHT, 0)

@entry = ui_entry

@combo_box = ui_combobox(
  [
    'combobox Item 1',
    'combobox Item 2',
    'combobox Item 3'
  ]
)

# =========================================================================== #
# The next code used to be in place until September 2021. I will retain it
# here in the event that we need to use it again one day.
# =========================================================================== #

# combobox_selected_callback = proc { |pointer|
#   e "New combobox selection: #{UI.combobox_selected(pointer)}"
#   @entry.set_text(selected?(pointer))
# }
# 
# UI.combobox_on_selected(@combo_box, combobox_selected_callback, nil)

ui_sync_connect(@combo_box, @entry)

box = padded_vbox
box.minimal(@combo_box)
box.minimal(@entry)

main_window.child = box
main_window.intelligent_exit