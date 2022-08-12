#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require '003_fancy_text_example.rb'
# =========================================================================== #
require 'libui'

UI = LibUI
UI.init

# =========================================================================== #
# === WIDTH
# =========================================================================== #
WIDTH = 1000

# =========================================================================== #
# === USE_THIS_FONT
# =========================================================================== #
USE_THIS_FONT = 'Hack' # Or 'Courier New'.

# =========================================================================== #
# === append_with_attribute
# =========================================================================== #
def append_with_attribute(attr_str, what, attr1, attr2)
  start_pos = LibUI.attributed_string_len(attr_str)
  end_pos = start_pos + what.length
  LibUI.attributed_string_append_unattributed(attr_str, what)
  LibUI.attributed_string_set_attribute(attr_str, attr1, start_pos, end_pos)
  LibUI.attributed_string_set_attribute(attr_str, attr2, start_pos, end_pos) if attr2
end

# =========================================================================== #
# === make_attribute_string
#
# Create a new attributed string.
# =========================================================================== #
def make_attribute_string
  attr_str = LibUI.new_attributed_string(
    "Drawing strings with libui is done with the "\
    "uiAttributedString and uiDrawTextLayout objects.\n" \
     'uiAttributedString lets you have a variety of attributes: '
  )

  attr1 = LibUI.new_family_attribute(USE_THIS_FONT)
  append_with_attribute(attr_str, 'font family', attr1, nil)
  LibUI.attributed_string_append_unattributed(attr_str, ', ')

  # ========================================================================= #
  # === Use a bigger font next
  # ========================================================================= #
  bigger_font = UI.new_size_attribute(45)
  append_with_attribute(attr_str, 'font size', bigger_font, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  # ========================================================================= #
  # === Make bold text next                                        (bold tag)
  # ========================================================================= #
  attr1 = LibUI.new_weight_attribute(LibUI::TextWeightBold)
  append_with_attribute(attr_str, 'font weight', attr1, nil)
  LibUI.attributed_string_append_unattributed(attr_str, ', ')

  attr1 = LibUI.new_italic_attribute(UI::TextItalicItalic)
  append_with_attribute(attr_str, 'font italicness', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  attr1 = LibUI.new_stretch_attribute(UI::TextStretchCondensed)
  append_with_attribute(attr_str, 'font stretch', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  # ========================================================================= #
  # Influence the text-colour via RGB values.
  # ========================================================================= #
  attr1 = LibUI.new_color_attribute(0.75, 0.25, 0.5, 0.75)
  append_with_attribute(attr_str, 'text color', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  attr1 = LibUI.new_background_attribute(0.5, 0.5, 0.25, 0.5)
  append_with_attribute(attr_str, 'text background color', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  attr1 = UI.new_underline_attribute(UI::UnderlineSingle)
  append_with_attribute(attr_str, 'underline style', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ', ')

  UI.attributed_string_append_unattributed(attr_str, 'and ')
  attr1 = LibUI.new_underline_attribute(UI::UnderlineDouble)
  attr2 = LibUI.new_underline_color_attribute(UI::UnderlineColorCustom, 1.0, 0.0, 0.5, 1.0)
  append_with_attribute(attr_str, 'underline color', attr1, attr2)
  UI.attributed_string_append_unattributed(attr_str, '. ')

  UI.attributed_string_append_unattributed(attr_str, 'Furthermore, there are attributes allowing for ')
  attr1 = LibUI.new_underline_attribute(UI::UnderlineSuggestion)
  attr2 = LibUI.new_underline_color_attribute(UI::UnderlineColorSpelling, 0, 0, 0, 0)
  append_with_attribute(attr_str, 'special underlines for indicating spelling errors', attr1, attr2)
  UI.attributed_string_append_unattributed(attr_str, ' (and other types of errors) ')

  UI.attributed_string_append_unattributed(attr_str,
                                           'and control over OpenType features such as ligatures (for instance, ')
  otf = UI.new_open_type_features
  UI.open_type_features_add(otf, 'l', 'i', 'g', 'a', 0)
  attr1 = UI.new_features_attribute(otf)
  append_with_attribute(attr_str, 'afford', attr1, nil)
  UI.attributed_string_append_unattributed(attr_str, ' vs. ')
  UI.open_type_features_add(otf, 'l', 'i', 'g', 'a', 1)
  attr1 = UI.new_features_attribute(otf)
  append_with_attribute(attr_str, 'afford', attr1, nil)
  UI.free_open_type_features(otf)
  UI.attributed_string_append_unattributed(attr_str, ").\n")

  UI.attributed_string_append_unattributed(attr_str,
                                           'Use the controls '\
                                           'opposite to the text '\
                                           'to control properties of the text.')
  attr_str
end

# =========================================================================== #
# === on_font_changed
# =========================================================================== #
def on_font_changed(area)
  UI.area_queue_redraw_all(area)
end

# =========================================================================== #
# === on_combobox_selected
# =========================================================================== #
def on_combobox_selected(area)
  UI.area_queue_redraw_all(area)
end

# === draw_event
def draw_event(adp, attr_str, font_button, alignment)
  area_draw_params = UI::FFI::AreaDrawParams.new(adp)
  default_font = UI::FFI::FontDescriptor.malloc
  default_font.to_ptr.free = Fiddle::RUBY_FREE
  default_font = UI::FFI::FontDescriptor.malloc
  default_font.to_ptr.free = Fiddle::RUBY_FREE
  params = UI::FFI::DrawTextLayoutParams.malloc
  params.to_ptr.free = Fiddle::RUBY_FREE

  params.String = attr_str
  UI.font_button_font(font_button, default_font)
  params.DefaultFont = default_font
  params.Width = area_draw_params.AreaWidth
  params.Align = UI.combobox_selected(alignment)
  text_layout = UI.draw_new_text_layout(params)
  UI.draw_text(area_draw_params.Context, text_layout, 0, 0)
  UI.draw_free_text_layout(text_layout)
  UI.free_font_button_font(default_font)
end

UI.init

handler = UI::FFI::AreaHandler.malloc
handler.to_ptr.free = Fiddle::RUBY_FREE
handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) do |_, _area, adp|
  draw_event(adp, @attr_str, @font_button, @alignment)
end

handler.Draw = handler_draw_event

do_nothing = Fiddle::Closure::BlockCaller.new(0, [0]) {}
key_event  = Fiddle::Closure::BlockCaller.new(1, [0]) { 0 }
handler.MouseEvent   = do_nothing
handler.MouseCrossed = do_nothing
handler.DragBroken   = do_nothing
handler.KeyEvent     = key_event

LibUI.on_should_quit {
  LibUI.control_destroy(main_window)
}

# =========================================================================== #
# Assign to the main attributed string next.
# =========================================================================== #
@attr_str = make_attribute_string

main_window = LibUI.new_window('Text-Drawing Example', WIDTH, 480, 1)
LibUI.window_set_margined(main_window, 1)
LibUI.window_on_closing(main_window) {
  LibUI.control_destroy(main_window)
  LibUI.quit
  0
}

hbox = LibUI.new_horizontal_box
LibUI.box_set_padded(hbox, 1)
LibUI.window_set_child(main_window, hbox)

vbox = LibUI.new_vertical_box
LibUI.box_set_padded(vbox, 1)
LibUI.box_append(hbox, vbox, 0)

@font_button = LibUI.new_font_button
LibUI.font_button_on_changed(@font_button) { on_font_changed(@area) }
LibUI.box_append(vbox, @font_button, 0)

form = LibUI.new_form
LibUI.form_set_padded(form, 1)
LibUI.box_append(vbox, form, 0)

# Add a combobox entry next.
# @alignment = ui_combobox(%w( Left Center Right ))
@alignment = LibUI.new_combobox
LibUI.combobox_append(@alignment, 'Left')
LibUI.combobox_append(@alignment, 'Center')
LibUI.combobox_append(@alignment, 'Right')
LibUI.combobox_set_selected(@alignment, 0)
LibUI.combobox_on_selected(@alignment) { on_combobox_selected(@area) }
LibUI.form_append(form, 'Alignment', @alignment, 0)

@area = LibUI.new_area(handler)
LibUI.box_append(hbox, @area, 1)

LibUI.control_show(main_window)
LibUI.main

LibUI.free_attributed_string(@attr_str)
LibUI.uninit
