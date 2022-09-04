#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GUI::LibUI::NotificationFunctionalityExample
# =========================================================================== #
require 'libui_paradise/base/base.rb'

module LibuiParadise

module GUI

module LibUI

class NotificationFunctionalityExample < LibuiParadise::GUI::LibUI::Base # === LibuiParadise::GUI::LibUI::NotificationFunctionalityExample

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
    add_these_widgets_to_the_main_window(
      text('Oki dokie!')
    )
  end

end; end; end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::NotificationFunctionalityExample.new  
end