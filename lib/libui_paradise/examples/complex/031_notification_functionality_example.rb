#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::NotificationFunctionalityExample
# =========================================================================== #
module LibuiParadise

module GUI

module LibUI

class NotificationFunctionalityExample # === LibuiParadise::GUI::LibUI::NotificationFunctionalityExample

  alias e puts

  require 'libui_paradise'
  include LibuiParadise::Extensions

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Showcasing LibuiParadise.notification()'

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
    button1 = button('Notify the user now.')
    button1.on_clicked {
      do_show_the_main_notification(
        'Hello world 123!'
      )
    }
    outer_vbox.minimal(button1)
    @window.add(outer_vbox)
    @window.intelligent_exit
  end

  # ======================================================================= #
  # === do_show_the_main_notification
  # ======================================================================= #
  def do_show_the_main_notification(
      text = 'Hello world 123!'
    )
    ::LibuiParadise.notification(text)
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::NotificationFunctionalityExample.new  
end