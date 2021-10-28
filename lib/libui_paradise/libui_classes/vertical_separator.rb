#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/vertical_separator.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.vertical_separator
  #
  # This method will add a new vertical separator.
  # ========================================================================= #
  def self.vertical_separator
    UI.new_vertical_separator
  end; self.instance_eval { alias ui_vseparator     vertical_separator } # === LibuiParadise::Extensions.ui_verticalseparator
       self.instance_eval { alias ui_vsep           vertical_separator } # === LibuiParadise::Extensions.ui_vsep
       self.instance_eval { alias vspacer           vertical_separator } # === LibuiParadise::Extensions.vspacer
       self.instance_eval { alias vertical_spacer   vertical_separator } # === LibuiParadise::Extensions.vertical_spacer
       self.instance_eval { alias vsep              vertical_separator } # === LibuiParadise::Extensions.vsept

  # ========================================================================= #
  # === vertical_separator
  # ========================================================================= #
  def vertical_separator
    ::LibuiParadise::Extensions.vertical_separator
  end; alias ui_vseparator     vertical_separator # === ui_vseparator
       alias ui_vsep           vertical_separator # === ui_vsep
       alias vertical_spacer   vertical_separator # === vertical_spacer
       alias vspacer           vertical_separator # === vspacer
       alias vsep              vertical_separator # === vsep

end

# ========================================================================= #
# === LibuiParadise.vertical_separator
# ========================================================================= #
def self.vertical_separator
  ::LibuiParadise::Extensions.vertical_separator
end; self.instance_eval { alias ui_vseparator vertical_separator } # === LibuiParadise.ui_vseparator
     self.instance_eval { alias ui_vsep       vertical_separator } # === LibuiParadise.ui_vsep
     self.instance_eval { alias vsep          vertical_separator } # === LibuiParadise.vsep

end