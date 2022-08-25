#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::EntryRespondsToCommentAsSynonymousToTheEnterKeyPressedExample
# =========================================================================== #
module LibuiParadise

module GUI

module LibUI

class EntryRespondsToCommentAsSynonymousToTheEnterKeyPressedExample # === LibuiParadise::GUI::LibUI::EntryRespondsToCommentAsSynonymousToTheEnterKeyPressedExample

  alias e puts

  require 'libui_paradise'
  include LibuiParadise::Extensions

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Showcasing how to use "#" as synonymous to the ENTER key pressed'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 1200

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 120

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
    outer_vbox.add_hsep

    grid = ui_padded_grid
    #                         widget, left, top, xspan, yspan, hexpand, halign, vexpand, valign
    grid.left( text('Input something, then input "#" as the last character → '))
    @entry = entry
    grid.hash_grid(
      @entry,
      left:    1,
      top:     0,
      xspan:   2,
      yspan:   1,
      hexpand: 1,
      halign: 0.5,
      vexpand: 1,
      valign:  1
    )
    grid.hash_grid(
      quit_button,
      left:  1,
      top:   1,
      xspan: 1,
      yspan: 1,
      hexpand: 1,
      halign: 0.5,
      vexpand: 1,
      valign: 1
    )
    @entry.on_changed {|something|
      proc { |pointer|
        evaluate_the_current_input(@entry, pointer) {
          run_this_method_on_enter_key_event
        }
      }
    }
    outer_vbox.minimal(grid)
    @window.add(outer_vbox)
    @window.intelligent_exit
  end

  # ========================================================================= #
  # === run_this_method_on_enter_key_event
  # ========================================================================= #
  def run_this_method_on_enter_key_event(
      entry = @entry
    )
    entry.set_text(
      entry.text?[0 .. -2].to_s
    )
  end

  # ========================================================================= #
  # === evaluate_the_current_input
  # ========================================================================= #
  def evaluate_the_current_input(
      entry   = @entry,
      pointer = nil,
      &block
    )
    _ = entry.text?
    if _[-1,1] == '#'
      yield if block_given?
    end
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::EntryRespondsToCommentAsSynonymousToTheEnterKeyPressedExample.new  
end