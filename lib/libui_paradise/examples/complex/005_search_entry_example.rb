#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '005_search_entry_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('A search-entry example', 1200, 200, 15)

search_entry = ui_search_entry
box = ui_padded_vbox
box << search_entry
box.is_padded

window.child = box
window.control_show
window.intelligent_exit
