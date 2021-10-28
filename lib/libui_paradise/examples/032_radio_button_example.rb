#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '032_form_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = margined_window(:filename, 320, 200, 0)

outer_vbox = padded_vbox
array_to_use = ['Radio Button 1', 'Radio Button 2', 'Radio Button 3']
# =========================================================================== #
# Keep the buttons padded via hsep on top and on the bottom.
# =========================================================================== #

outer_vbox.minimal(hsep, 0)
rb = ui_radio_buttons(array_to_use)
outer_vbox.minimal(rb)
outer_vbox.minimal(hsep, 0)

window.child = outer_vbox
window.intelligent_quit