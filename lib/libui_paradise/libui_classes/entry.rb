#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# The upstream C API for libui-entry can be found here:
#
#   https://github.com/andlabs/libui/blob/master/unix/entry.c
#
# =========================================================================== #
# require 'libui_paradise/ui_classes/entry.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.entry                           (entry tag)
  #
  # This method is tapping into UI.new_entry.
  #
  # Usage example:
  #
  #   entry1 = UI.entry('ATG')
  #
  # ========================================================================= #
  def self.entry(
      optional_text = ''
    )
    optional_text = optional_text.to_s
    entry = UI.new_entry
    unless optional_text.empty?
      UI.entry_set_text(entry, optional_text)
    end
    add_to_the_registered_widgets(entry, __method__)
    return entry
  end; self.instance_eval { alias ui_entry entry } # === LibuiParadise::Extensions.ui_entry

  # ========================================================================= #
  # === entry                                                     (entry tag)
  #
  # This method is tapping into UI.new_entry.
  #
  # Usage example:
  #
  #   entry1 = ui_entry('ATG')
  #
  # ========================================================================= #
  def entry(
      optional_text = ''
    )
    ::LibuiParadise::Extensions.entry(optional_text)
  end; alias ui_entry entry # === ui_entry

  # ========================================================================= #
  # === text?
  #
  # This method will guarantee a String to be returned.
  #
  # This is a bit weird, though. We may have to remove this method one
  # day. I forgot why I added it to entry.rb specifically. After all
  # other widgets also should respond to .text?.
  # ========================================================================= #
  def text?(from_this_pointer)
    _ = UI.entry_text(from_this_pointer).to_s
    add_to_the_registered_widgets(_, __method__)
    return _
  end

end

# =========================================================================== #
# === LibuiParadise.entry
# =========================================================================== #
def self.entry(
    optional_text = ''
  )
  ::LibuiParadise::Extensions.entry(optional_text)
end; self.instance_eval { alias ui_entry entry } # === LibuiParadise.ui_entry

end