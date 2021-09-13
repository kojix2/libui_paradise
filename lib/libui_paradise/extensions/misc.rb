#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/extensions/misc.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === COLOUR_BLUE
  # ========================================================================= #
  COLOUR_BLUE = 0x1E90FF

  # ========================================================================= #
  # === abort_on_exception
  # ========================================================================= #
  def abort_on_exception
    Thread.abort_on_exception
  end

  # ========================================================================= #
  # === create_skeleton_then_connect_skeleton
  # ========================================================================= #
  def create_skeleton_then_connect_skeleton
    create_skeleton
    connect_skeleton
  end

  # ========================================================================= #
  # === ui_draw_text_layout_params
  # ========================================================================= #
  def ui_draw_text_layout_params
    return UI::FFI::DrawTextLayoutParams.malloc
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.set_title
  #
  # Simpler window-set-title functionality.
  # ========================================================================= #
  def self.set_title(
      this_title, main_window = MAIN_WINDOW
    )
    window_set_title(main_window, this_title)
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.hello_world
  #
  # This is merely an ad-hoc test.
  # ========================================================================= #
  def self.hello_world
    e 'Hello world!'
  end

  # ========================================================================= #
  # === left_arrow?
  # ========================================================================= #
  def left_arrow?
    ui_text('→')
  end

  # ========================================================================= #
  # === append_this_array_to_that_combobox
  # ========================================================================= #
  def append_this_array_to_that_combobox(
      this_array,
      that_combobox
    )
    this_array.each {|this_entry|
      UI.combobox_append(that_combobox, this_entry)
    }
  end

  # ========================================================================= #
  # === use_gtk3?
  # ========================================================================= #
  def use_gtk3?
    Object.const_defined?(:Gtk)
  end; alias use_gtk? use_gtk3? # === use_gtk?

  # ========================================================================= #
  # === new_brush
  # ========================================================================= #
  def new_brush
    UI::FFI::DrawBrush.malloc
  end

  # ========================================================================= #
  # === exit_from
  #
  # This method essentially combines UI.control_destroy() and UI.quit(
  # into one method.
  # ========================================================================= #
  def exit_from(
      main_window = ::LibuiParadise::Extensions.main_window?
    )
    UI.control_destroy(main_window)
    UI.quit
    0
  end

  # ========================================================================= #
  # === main_then_quit
  # ========================================================================= #
  def main_then_quit
    UI.main
    UI.quit
  end

  # ========================================================================= #
  # === close_properly
  # ========================================================================= #
  def close_properly(
      main_window = LibuiParadise::Extensions.main_window?
    )
    UI.window_on_closing(main_window) {
      UI.exit_from(main_window)
    }
  end; alias simple_exit close_properly # === simple_exit

  # ========================================================================= #
  # === LibuiParadise::Extensions.register_sigint
  # ========================================================================= #
  def self.register_sigint
    Signal.trap('SIGINT') { exit }
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.initializer
  # ========================================================================= #
  def self.initializer
    LibuiParadise::Extensions.register_sigint
    Object.const_set('UI', LibUI) # This is equal to: UI = LibUI
    UI.extend(LibuiParadise::Extensions) # This call will also trigger the extended-hook.
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.extended
  #
  # This method taps into the extended-hook - see the code in the
  # method shown above this method.
  #
  # The purpose of this hook is to automatically call .init. This saves
  # us one line of code.
  #
  # In regular LibUI code this is equal to:
  #
  #   UI.init
  #
  # ========================================================================= #
  def self.extended(i)
    i.init
  end

end; end