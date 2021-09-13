#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example currently does not work.
# =========================================================================== #
require 'libui_paradise/autoinclude'

main_window = UI.main_window('A fancy test example', 1200, 200, 15)

string = UI.new_attributed_string
attribute = UI.new_color_attribute(0.75, 0.25, 0.5, 0.75)
UI.attributed_string_append_unattributed('text color', attribute)

vbox = UI.vbox
vbox.add(attribute)

main_window.child = vbox
main_window.control_show
main_window.simple_exit
UI.main_then_quit