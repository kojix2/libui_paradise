#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

use_this_config_file = '023_parse_config_file_example.config'
window = LibuiParadise.parse_this_config_file(use_this_config_file)
outer_vbox = padded_vbox
text = text('The config file was '+use_this_config_file)
outer_vbox << text
window.child = outer_vbox
window.intelligent_quit