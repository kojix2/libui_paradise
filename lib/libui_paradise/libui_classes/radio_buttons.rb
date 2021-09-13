#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/radio_buttons.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === radio_buttons
  # ========================================================================= #
  def radio_buttons
    _ = UI.new_radio_buttons
    add_to_the_registered_widgets(_, __method__)
    return _
  end; alias ui_radio_buttons radio_buttons # === ui_radio_buttons

end; end