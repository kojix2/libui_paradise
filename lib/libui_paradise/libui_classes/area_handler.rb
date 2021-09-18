#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/area_handler.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.area
  #
  # AreaHandler defines the functionality needed for handling events
  # from an Area.
  #
  # Upstream documentation, at the least for Go, can be found here:
  #
  #   https://github.com/andlabs/ui/blob/master/areahandler.go
  #
  # ========================================================================= #
  def self.area(
      i = :use_new_area_handler
    )
    case i
    when :use_new_area_handler,
         :default
      i = UI::FFI::AreaHandler.malloc
    end
    _ = UI.new_area(i)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias area_handler area } # === LibuiParadise::Extensions.area_handler

  # ========================================================================= #
  # === area
  #
  # AreaHandler defines the functionality needed for handling events
  # from an Area.
  #
  # Upstream documentation, at the least for Go, can be found here:
  #
  #   https://github.com/andlabs/ui/blob/master/areahandler.go
  #
  # ========================================================================= #
  def area(
      i = :use_new_area_handler
    )
    return ::LibuiParadise::Extensions.area(i)
  end; alias area_handler area # === area_handler

end; end