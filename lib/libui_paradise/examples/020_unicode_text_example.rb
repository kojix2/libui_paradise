#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example just shows that unicode text works.
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = ui_margined_main_window('Unicode Text Example', 1200, 200, 15)

outer_vbox = ui_padded_vbox
text = ui_text(
"This is some text. You do not even have to wrap it - the newlines will
appear in the text as-is.

If something is supported then unicode should be able to show that.

Let's test this next with some unicode:

  🎉 用户界面 사용자 인터페이스
    ₀₁₂₃₄₅₆₇₈₉

")

outer_vbox << text

window.child = outer_vbox
window.intelligent_quit