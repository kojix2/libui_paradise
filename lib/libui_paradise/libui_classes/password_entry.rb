#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/password_entry.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.password_entry
  #
  # This method will create and returns a new password entry widget. This
  # means that input will be "disguised" via the '*' character.
  #
  # Usage example:
  #
  #   entry = LibuiParadise::Extensions.password_entry
  #
  # ========================================================================= #
  def self.password_entry
    entry = UI.new_password_entry
    add_to_the_registered_widgets(entry, __method__)
    return entry
  end; self.instance_eval { alias ui_password_entry password_entry } # === LibuiParadise::Extensions.ui_password_entry

  # ========================================================================= #
  # === password_entry
  #
  # Usage example:
  #
  #   entry = ui_password_entry
  #
  # ========================================================================= #
  def password_entry
    ::LibuiParadise::Extensions.password_entry
  end; alias ui_password_entry password_entry # === ui_password_entry

end

# =========================================================================== #
# === LibuiParadise.password_entry
# =========================================================================== #
def self.password_entry
  ::LibuiParadise::Extensions.password_entry
end; self.instance_eval { alias ui_password_entry password_entry } # === LibuiParadise.ui_password_entry

end