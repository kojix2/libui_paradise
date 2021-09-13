#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_main_window('A notebook with tabs example', 1200, 200, 15)

tab = ui_tabs
tab.add('Page 1', ui_hbox)
tab.add('Page 2', ui_hbox)
tab.add('Page 3', ui_hbox)
tab.add('Page 4', ui_hbox)
tab.add('Page 5', ui_hbox)
tab.add('Page 6', ui_hbox)

box = ui_padded_vbox
box.maximal(tab)

window.child = box
window.control_show
window.intelligent_exit