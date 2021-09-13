#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/search_entry.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.search_entry
  # ========================================================================= #
  def self.search_entry
    _ = UI.new_search_entry
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_search_entry search_entry } # === LibuiParadise::Extensions.ui_search_entry

  # ========================================================================= #
  # === search_entry
  # ========================================================================= #
  def search_entry
    ::LibuiParadise::Extensions.search_entry
  end; alias ui_search_entry search_entry # === ui_search_entry

end

# =========================================================================== #
# === LibuiParadise.search_entry
# =========================================================================== #
def self.search_entry
  ::LibuiParadise::Extensions.search_entry
end; self.instance_eval { alias ui_search_entry search_entry } # === LibuiParadise.ui_search_entry

end