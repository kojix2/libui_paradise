#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example currently does not work.
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_window('Scrolling Area', 500, 300, 0)

outer_vbox = padded_vbox
text = ui_text('OK!')
scrolling_area = LibuiParadise.scrolling_area(text)
outer_vbox << scrolling_area
window.child = outer_vbox
window.intelligent_quit