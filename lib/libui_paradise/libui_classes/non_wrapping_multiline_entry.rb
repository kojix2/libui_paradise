#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# The upstream C API can be found here:
#
#   https://raw.githubusercontent.com/andlabs/libui/master/unix/multilineentry.c
#
# =========================================================================== #
# require 'libui_paradise/ui_classes/new_non_wrapping_multiline_entry.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.textview
  #
  # A textview is a widget that allows the user to input text and modify
  # that text as well.
  # ========================================================================= #
  def self.textview
    _ = UI.new_non_wrapping_multiline_entry
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias text_view      textview } # === LibuiParadise::Extensions.text_view
       self.instance_eval { alias ui_text_view   textview } # === LibuiParadise::Extensions.ui_text_view
       self.instance_eval { alias ui_textview    textview } # === LibuiParadise::Extensions.ui_textview
       self.instance_eval { alias ui_text_buffer textview } # === LibuiParadise::Extensions.ui_text_buffer
       self.instance_eval { alias input_field    textview } # === LibuiParadise::Extensions.input_field

  # ========================================================================= #
  # === textview
  #
  # A textview is a widget that allows the user to input text and modify
  # that text as well.
  # ========================================================================= #
  def textview
    ::LibuiParadise::Extensions.textview
  end; alias text_view      textview # === text_view
       alias ui_text_view   textview # === ui_text_view
       alias ui_textview    textview # === ui_textview
       alias ui_text_buffer textview # === ui_text_buffer
       alias input_field    textview # === input_field

end

# ========================================================================= #
# === LibuiParadise.textview
# ========================================================================= #
def self.textview
  return ::LibuiParadise::Extensions.textview
end; self.instance_eval { alias text_view      textview } # === LibuiParadise.text_view
     self.instance_eval { alias ui_text_view   textview } # === LibuiParadise.ui_text_view
     self.instance_eval { alias ui_textview    textview } # === LibuiParadise.ui_textview
     self.instance_eval { alias ui_text_buffer textview } # === LibuiParadise.ui_text_buffer

end