#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::Base
# =========================================================================== #
# require 'libui_paradise/base/base.rb'
# < LibuiParadise::Base
# =========================================================================== #
module LibuiParadise

class Base # === LibuiParadise::Base

  alias e puts

  require 'libui_paradise'
  include LibuiParadise::Extensions

  # ========================================================================= #
  # === TITLE
  # ========================================================================= #
  TITLE = 'Generic Title'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH  = 800

  # ========================================================================= #
  # === HEIGHT
  # ========================================================================= #
  HEIGHT = 640

  # ========================================================================= #
  # === default_title_width_height
  # ========================================================================= #
  def default_title_width_height(
      title  = TITLE,
      width  = WIDTH,
      height = HEIGHT
    )
    title_width_height(
      title,
      width,
      height
    )
  end

  # ========================================================================= #
  # === reset                                                     (reset tag)
  # ========================================================================= #
  def reset
    title_width_height(TITLE, WIDTH, HEIGHT)
    # ======================================================================= #
    # === @window
    # ======================================================================= #
    set_window(
      return_default_window
    )
  end

  # ======================================================================= #
  # === update_the_main_window
  # ======================================================================= #
  def update_the_main_window
    set_window(
      return_default_window
    )
  end

  # ======================================================================= #
  # === return_default_window
  # ======================================================================= #
  def return_default_window(
      title  = title?,
      width  = width?,
      height = height?
    )
    return ui_padded_main_window(title, width, height, 0)
  end

  # ======================================================================= #
  # === set_window
  #
  # Simply assign to @window here.
  # ======================================================================= #
  def set_window(i = return_default_window)
    @window = i
  end

  # ========================================================================= #
  # === create_skeleton                            (create tag, skeleton tag)
  # ========================================================================= #
  def create_skeleton
  end

  # ========================================================================= #
  # === add_these_widgets_to_the_main_window
  #
  # This method can be used to batch-add several widgets into the
  # main window at hand. It has been created in September 2022 to
  # simplify adding widgets from simple scripts. If we can easily
  # add widgets then this will help write smaller GUIs quickly.
  #
  # For now the main container to be used is a vertical-box here.
  # In theory this could be changed, but for now this is how it
  # is.
  # ========================================================================= #
  def add_these_widgets_to_the_main_window(*i)
    outer_vbox = padded_vbox
    # ======================================================================= #
    # First add the two buttons on top:
    # ======================================================================= #
    outer_vbox.add_hsep
    i.flatten.each {|this_widget|
      outer_vbox.minimal(this_widget)
    }
    @window.add(outer_vbox)
    if i.size > 0
      Thread.new {
        sleep 5
        require 'save_file'
        SaveFile.write_what_into('YO','/Depot/j/ACK.md')
        exit
      }
    end
    @window.intelligent_exit
  end; alias add_these_widgets add_these_widgets_to_the_main_window # === add_these_widgets

  # ========================================================================= #
  # === run_in_the_background
  # ========================================================================= #
  def run_in_the_background
    Process.daemon
  end

  # ========================================================================= #
  # === run
  # ========================================================================= #
  def run
    create_skeleton_then_connect_skeleton
  end

end; end