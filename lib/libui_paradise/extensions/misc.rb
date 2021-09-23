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
  # === is_on_roebe?
  # ========================================================================= #
  def is_on_roebe?
    ENV['IS_ROEBE'].to_s == '1'
  end

  # ========================================================================= #
  # === ui_sync_connect
  #
  # This method can connect two widgets: the first one should be a
  # combo-box, and the second one a ui-entry.
  # ========================================================================= #
  def ui_sync_connect(
      widget1, widget2
    )
    combobox_selected_callback = proc { |pointer|
      widget2.set_text(
        selected?(pointer)
      )
    }
    UI.combobox_on_selected(
      widget1, combobox_selected_callback, nil
    )
  end; alias sync_connect ui_sync_connect # === sync_connect

  # ========================================================================= #
  # === try_to_parse_this_config_file
  #
  # This method can be used to parse a .config file for data it stores.
  #
  # The .config file must have "width:", "height:" and "title:" settings.
  # ========================================================================= #
  def try_to_parse_this_config_file(i)
    if File.exist? i
      dataset = File.readlines(i)
      width  = dataset.select {|line| line.include? 'width:' }.first.
               split(':').last.strip.to_i
      height = dataset.select {|line| line.include? 'height:' }.first.
               split(':').last.strip.to_i
      title  = dataset.select {|line| line.include? 'title:' }.first.
               split(':').last.strip
      window = LibuiParadise.window(title, width, height)
      return window
    else
      e 'No file exists at `'+i+'`.'
    end
  end; alias parse_this_config_file try_to_parse_this_config_file # === parse_this_config_file

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

  # ========================================================================= #
  # === return_the_resolution_using_xrandr
  #
  # This method will only work on e. g. Linux.
  #
  # It will then return a String such as "1920x1080".
  # ========================================================================= #
  def return_the_resolution_using_xrandr
    _ = `xrandr`.split("\n").select {|line|
      line.include? '*+'
    }.first.strip.squeeze(' ').split(' ').first.to_s
    return _ # This will yield e. g. "1920x1080"
  end

  # ========================================================================= #
  # === assumed_height?
  # ========================================================================= #
  def assumed_height?
    return_the_resolution_using_xrandr.split('x').last.to_i
  end; alias assumed_max_height? assumed_height? # === assumed_max_height?

  # ========================================================================= #
  # === assumed_width?
  # ========================================================================= #
  def assumed_width?
    return_the_resolution_using_xrandr.split('x').first.to_i
  end; alias assumed_max_width? assumed_width? # === assumed_max_width?

  # ========================================================================= #
  # === set_width
  # ========================================================================= #
  def set_width(i = 1024)
    if i.is_a?(String) and i.include?('%')
      # ===================================================================== #
      # In this case we have to modify this a bit.
      # ===================================================================== #
      max_width = assumed_max_width?
      i = (max_width.to_f * i.to_i) / 100.0
    end
    i = i.to_i
    @width = i
  end

  # ========================================================================= #
  # === set_title
  # ========================================================================= #
  def set_title(i)
    @title = i
  end

  # ========================================================================= #
  # === title?
  # ========================================================================= #
  def title?
    @title
  end

  # ========================================================================= #
  # === set_height
  # ========================================================================= #
  def set_height(i = 800)
    if i.is_a?(String) and i.include?('%')
      # ===================================================================== #
      # In this case we have to modify this a bit.
      # ===================================================================== #
      max_height = assumed_max_height?
      i = (max_height.to_f * i.to_i) / 100.0
    end
    i = i.to_i
    @height = i
  end

  # ========================================================================= #
  # === width?
  # ========================================================================= #
  def width?
    @width
  end

  # ========================================================================= #
  # === height?
  # ========================================================================= #
  def height?
    @height
  end

end; end