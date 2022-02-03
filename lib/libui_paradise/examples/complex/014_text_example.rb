#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# '014_text_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_main_window('Text Example', 200, 100, 1)

outer_vbox = padded_vbox
text = ui_text

outer_vbox.minimal(text, 1)

text.set_text('Hello world!')
window.child = outer_vbox
window.intelligent_quit