#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '028_password_entry_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = margined_window('Password Entry Example', 280, 80, 0)

outer_vbox = padded_vbox
entry = ui_password_entry
outer_vbox.minimal(ui_text('Password: '), 0)
outer_vbox.minimal(entry, 0)

window.child = outer_vbox
window.intelligent_quit