#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

TITLE = 'Combo Box Example'
main_window = ui_main_window(TITLE, 300, 200, 1)

combobox_selected_callback = proc { |ptr|
  e "New combobox selection: #{UI.combobox_selected(ptr)}"
}
combo_box = ui_combobox(
  ['combobox Item 1', 'combobox Item 2', 'combobox Item 3']
)

UI.combobox_on_selected(combo_box, combobox_selected_callback, nil)

hbox = ui_padded_hbox
hbox.add(combo_box, 1)

main_window.child = hbox
main_window.intelligent_exit