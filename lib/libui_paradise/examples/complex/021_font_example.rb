#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === 021_font_example.rb
# =========================================================================== #
# This example shows how to display coloured text.
#
# An AttributedString is a string which also contains information
# about styles such as text color, font, font size. It will be
# drawn in an UiArea element.
# =========================================================================== #
# require 'libui_paradise/examples/complex/021_font_example.rb'
# =========================================================================== #
class FontExample

  require 'libui_paradise'
  include LibuiParadise::Extensions

  # ========================================================================= #
  # === USE_THIS_FONT
  #
  # Specify a certain font to use.
  # ========================================================================= #
  USE_THIS_FONT = 'Georgia'

  # ========================================================================= #
  # === USE_THIS_FONT_SIZE
  # ========================================================================= #
  USE_THIS_FONT_SIZE = 25

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Font Example'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 500

  # ========================================================================= #
  # === initialize
  # ========================================================================= #
  def initialize(
      run_already = true
    )
    run if run_already
  end

  # ========================================================================= #
  # === run
  # ========================================================================= #
  def run
    handler = LibUI::FFI::AreaHandler.malloc
    area    = LibUI.new_area(handler)
    str1 = 'At last Ygramul sensed that something was coming toward her.'
    attr_str = LibuiParadise.fancy_text('')
    def attr_str.append(what)
      color_attribute = LibUI.new_color_attribute(0.5, 0.0, 0.25, 0.7)
      start = LibUI.attributed_string_len(self)
      LibUI.attributed_string_append_unattributed(self, what)
      LibUI.attributed_string_set_attribute(self, color_attribute, start, start + what.size)
      LibUI.attributed_string_append_unattributed(self, "\n\n")
    end
    attr_str.append(str1)
    handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) { |_, _, adp|
      area_draw_params = LibUI::FFI::AreaDrawParams.new(adp)
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
      text_layout = LibUI.draw_new_text_layout(params)
      LibUI.draw_text(area_draw_params.Context, text_layout, 0, 0)
      LibUI.draw_free_text_layout(text_layout)
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

    main_window = ui_main_window(TITLE, WIDTH, 400, 1)
    LibUI.window_set_margined(main_window, 1)
    main_window.child = box
    main_window.simple_exit
    main_window.control_show
    main_window.intelligent_exit
  end

end

if __FILE__ == $PROGRAM_NAME
  FontExample.new
end