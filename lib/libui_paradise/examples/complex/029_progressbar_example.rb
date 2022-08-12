#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::ProgressbarExample
# =========================================================================== #
module LibuiParadise

module GUI

module LibUI

class ProgressbarExample # === LibuiParadise::GUI::LibUI::ProgressbarExample

  alias e puts

  require 'libui_paradise'
  include LibuiParadise::Extensions

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'A ProgressbarExample for LibUI'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 400

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 220

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
  # === set_value_for_the_progress_bar
  #
  # Set to a new value for the progress-bar via this method here.
  # ========================================================================= #
  def set_value_for_the_progress_bar(i = 20)
    @progress_bar.set_value(i)
  end

  # ========================================================================= #
  # === run_the_outer_thread
  # ========================================================================= #
  def run_the_outer_thread
    Thread.new {
      loop {
        set_value_for_the_progress_bar(
          rand(100)+1
        )
        e 'The new value is: '+@progress_bar.value?.to_s
        sleep 1
      }
    }
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
    outer_vbox.add_hsep

    grid = ui_padded_grid
    #                         widget, left, top, xspan, yspan, hexpand, halign, vexpand, valign
    grid.ui_grid_append(text('Showcasing a progress bar:'),  0, 0, 1, 1, 0, 0.5, 1, 0)
    outer_vbox.minimal(grid)

    @progress_bar = wrapper_new_progress_bar
    set_value_for_the_progress_bar(20)

    outer_vbox.minimal(@progress_bar)
    outer_vbox.minimal(quit_button)
    run_the_outer_thread
    @window.add(outer_vbox)
    @window.intelligent_exit
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::ProgressbarExample.new  
end