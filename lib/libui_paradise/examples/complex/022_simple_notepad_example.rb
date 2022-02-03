#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/022_simple_notepad_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_window('Notepad', 500, 300, 1)

vbox = ui_vbox

text_view = ui_text_view
text_view.set_text(
  "This is an example.\nAs can be seen, text has been assigned to this.\n"
)
vbox << text_view
button_show_content = button('Paste the content of the text-buffer above')
button_show_content.on_clicked {
  e text_view.text?.to_s
}

vbox << button_show_content
window.child = vbox
window.intelligent_exit