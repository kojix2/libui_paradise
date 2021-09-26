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
  # === LibuiParadise::Extensions.non_wrapping_multiline_entry
  # ========================================================================= #
  def self.non_wrapping_multiline_entry
    _ = UI.new_non_wrapping_multiline_entry
    add_to_the_registered_widgets(_, __method__)
    return _
  end

end; end