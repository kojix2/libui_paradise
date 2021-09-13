#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/scrolling_area.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.scrolling_area
  #
  # It seems as if scrolling is not yet easily available in libui.
  #
  # The upstream API is like this:
  #
  #   uiArea *area = uiNewScrollingArea(&handler, 400, 400);
  #
  # ========================================================================= #
  def self.scrolling_area(
      optional_widget = nil
    )
    _ = UI.new_scrolling_area
    # if optional_widget
    #   _.add(optional_widget)
    # end
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_scrolling_area  scrolling_area } # === LibuiParadise::Extensions.ui_scrolling_area
       self.instance_eval { alias ui_scrolled_window scrolling_area } # === LibuiParadise::Extensions.ui_scrolling_window

  # ========================================================================= #
  # === scrolling_area
  #
  # It seems as if scrolling is not yet easily available in libui.
  #
  # The upstream API is like this:
  #
  #   uiArea *area = uiNewScrollingArea(&handler, 400, 400);
  #
  # ========================================================================= #
  def scrolling_area(
      optional_widget = nil
    )
    LibuiParadise::Extensions.scrolling_area(optional_widget)
  end; alias ui_scrolling_area  scrolling_area # === ui_scrolling_area
       alias ui_scrolled_window scrolling_area # === ui_scrolling_window

end; end