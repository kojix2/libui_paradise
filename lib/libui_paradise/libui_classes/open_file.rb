#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/open_file.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions
  
  # ========================================================================= #
  # === open_file
  # ========================================================================= #
  def open_file(
      main_window = LibuiParadise::Extensions.main_window?
    )
    _ = UI.open_file(main_window)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; alias ui_open_file open_file # === ui_open_file

end; end