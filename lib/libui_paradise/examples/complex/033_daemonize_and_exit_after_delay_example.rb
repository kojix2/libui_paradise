#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::DaemonizeAndExitAfterDelayExample
#
# Unfortunately this example does not work. While Process.daemon works,
# the thread is not run.
# =========================================================================== #
require 'libui_paradise/base/base.rb'

module LibuiParadise

module GUI

module LibUI

class DaemonizeAndExitAfterDelayExample < LibuiParadise::Base # === LibuiParadise::GUI::LibUI::DaemonizeAndExitAfterDelayExample

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Showcasing Process.daemonize() and exiting after 15 seconds'

  # ========================================================================= #
  # === DELAY
  #
  # Keep a delay of 15 seconds.
  # ========================================================================= #
  DELAY = 3 

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
    default_title_width_height(TITLE, WIDTH, HEIGHT)
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
    super()
    Thread.abort_on_exception = true
    run_in_the_background
    Thread.new {
      add_these_widgets_to_the_main_window(
        text('Oki dokie1!'),
        text('Oki dokie2!')
      )
      # This part does not work yet, though:
      e 'Exiting now.'
      exit
    }.join
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::DaemonizeAndExitAfterDelayExample.new  
end