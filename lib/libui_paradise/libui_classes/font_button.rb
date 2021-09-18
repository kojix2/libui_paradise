#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/font_button.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.font_button
  #
  # Create a new font button via this method.
  # ========================================================================= #
  def self.font_button
    _ = UI.new_font_button
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_font_button font_button } # === Libuiparadise::Extensions.ui_font_button

  # ========================================================================= #
  # === font_button
  #
  # Create a new font button via this method.
  # ========================================================================= #
  def font_button
    return ::LibuiParadise::Extensions.font_button
  end; alias ui_font_button font_button # === ui_font_button

end

# =========================================================================== #
# === LibuiParadise.font_button
# =========================================================================== #
def self.font_button
  return ::LibuiParadise::Extensions.font_button
end

end