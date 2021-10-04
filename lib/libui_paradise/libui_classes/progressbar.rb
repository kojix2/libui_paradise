#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# The upstream C API can be found here:
#
#   https://github.com/andlabs/libui/blob/master/unix/progressbar.c
#
# =========================================================================== #
# require 'libui_paradise/ui_classes/progressbar.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.new_progress_bar
  # ========================================================================= #
  def self.new_progress_bar
    _ = LibUI.new_progress_bar
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === new_progress_bar
  # ========================================================================= #
  def new_progress_bar
    return ::LibuiParadise::Extensions.new_progress_bar
  end

end

# =========================================================================== #
# === LibuiParadise.new_progress_bar
# =========================================================================== #
def self.new_progress_bar
  return ::LibuiParadise::Extensions.new_progress_bar
end

end