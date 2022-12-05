#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::Prototype
# =========================================================================== #
module LibuiParadise

module GUI

module LibUI

class Prototype # === LibuiParadise::GUI::LibUI::Prototype

  require 'libui_paradise/extensions/extensions.rb'
  include LibuiParadise::Extensions

  # require 'bioroebe/gui/shared_code/levensthein_distance/levensthein_distance_module.rb'
  # include Bioroebe::GUI::LevenstheinDistanceModule

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'A prototype for LibUI'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 680

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 520

  # ========================================================================= #
  # === initialize
  # ========================================================================= #
  def initialize(
      run_already = true
    )
    reset
    run if run_already
  end

  # ========================================================================= #
  # === reset                                                     (reset tag)
  # ========================================================================= #
  def reset
    title_width_height(TITLE, WIDTH, HEIGHT)
  end

  # ========================================================================= #
  # === create_skeleton                            (create tag, skeleton tag)
  # ========================================================================= #
  def create_skeleton
    # ======================================================================= #
    # === @window
    # ======================================================================= #
    @window = ui_padded_main_window(title?, width?, height?, 0)
  end

  # ========================================================================= #
  # === run
  # ========================================================================= #
  def run
    create_skeleton_then_connect_skeleton
    outer_vbox = padded_vbox
    # ======================================================================= #
    # First add the two buttons on top:
    # ======================================================================= #
    hbox_on_top = padded_hbox
    button_refresh = ui_button('Refresh')
    button_refresh.on_clicked {
      e 'TODO: Refresh this ... or add any other functionality.'
    }
    hbox_on_top.maximal(button_refresh)
    hbox_on_top.maximal(quit_button)
    outer_vbox.minimal(hbox_on_top)
    outer_vbox.add_hsep

    grid = ui_padded_grid
    #                         widget, left, top, xspan, yspan, hexpand, halign, vexpand, valign
    grid.ui_grid_append(text('Left'),  0, 0, 1, 1, 0, 0.5, 1, 0)
    grid.ui_grid_append(text('Right'), 1, 0, 1, 1, 0, 0.5, 1, 0)

    3.times.each {|index| index += 1
      # ===================================================================== #
      # left, top, xspan, yspan, hexpand, halign, vexpand, valign
      #  0,    0,    2,     1,      0,      0,       1,      0
      # ===================================================================== #
      grid.ui_grid_append(text(index.to_s), 0, 1+index, 1, 1, 1, 1, 1, 1)
      label_exam_topic = text(entry.to_s)
      grid.ui_grid_append(label_exam_topic, 1, 1+index, 1, 1, 1, 1, 1, 1)
    }
    outer_vbox.maximal(grid)
    @window.add(outer_vbox)
    @window.intelligent_exit
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::Prototype.new  
end