#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/combobox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.combobox
  # ========================================================================= #
  def self.combobox(
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
      # append_this_array_to_that_combobox(optional_array, combobox)
      combobox.append_this_array(optional_array)
    end
    return combobox
  end; self.instance_eval { alias combo_box    combobox } # === LibuiParadise::Extensions.combo_box
       self.instance_eval { alias ui_combo_box combobox } # === LibuiParadise::Extensions.ui_combo_box
       self.instance_eval { alias ui_combobox  combobox } # === LibuiParadise::Extensions.ui_combobox

  # ========================================================================= #
  # === selected?
  #
  # Unsure whether this works. It appears to work, but I am not even
  # certain as to why.
  # ========================================================================= #
  def selected?(pointer)
    UI.combobox_selected(pointer).to_s
  end

  # ========================================================================= #
  # === combobox
  #
  # The first argument can be an Array.
  # ========================================================================= #
  def combobox(
      optional_array = nil, &block
    )
    return ::LibuiParadise::Extensions.combobox(optional_array, &block)
  end; alias combo_box       combobox # === combo_box
       alias ui_combo_box    combobox # === ui_combo_box
       alias ui_combobox     combobox # === ui_combobox
       alias combo_box_entry combobox # === combo_box_entry

end; end