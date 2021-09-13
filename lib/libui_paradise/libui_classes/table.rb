#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/table.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.table
  # ========================================================================= #
  def self.table(i)
    _ = UI.new_table(i)
    LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias ui_table table } # === LibuiParadise::Extensions.ui_table

  # ========================================================================= #
  # === table
  # ========================================================================= #
  def table(i)
    ::LibuiParadise::Extensions.table(i)
  end; alias ui_table table # === ui_table

end

# =========================================================================== #
# === LibuiParadise.table
# =========================================================================== #
def self.table(i)
  ::LibuiParadise::Extensions.table(i)
end; self.instance_eval { alias ui_table table } # === LibuiParadise.ui_table

end