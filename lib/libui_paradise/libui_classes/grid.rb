#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/grid.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === ui_padded_grid
  # ========================================================================= #
  def ui_padded_grid
    _ = ui_grid
    _.is_padded
    return _
  end; alias padded_grid  ui_padded_grid # === padded_grid
       alias default_grid ui_padded_grid # === default_grid

  # ========================================================================= #
  # === LibuiParadise::Extensions.grid                             (grid tag)
  #
  # To insert into a grid, try to use this API:
  #
  #   uiGridInsertAt(
  #     uiGrid *g,
  #     uiControl *c,
  #     uiControl *existing,
  #     uiAt at,
  #     int xspan,
  #     int yspan,
  #     int hexpand,
  #     uiAlign halign, int vexpand, uiAlign valign
  #   )
  #
  # Example to add a new entry onto the grid:
  #
  #   UI.grid_append(grid, text('Yo2'), 1, 0, 1, 1, 0, 0, 1, 0)
  #
  # ========================================================================= #
  def self.grid
    _ = UI.new_grid
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_grid grid } # === LibuiParadise::Extensions.ui_grid

  # ========================================================================= #
  # === grid
  # ========================================================================= #
  def grid
    ::LibuiParadise::Extensions.grid
  end; alias ui_grid grid # === ui_grid

end; end