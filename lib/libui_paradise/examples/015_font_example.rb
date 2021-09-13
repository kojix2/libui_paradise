#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === 015_font_example_text.rb
# =========================================================================== #
# This example shows how to display coloured text.
#
# An AttributedString is a string which also contains information
# about styles such as text color, font, font size. It will be
# drawn in an UiArea element.
# =========================================================================== #
require 'libui_paradise/autoinclude'

# =========================================================================== #
# === USE_THIS_FONT
#
# Specify a certain font to use.
# =========================================================================== #
USE_THIS_FONT = 'Georgia'

# =========================================================================== #
# === USE_THIS_FONT_SIZE
# =========================================================================== #
USE_THIS_FONT_SIZE = 25

# =========================================================================== #
# === TITLE
# =========================================================================== #
TITLE = 'Font Example'

handler = UI::FFI::AreaHandler.malloc
area    = UI.new_area(handler)

str1 = 'At last Ygramul sensed that something was coming toward her.'

attr_str = fancy_text('')

def attr_str.append(what)
  color_attribute = UI.new_color_attribute(0.5, 0.0, 0.25, 0.7)
  start = UI.attributed_string_len(self)
  UI.attributed_string_append_unattributed(self, what)
  UI.attributed_string_set_attribute(self, color_attribute, start, start + what.size)
  UI.attributed_string_append_unattributed(self, "\n\n")
end

attr_str.append(str1)

handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) { |_, _, adp|
  area_draw_params = UI::FFI::AreaDrawParams.new(adp)
  default_font = font {{
    font_size:   USE_THIS_FONT_SIZE,
    font_family: USE_THIS_FONT,
    italic:      false,
    stretch:     2,
    weight:      500
  }}

  params = ui_draw_text_layout_params

  params.String = attr_str
  params.DefaultFont = default_font
  params.Width = area_draw_params.AreaWidth
  params.Align = 0
  text_layout = UI.draw_new_text_layout(params)
  UI.draw_text(area_draw_params.Context, text_layout, 0, 0)
  UI.draw_free_text_layout(text_layout)
}

# =========================================================================== #
# Assigning to local variables:
#
# This is intended to protect Fiddle::Closure from garbage collection.
#
# =========================================================================== #
handler.Draw         = handler_draw_event
handler.MouseEvent   = (c1 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.MouseCrossed = (c2 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
# handler.DragBroken   = (c3 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
# handler.KeyEvent     = (c4 = Fiddle::Closure::BlockCaller.new(0, [0]) {})

box = ui_padded_vbox
box.maximal(area)
box.maximal(ui_hseparator)

main_window = ui_main_window(TITLE, 600, 400, 1)
UI.window_set_margined(main_window, 1)
main_window.child = box
main_window.simple_exit
main_window.control_show
main_window.intelligent_exit