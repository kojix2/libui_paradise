#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/combobox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === combobox
  # ========================================================================= #
  def combobox(
      optional_array = nil, &block
    )
    combobox = UI.new_combobox
    # ======================================================================= #
    # Register it at once:
    # ======================================================================= #
    add_to_the_registered_widgets(combobox, __method__)
    if block_given?
      optional_array = yield
    end
    if optional_array and optional_array.is_a?(Array)
      append_this_array_to_that_combobox(optional_array, combobox)
      combobox.append_this_array(optional_array)
    end
    return combobox
  end; alias combo_box    combobox # === combo_box
       alias ui_combo_box combobox # === ui_combo_box
       alias ui_combobox  combobox # === ui_combobox

end; end