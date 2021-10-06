#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# The upstream API in C can be found here:
#
#   https://github.com/andlabs/libui/blob/master/unix/colorbutton.c
#
# =========================================================================== #
# require 'libui_paradise/ui_classes/color_button.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.new_colour_button
  # ========================================================================= #
  def self.colour_button
    _ = LibUI.new_color_button
    ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias new_colour_button colour_button } # === LibuiParadise::Extensions.new_colour_button
       self.instance_eval { alias new_color_button  colour_button } # === LibuiParadise::Extensions.new_color_button
       self.instance_eval { alias ui_colour_button  colour_button } # === LibuiParadise::Extensions.ui_colour_button

  # ========================================================================= #
  # === colour_button
  # ========================================================================= #
  def colour_button
    ::LibuiParadise::Extensions.new_colour_button
  end; alias color_button     colour_button # === color_button
       alias ui_colour_button colour_button # === ui_color_button

end

# =========================================================================== #
# === LibuiParadise.colour_button
# =========================================================================== #
def self.colour_button
  ::LibuiParadise::Extensions.new_colour_button
end; self.instance_eval { alias color_button colour_button } # === LibuiParadise.color_button

end