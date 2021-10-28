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
  #
  # This method will create some radio buttons.
  #
  # You can pass an Array into this method, which should be an Array of
  # Strings. This is optional. If such an Array is given, though, then
  # these entries will become radio-buttons, with the associated label
  # (the text they display) becoming the label right next to the radio
  # button element (that round circle that the user can select via
  # the mouse cursor).
  # ========================================================================= #
  def self.radio_buttons(
      optional_array = []
    )
    _ = UI.new_radio_buttons
    if optional_array and optional_array.is_a?(Array) and !optional_array.empty?
      optional_array.each {|this_element|
        LibUI.radio_buttons_append(_, this_element)
      }
    end
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_radio_buttons radio_buttons } # === LibuiParadise::Extensionsui_radio_buttons

  # ========================================================================= #
  # === radio_buttons
  # ========================================================================= #
  def radio_buttons(optional_array = [])
    return ::LibuiParadise::Extensions.radio_buttons(optional_array)
  end; alias ui_radio_buttons radio_buttons # === ui_radio_buttons

end

# =========================================================================== #
# === LibuiParadise.radio_buttons
# =========================================================================== #
def self.radio_buttons(optional_array = [])
  return ::LibuiParadise::Extensions.radio_buttons(optional_array)
end

end