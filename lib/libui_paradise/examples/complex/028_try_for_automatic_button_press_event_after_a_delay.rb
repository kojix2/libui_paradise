#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '020_checkbox_example'
# =========================================================================== #
require 'libui_paradise/autoinclude'

# =========================================================================== #
# === HEIGHT
# =========================================================================== #
HEIGHT = 120

should_quit_callback = proc {
  LibUI.control_destroy(MAIN_WINDOW)
  LibUI.quit
  0
}

MAIN_WINDOW = LibUI.window('Try for automatic button press event after a delay', 600, HEIGHT, 1)
vbox = LibUI.vbox
LibUI.box_set_padded(vbox, 1)
button1 = LibUI.new_button('Testing')

LibUI.button_on_clicked(button1) do
  the_button_was_clicked
end

LibUI.box_append(vbox, button1, 0)

LibUI.window_set_margined(MAIN_WINDOW, 1)
LibUI.window_set_child(MAIN_WINDOW, vbox)
LibUI.window_on_closing(MAIN_WINDOW, should_quit_callback, nil)
Thread.new {
  sleep 3
  the_button_was_clicked
}

# =========================================================================== #
# === the_button_was_clicked
# =========================================================================== #
def the_button_was_clicked
  LibUI.msg_box(MAIN_WINDOW, 'Information', 'You clicked the button!')
end

MAIN_WINDOW.control_show
LibUI.main_then_quit