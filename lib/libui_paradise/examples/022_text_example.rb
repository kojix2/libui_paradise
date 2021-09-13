#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('Text Example', 200, 100, 1)

outer_vbox = ui_padded_vbox
text = ui_text

outer_vbox << text

text.set_text('Hello world!')
window.child = outer_vbox
window.intelligent_quit