#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/radio_buttons.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.radio_buttons
  # ========================================================================= #
  def self.radio_buttons
    _ = UI.new_radio_buttons
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_radio_buttons radio_buttons } # === LibuiParadise::Extensionsui_radio_buttons

  # ========================================================================= #
  # === radio_buttons
  # ========================================================================= #
  def radio_buttons
    return ::LibuiParadise::Extensions.radio_buttons
  end; alias ui_radio_buttons radio_buttons # === ui_radio_buttons

end

# =========================================================================== #
# === LibuiParadise.radio_buttons
# =========================================================================== #
def self.radio_buttons
  return ::LibuiParadise::Extensions.radio_buttons
end

end