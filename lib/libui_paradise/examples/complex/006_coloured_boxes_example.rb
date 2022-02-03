#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/complex/006_coloured_boxes_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

require 'colours' # Needs the colours gem.

window = ui_main_window('Coloured boxes example', 320, 200, 1)

outer_hbox = ui_hbox
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, Colours.random_html_colour)
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, :seagreen)
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, :springgreen)
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, :royalblue)
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, :lightblue)
outer_hbox.maximal LibuiParadise.draw_rectangle(:default, :default, :steelblue)

window.add(outer_hbox)
window.intelligent_quit