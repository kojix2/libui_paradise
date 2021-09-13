#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/tab.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.tab
  #
  # This could be also called "notebook_tab".
  # ========================================================================= #
  def self.tab
    _ = UI.new_tab
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_tab       tab } # === LibuiParadise::Extensions.ui_tab
       self.instance_eval { alias ui_tabs      tab } # === LibuiParadise::Extensions.ui_tabs
       self.instance_eval { alias notebook     tab } # === LibuiParadise::Extensions.notebook
       self.instance_eval { alias ui_notebook  tab } # === LibuiParadise::Extensions.ui_notebook
       self.instance_eval { alias notebook_tab tab } # === LibuiParadise::Extensions.notebook_tab

  # ========================================================================= #
  # === tab
  #
  # This could be also called "notebook_tab".
  # ========================================================================= #
  def tab
    ::LibuiParadise::Extensions.tab
  end; alias ui_tab       tab # === ui_tab
       alias ui_tabs      tab # === ui_tabs
       alias notebook     tab # === notebook
       alias ui_notebook  tab # === ui_notebook
       alias notebook_tab tab # === notebook_tab

end; end