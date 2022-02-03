#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '002_tabs_example.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'
#require 'libui_paradise/requires/require_the_libui_paradise_project.rb'

window = ui_main_window('A notebook with tabs example', 1200, 200, 15)

tab = ui_tabs
tab.add('Page 1', hbox(text('One! 😎️')))
tab.add('Page 2', hbox(text('Two! 😍️')))
tab.add('Page 3', hbox(text('Three! 😘️')))
tab.add('Page 4', hbox(text('Four! 😗️')))
tab.add('Page 5', hbox(text('Five! 😙️')))
tab.add('Page 6', hbox(text('Six! 😚️')))

box = ui_padded_vbox
box << tab

window.child = box
window.control_show
window.intelligent_exit