#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === 014_basic_draw_text.rb
# =========================================================================== #
# This example shows how to display coloured text.
# =========================================================================== #
require 'libui_paradise/autoinclude'

# =========================================================================== #
# === USE_THIS_FONT
#
# Specify a certain font to use.
# =========================================================================== #
USE_THIS_FONT = 'Georgia'

# =========================================================================== #
# === TITLE
# =========================================================================== #
TITLE = 'Michael Ende (1929-1995) The Neverending Story'

handler = UI::FFI::AreaHandler.malloc
area = UI.area(handler)

str1 = \
  '  At last Ygramul sensed that something was coming toward ' \
  'her. With the speed of lightning, she turned about, confronting ' \
  'Atreyu with an enormous steel-blue face. Her single eye had a ' \
  'vertical pupil, which stared at Atreyu with inconceivable malignancy. '

str2 = \
  '  A cry of fear escaped Bastian. '

str3 = \
  '  A cry of terror passed through the ravine and echoed from ' \
  'side to side. Ygramul turned her eye to left and right, to see if ' \
  'someone else had arrived, for that sound could not have been ' \
  'made by the boy who stood there as though paralyzed with ' \
  'horror. '

str4 = \
  '  Could she have heard my cry? Bastion wondered in alarm. ' \
  "But that's not possible. "

str5 = \
  '  And then Atreyu heard Ygramuls voice. It was very high ' \
  'and slightly hoarse, not at all the right kind of voice for that ' \
  'enormous face. Her lips did not move as she spoke. It was the ' \
  'buzzing of a great swarm of hornets that shaped itself into ' \
  'words. '

str = ''
attr_str = UI.new_attributed_string(str)

# =========================================================================== #
# Add an ad-hoc append method.
# =========================================================================== #
def attr_str.append(
    this_text,
    color
  )
  case color
  # =========================================================================== #
  # === :red
  # =========================================================================== #
  when :red # red colour
    use_this_colour = UI.new_color_attribute(0.0, 0.5, 0.0, 0.7)
  # =========================================================================== #
  # === :green  
  # =========================================================================== #
  when :green # green colour
    use_this_colour = UI.new_color_attribute(0.5, 0.0, 0.25, 0.7)
  end
  start = UI.attributed_string_len(self)
  # =========================================================================== #
  # Append the stuff next.
  # =========================================================================== #
  UI.attributed_string_append_unattributed(self, this_text)
  UI.attributed_string_set_attribute(self,
    use_this_colour,
    start,            # Start position.
    start + this_text.size # End position.
  )
  UI.attributed_string_append_unattributed(self, "\n\n")
end

attr_str.append(str1, :green)
attr_str.append(str2, :red)
attr_str.append(str3, :green)
attr_str.append(str4, :red)
attr_str.append(str5, :green)

handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) do |_, _, adp|
  area_draw_params = UI::FFI::AreaDrawParams.new(adp)
  # =========================================================================== #
  # Designate our font in use next.
  # =========================================================================== #
  default_font = UI::FFI::FontDescriptor.malloc
  default_font.Family = USE_THIS_FONT
  default_font.Size = 13
  default_font.Weight = 500
  default_font.Italic = 0
  default_font.Stretch = 4
  params = UI::FFI::DrawTextLayoutParams.malloc

  # UI.font_button_font(font_button, default_font)
  params.String = attr_str
  params.DefaultFont = default_font
  params.Width = area_draw_params.AreaWidth
  params.Align = 0
  text_layout = UI.text_layout(params)
  UI.draw_text(area_draw_params.Context, text_layout, 0, 0)
  UI.draw_free_text_layout(text_layout)
end

handler.Draw         = handler_draw_event
# Assigning to local variables
# This is intended to protect Fiddle::Closure from garbage collection.
handler.MouseEvent   = (c1 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.MouseCrossed = (c2 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.DragBroken   = (c3 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.KeyEvent     = (c4 = Fiddle::Closure::BlockCaller.new(0, [0]) {})

box = UI.vbox
box.set_padded(1)
box.add(area, 1)

main_window = UI.window(TITLE, 600, 400, 1)
UI.window_set_margined(main_window, 1)
main_window.child = box
main_window.close_properly
main_window.control_show
UI.main_then_quit
