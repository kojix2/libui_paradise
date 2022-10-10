#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise'

text1 = LibuiParadise.text('Some text here.')
text2 = LibuiParadise.text('Some text there.')

::LibuiParadise.run_in_the_background

LibuiParadise.generic_window(
  text1,
  text2,
  :create_a_quit_button # Ad-hoc create a quit-button.
) {{
  width:  620,
  height: 220,
  title:  'This is just a test! It should show this as title.'
}}
