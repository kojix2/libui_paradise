#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/horizontal_separator.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.horizontal_separator
  # ========================================================================= #
  def self.horizontal_separator
    UI.new_horizontal_separator
  end; self.instance_eval { alias ui_hseparator     horizontal_separator } # === LibuiParadise::Extensions.ui_hseparator
       self.instance_eval { alias ui_hsep           horizontal_separator } # === LibuiParadise::Extensions.ui_hsep
       self.instance_eval { alias hspacer           horizontal_separator } # === LibuiParadise::Extensions.hspacer
       self.instance_eval { alias horizontal_spacer horizontal_separator } # === LibuiParadise::Extensions.horizontal_spacer

  # ========================================================================= #
  # === horizontal_separator
  # ========================================================================= #
  def horizontal_separator
    ::LibuiParadise::Extensions.horizontal_separator
  end; alias ui_hseparator     horizontal_separator # === ui_hseparator
       alias ui_hsep           horizontal_separator # === ui_hsep
       alias hspacer           horizontal_separator # === hspacer
       alias horizontal_spacer horizontal_separator # === hspacer

end

# ========================================================================= #
# === LibuiParadise.horizontal_separator
# ========================================================================= #
def self.horizontal_separator
  ::LibuiParadise::Extensions.horizontal_separator
end; self.instance_eval { alias ui_hseparator horizontal_separator } # === LibuiParadise.ui_hseparator
     self.instance_eval { alias ui_hsep       horizontal_separator } # === LibuiParadise.ui_hsep

end