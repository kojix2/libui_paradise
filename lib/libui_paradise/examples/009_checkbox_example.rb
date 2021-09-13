#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

should_quit_callback = proc {
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
}

open_menu_item_clicked = proc {
  puts "Clicked 'Open'"
  0
}

save_menu_item_clicked = proc {
  puts "Clicked 'Save'"
  0
}

# =========================================================================== #
# Create 'File' menu with a few items and callbacks when the items are
# clicked.
# =========================================================================== #
menu = UI.menu('File')
open_menu_item = UI.menu_append_item(menu, 'Open')
UI.menu_item_on_clicked(open_menu_item, open_menu_item_clicked, nil)
save_menu_item = UI.menu_append_item(menu, 'Save')
UI.menu_item_on_clicked(save_menu_item, save_menu_item_clicked, nil)
UI.menu_append_quit_item(menu)
UI.on_should_quit(should_quit_callback, nil)

# =========================================================================== #
# Create 'Edit' menu
# =========================================================================== #
edit_menu = UI.new_menu('Edit')
UI.menu_append_check_item(edit_menu, 'Checkable Item_')
UI.menu_append_separator(edit_menu)
disabled_item = UI.menu_append_item(edit_menu, 'Disabled Item_')
UI.menu_item_disable(disabled_item)

preferences = UI.menu_append_preferences_item(menu)

help_menu = UI.menu('Help')
UI.menu_append_item(help_menu, 'Help')
UI.menu_append_about_item(help_menu)

vbox = UI.vbox

a_hbox = UI.hbox
UI.box_set_padded(vbox, 1)
UI.box_set_padded(a_hbox, 1)

vbox.add(a_hbox, 1)

group = UI.new_group('Top Group')
UI.group_set_margined(group, 1)
a_hbox.add(group, 0)

inner = UI.vbox
UI.box_set_padded(inner, 1)
UI.group_set_child(group, inner)

checkbox = UI.checkbox('Checkbox')
checkbox_toggle_callback = proc { |ptr|
  checked = UI.checkbox_checked(ptr) == 1
  UI.checkbox_set_text(ptr, "I am the checkbox (#{checked})")
}

UI.checkbox_on_toggled(checkbox, checkbox_toggle_callback, nil)
inner.add(checkbox, 0)

MAIN_WINDOW = UI.window('hello world', 600, 600, 1)

UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_set_child(MAIN_WINDOW, vbox)

UI.window_on_closing(MAIN_WINDOW, should_quit_callback, nil)
MAIN_WINDOW.control_show
UI.main_then_quit