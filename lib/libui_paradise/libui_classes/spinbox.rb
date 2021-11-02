#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/spinbox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.spinbox
  #
  # This method will return a spin-button, also called a spin-box.
  # ========================================================================= #
  def self.spinbox(
      start_point = 0,
      end_point   = 100
    )
    _ = UI.new_spinbox(start_point.to_i, end_point.to_i)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_spinbox    spinbox } # === LibuiParadise::Extensions.ui_spinbox
       self.instance_eval { alias ui_spinbutton spinbox } # === LibuiParadise::Extensions.ui_spinbutton
       self.instance_eval { alias spinbutton    spinbox } # === LibuiParadise::Extensions.spinbutton

  # ========================================================================= #
  # === spinbox
  #
  # This method will return a spin-button, also called a spin-box.
  # ========================================================================= #
  def spinbox(
      start_point = 0,
      end_point   = 100
    )
    ::LibuiParadise::Extensions.spinbox(start_point, end_point)
  end; alias ui_spinbox          spinbox # === ui_spinbox
       alias ui_spinbutton       spinbox # === ui_spinbutton
       alias spinbutton          spinbox # === spinbutton
       alias up_and_down_counter spinbox # === up_and_down_counter

end

# =========================================================================== #
# === LibuiParadise.spinbox
# =========================================================================== #
def self.spinbox(
    start_point = 0,
    end_point   = 100
  )
  ::LibuiParadise::Extensions.spinbox(start_point, end_point)
end; self.instance_eval { alias ui_spinbox    spinbox } # === LibuiParadise.ui_spinbox
     self.instance_eval { alias ui_spinbutton spinbox } # === LibuiParadise.ui_spinbutton
     self.instance_eval { alias spinbutton    spinbox } # === LibuiParadise.spinbutton

end