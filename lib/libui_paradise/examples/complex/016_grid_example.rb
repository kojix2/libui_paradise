#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example shows how to use the grid-related aspects of ruby-libui.
# =========================================================================== #
# require 'libui_paradise/016_grid_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = padded_main_window('A simple grid-example', 1200, 200, 15)

grid = ui_padded_grid
UI.grid_append(grid, text('Yo1'), 0, 0, 1, 1, 0, 0, 1, 0)
UI.grid_append(grid, text('Yo2'), 1, 0, 1, 1, 0, 0, 1, 0)
UI.grid_append(grid, text('Yo3'), 2, 0, 1, 1, 0, 0, 1, 0)

UI.grid_append(grid, text('Yo4'), 0, 1, 1, 1, 0, 0, 1, 0)
UI.grid_append(grid, text('Yo5'), 1, 1, 1, 1, 0, 0, 1, 0)
UI.grid_append(grid, text('Yo6'), 2, 1, 1, 1, 0, 0, 1, 0)

grid.hash_grid(
  text('Yo7'),
  { left: 2, top: 3, xspan: 3, yspan: 3, hexpand: 0, halign: 0, vexpand: 0, valign: 0 }
)

vbox = padded_vbox
vbox << grid

window.child = vbox
window.intelligent_exit