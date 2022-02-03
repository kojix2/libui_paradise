#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/009_separator_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = margined_window(:filename, 250, 150, 0)

outer_vbox = padded_vbox

button_hello_world = button('A button')
button_hello_world.on_clicked {
  e 'Hello world!'
}

outer_vbox.minimal(hsep, 1)
outer_vbox.minimal(hsep, 0)
outer_vbox.minimal(button_hello_world, 1)
outer_vbox.minimal(hsep, 0)
outer_vbox.minimal(hsep, 1)

window.child = outer_vbox
window.intelligent_quit