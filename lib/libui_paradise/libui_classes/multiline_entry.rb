#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# Upstream code for the linux-variant can be found here:
#
#   https://raw.githubusercontent.com/andlabs/libui/master/unix/multilineentry.c
#
# =========================================================================== #
# require 'libui_paradise/libui_classes/multiline_entry.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.multiline_entry       (multiline_entry tag)
  #
  # A textview is a widget that allows the user to input text and modify
  # that text as well.
  # ========================================================================= #
  def self.multiline_entry(optional_content = nil)
    _ = UI.new_multiline_entry
    add_to_the_registered_widgets(_, __method__)
    if optional_content and optional_content.is_a?(String) and !optional_content.empty?
      _.set_text(optional_content)
    end
    return _
  end; self.instance_eval { alias ui_multiline_entry multiline_entry } # === LibuiParadise::Extensions.ui_multiline_entry
       self.instance_eval { alias textview           multiline_entry } # === LibuiParadise::Extensions.textview
       self.instance_eval { alias text_view          multiline_entry } # === LibuiParadise::Extensions.text_view
       self.instance_eval { alias ui_text_view       multiline_entry } # === LibuiParadise::Extensions.ui_text_view
       self.instance_eval { alias ui_textview        multiline_entry } # === LibuiParadise::Extensions.ui_textview
       self.instance_eval { alias ui_text_buffer     multiline_entry } # === LibuiParadise::Extensions.ui_text_buffer
       self.instance_eval { alias input_field        multiline_entry } # === LibuiParadise::Extensions.input_field
       self.instance_eval { alias input              multiline_entry } # === LibuiParadise::Extensions.input

  # ========================================================================= #
  # === multiline_entry
  # ========================================================================= #
  def multiline_entry(optional_content = nil)
    ::LibuiParadise::Extensions.multiline_entry(optional_content)
  end; alias ui_multiline_entry multiline_entry # === ui_multiline_entry
       alias textview           multiline_entry # === textview
       alias text_view          multiline_entry # === text_view
       alias ui_text_view       multiline_entry # === ui_text_view
       alias ui_textview        multiline_entry # === ui_textview
       alias ui_text_buffer     multiline_entry # === ui_text_buffer
       alias input_field        multiline_entry # === input_field
       alias input              multiline_entry # === input

end

# =========================================================================== #
# === LibuiParadise.multiline_entry
# =========================================================================== #
def self.multiline_entry(optional_content = nil)
  ::LibuiParadise::Extensions.multiline_entry(optional_content)
end; self.instance_eval { alias textview           multiline_entry } # === LibuiParadise.textview
     self.instance_eval { alias text_view          multiline_entry } # === LibuiParadise.text_view
     self.instance_eval { alias ui_text_view       multiline_entry } # === LibuiParadise.ui_text_view
     self.instance_eval { alias ui_textview        multiline_entry } # === LibuiParadise.ui_textview
     self.instance_eval { alias ui_text_buffer     multiline_entry } # === LibuiParadise.ui_text_buffer
     self.instance_eval { alias input_field        multiline_entry } # === LibuiParadise.input_field

end