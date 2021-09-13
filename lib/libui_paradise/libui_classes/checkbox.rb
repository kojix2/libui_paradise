#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/checkbox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.checkbox                     (checkbox tag)
  # ========================================================================= #
  def self.checkbox(i = '')
    _ = UI.new_checkbox(i)
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === checkbox
  # ========================================================================= #
  def checkbox(i = '')
    ::LibuiParadise::Extensions.checkbox(i)
  end; alias ui_checkbox     checkbox # === ui_checkbox
       alias ui_check_button checkbox # === ui_check_button

end

# =========================================================================== #
# === LibuiParadise.checkbox
# =========================================================================== #
def self.checkbox(i = '')
  ::LibuiParadise::Extensions.checkbox(i)
end

end