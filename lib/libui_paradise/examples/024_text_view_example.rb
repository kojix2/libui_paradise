#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# 024_text_view_example.rb
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('Text View Example', 500, 300, 0)

outer_vbox = ui_padded_vbox
text = multiline_entry
text.set_text('Hello world! This is set to read only.')
LibUI.multiline_entry_set_read_only(text, 1)
outer_vbox << text
window.child = outer_vbox
window.intelligent_quit