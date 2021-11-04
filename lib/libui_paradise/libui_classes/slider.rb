#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/slider.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.slider
  # ========================================================================= #
  def self.slider(
      start_value =   0,
      end_value   = 100
    )
    _ = LibUI.new_slider(start_value, end_value)
    # ======================================================================= #
    # Register it at once:
    # ======================================================================= #
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_slider slider } # === LibuiParadise::Extensions.ui_slider

  # ========================================================================= #
  # === slider
  # ========================================================================= #
  def slider(
      start_value =   0,
      end_value   = 100
    )
    return ::LibuiParadise::Extensions.slider(start_value, end_value)
  end; alias ui_slider slider # === ui_slider

end

# =========================================================================== #
# === LibuiParadise.slider
# =========================================================================== #
def self.slider(
    start_value =   0,
    end_value   = 100
  )
  ::LibuiParadise::Extensions.slider(start_value, end_value)
end; self.instance_eval { alias ui_slider slider } # === LibuiParadise.ui_slider

end