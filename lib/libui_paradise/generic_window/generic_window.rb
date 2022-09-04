#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::GenericWindow
# =========================================================================== #
# require 'libui_paradise/generic_window/generic_window.rb'
# LibuiParadise::GenericWindow.new(ARGV)
# =========================================================================== #
require 'libui_paradise/base/base.rb'

module LibuiParadise

class GenericWindow < LibuiParadise::Base # === LibuiParadise::GenericWindow

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Generic Window'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 500

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 300

  # ========================================================================= #
  # === initialize
  # ========================================================================= #
  def initialize(
      *use_these_widgets,
      &block
    )
    reset
    # ======================================================================= #
    # === Handle blocks given to this method next
    # ======================================================================= #
    if block_given?
      yielded = yield
      case yielded
      # ===================================================================== #
      # === :do_not_run_yet
      # ===================================================================== #
      when :do_not_run_yet,
           :dont_run_already
        run_already = false
      end
    end
    if run_already # This is coupled to batch-adding widgets.
      add_these_widgets_to_the_main_window(
        use_these_widgets
      )
      run
    end
  end

  # ========================================================================= #
  # === reset
  # ========================================================================= #
  def reset
    super()
  end

  # ========================================================================= #
  # === run
  # ========================================================================= #
  def run
    super()
  end

end; end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise::GUI::LibUI::GenericWindow.new
end