#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/menu.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.menu                             (menu tag)
  # ========================================================================= #
  def self.menu(title = '')
    _ = UI.new_menu(title)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_menu menu } # === ui_menu

  # ========================================================================= #
  # === menu                                                       (menu tag)
  # ========================================================================= #
  def menu(title = '')
    return menu(title)
  end; alias ui_menu menu # === ui_menu

end

# =========================================================================== #
# === LibuiParadise.menu
# =========================================================================== #
def self.menu(title = '')
  return LibuiParadise::Extensions.menu(title)
end; self.instance_eval { alias ui_menu menu } # === LibuiParadise.ui_menu

end