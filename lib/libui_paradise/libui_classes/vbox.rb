#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/vbox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.vbox                            (vbox tag)
  #
  # This method will create a vertical box.
  # ========================================================================= #
  def self.vbox
    _ = UI.new_vertical_box
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_vbox vbox } # === ui_vbox

  # ========================================================================= #
  # === vbox
  # ========================================================================= #
  def vbox
    ::LibuiParadise::Extensions.vbox
  end; alias ui_vbox vbox # === ui_vbox
       alias gtk_box vbox # === gtk_box

  # ========================================================================= #
  # === ui_padded_vbox
  #
  # This method will call .is_padded on the vbox after it has been
  # initialized.
  # ========================================================================= #
  def ui_padded_vbox
    _ = ui_vbox
    _.is_padded
    return _
  end; alias padded_vbox ui_padded_vbox # === padded_vbox

end

# =========================================================================== #
# === LibuiParadise.vbox
# =========================================================================== #
def self.vbox
  ::LibuiParadise::Extensions.vbox
end

end