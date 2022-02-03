#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'complex/001_hbox_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_padded_window(:filename, 500, 200)

hbox1 = ui_hbox
hbox1 << text('This is a hbox example.')
hbox1 << ui_entry
hbox1 << text('As can be seen we add elements in a horizontal (side-by-side) manner.')
window << hbox1
window.child = hbox1
window.intelligent_exit