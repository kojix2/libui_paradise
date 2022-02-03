#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# 024_text_view_example.rb
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_main_window('Text View Example', 500, 300, 0)

outer_vbox = padded_vbox
text = multiline_entry('Hello world! This is set to read only.')
text.is_read_only
outer_vbox.minimal(text, 1)
window.child = outer_vbox
window.intelligent_quit