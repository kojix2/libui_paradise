#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === Foobar::GUI::LibUI::Prototype
# =========================================================================== #
module Foobar

module GUI

module LibUI

class Prototype # === Foobar::GUI::LibUI::Prototype

  require 'libui_paradise'
  include LibuiParadise::Extensions

  alias e puts

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'A prototype for LibUI'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 600

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 480

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
  end

  # ========================================================================= #
  # === run
  # ========================================================================= #
  def run
    window = ui_padded_main_window(
      TITLE,
      WIDTH,
      HEIGHT,
      0
    )
 
    outer_vbox = padded_vbox
    # ======================================================================= #
    # First add the two buttons on top:
    # ======================================================================= #
    hbox_on_top = padded_hbox
    button_refresh = ui_button('Refresh')
    button_refresh.on_clicked {
      e 'TODO: Refresh this...'
    }
    button_quit = quit_button
    hbox_on_top.maximal(button_refresh)
    hbox_on_top.maximal(button_quit)
    outer_vbox.minimal(hbox_on_top)
    outer_vbox.add_hsep

    grid = ui_padded_grid
    grid.ui_grid_append(text('Left'),  0, 0, 1, 1, 0, 0.5, 1, 0)
    grid.ui_grid_append(text('Right'), 1, 0, 1, 1, 0, 0.5, 1, 0)

    3.times.each {|index| index += 1
      # ===================================================================== #
      # left, top, xspan, yspan, hexpand, halign, vexpand, valign
      #  0,    0,    2,     1,      0,      0,       1,      0
      # ===================================================================== #
      grid.ui_grid_append(text(index.to_s),   0, 1+index, 1, 1, 1, 1, 1, 1)
      label_exam_topic = text(entry.to_s)
      grid.ui_grid_append(label_exam_topic, 1, 1+index, 1, 1, 1, 1, 1, 1)
    }
    outer_vbox.maximal(grid)
    window.add(outer_vbox)
    window.intelligent_exit
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  Foobar::GUI::LibUI::Prototype.new  
end