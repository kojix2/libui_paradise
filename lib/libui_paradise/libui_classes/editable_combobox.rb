#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/editable_combobox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === editable_combobox
  # ========================================================================= #
  def editable_combobox(
      optional_array = nil, &block
    )
    _ = UI.new_editable_combobox
    if block_given?
      optional_array = yield
    end
    if optional_array and optional_array.is_a?(Array)
      append_this_array_to_that_combobox(optional_array, _)
    end
    add_to_the_registered_widgets(_, __method__)
    return _
  end; alias editable_combo_box    editable_combobox # === editable_combo_box
       alias ui_editable_combo_box editable_combobox # === ui_editable_combo_box

end; end