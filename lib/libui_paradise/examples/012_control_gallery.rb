#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

should_quit = proc {
  puts 'Bye Bye'
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
}

open_menu_item_clicked = proc do
  puts "Clicked 'Open'"
  0
end

save_menu_item_clicked = proc {
  puts "Clicked 'Save'"
  0
}

# Create 'File' menu with a few items and callbacks
# when the items are clicked
menu = UI.new_menu('File')
open_menu_item = UI.menu_append_item(menu, 'Open')
UI.menu_item_on_clicked(open_menu_item, open_menu_item_clicked, nil)
save_menu_item = UI.menu_append_item(menu, 'Save')
UI.menu_item_on_clicked(save_menu_item, save_menu_item_clicked, nil)
UI.menu_append_quit_item(menu)
UI.on_should_quit(should_quit, nil)

# =========================================================================== #
# Create the 'Edit' menu
# =========================================================================== #
edit_menu = UI.new_menu('Edit')
UI.menu_append_check_item(edit_menu, 'Checkable Item_')
UI.menu_append_separator(edit_menu)
disabled_item = UI.menu_append_item(edit_menu, 'Disabled Item_')
UI.menu_item_disable(disabled_item)

preferences = UI.menu_append_preferences_item(menu)

# =========================================================================== #
# Create the 'Help' menu
# =========================================================================== #
help_menu = UI.new_menu('Help')
UI.menu_append_item(help_menu, 'Help')
UI.menu_append_about_item(help_menu)

vbox = ui_padded_vbox
hbox = ui_padded_hbox
vbox.maximal(hbox)

group = UI.new_group('Basic Controls')
UI.group_set_margined(group, 1)
hbox.add(group, 0)

inner = ui_padded_vbox
UI.group_set_child(group, inner)

button = ui_button('Button')
button_clicked_callback = proc {
  ui_msg_box(MAIN_WINDOW, 'Information', 'You clicked the button')
  0
}
UI.button_on_clicked(button, button_clicked_callback, nil)
inner.minimal(button)

checkbox = ui_checkbox('Checkbox')
checkbox_toggle_callback = proc { |ptr|
  checked = UI.checkbox_checked(ptr) == 1
  UI.window_set_title(MAIN_WINDOW, "Checkbox is #{checked}")
  UI.checkbox_set_text(ptr, "I am the checkbox (#{checked})")
  0
}
UI.checkbox_on_toggled(checkbox, checkbox_toggle_callback, nil)
UI.box_append(inner, checkbox, 0)

UI.box_append(inner, UI.new_label('Label'), 0)
UI.box_append(inner, UI.new_horizontal_separator, 0)
UI.box_append(inner, UI.new_date_picker, 0)
UI.box_append(inner, UI.new_time_picker, 0)
UI.box_append(inner, UI.new_date_time_picker, 0)
UI.box_append(inner, UI.new_font_button, 0)
UI.box_append(inner, UI.new_color_button, 0)

inner2 = UI.vbox
UI.box_set_padded(inner2, 1)
UI.box_append(hbox, inner2, 1)

group = UI.new_group('Numbers')
UI.group_set_margined(group, 1)
UI.box_append(inner2, group, 0)

inner = ui_padded_vbox
UI.group_set_child(group, inner)

spinbox = ui_spinbox(0, 100)
# =========================================================================== #
# === spinbox_changed_callbac
#
# The function called when the spinbox is changed.
# =========================================================================== #
spinbox_changed_callback = proc { |ptr|
  puts "New Spinbox value: #{UI.spinbox_value(ptr)}"
  0
}
spinbox.set_value(42)
UI.spinbox_on_changed(spinbox, spinbox_changed_callback, nil)
inner.append(spinbox, 0)

slider = UI.new_slider(0, 100)
slider_changed_callback = proc { |ptr|
  puts "New Slider value: #{UI.slider_value(ptr)}"
  0
}
UI.slider_on_changed(slider, slider_changed_callback, nil)
UI.box_append(inner, slider, 0)

progressbar = UI.new_progress_bar
UI.box_append(inner, progressbar, 0)

group = UI.new_group('Lists')
UI.group_set_margined(group, 1)
UI.box_append(inner2, group, 0)

inner = ui_padded_vbox
UI.group_set_child(group, inner)

combobox_selected_callback = proc { |ptr|
  puts "New combobox selection: #{UI.combobox_selected(ptr)}"
}
cbox = ui_combobox
UI.combobox_append(cbox, 'combobox Item 1')
UI.combobox_append(cbox, 'combobox Item 2')
UI.combobox_append(cbox, 'combobox Item 3')
inner.add(cbox, 0)
UI.combobox_on_selected(cbox, combobox_selected_callback, nil)

# Show an editable combobox next:
ebox = ui_editable_combo_box
UI.editable_combobox_append(ebox, 'Editable Item 1')
UI.editable_combobox_append(ebox, 'Editable Item 2')
UI.editable_combobox_append(ebox, 'Editable Item 3')
inner.add(ebox, 0)

rb = ui_radio_buttons
UI.radio_buttons_append(rb, 'Radio Button 1')
UI.radio_buttons_append(rb, 'Radio Button 2')
UI.radio_buttons_append(rb, 'Radio Button 3')
inner.maximal(rb)

tab = ui_tab
hbox1 = ui_hbox
UI.tab_append(tab, 'Page 1', hbox1)
UI.tab_append(tab, 'Page 2', ui_hbox)
UI.tab_append(tab, 'Page 3', ui_hbox)
inner2.maximal(tab)

# =========================================================================== #
# === text_changed_callback
# =========================================================================== #
text_changed_callback = proc { |ptr|
  puts "Current textbox data: '#{UI.entry_text(ptr)}'"
}

text_entry = ui_entry
text_entry.set_text('Please enter your feelings')
text_entry.on_changed { text_changed_callback }
hbox1.append(text_entry, 1)

MAIN_WINDOW = UI.window('hello world', 600, 600, 1)
UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_set_child(MAIN_WINDOW, vbox)

UI.window_on_closing(MAIN_WINDOW, should_quit, nil)
MAIN_WINDOW.control_show
UI.main_then_quit