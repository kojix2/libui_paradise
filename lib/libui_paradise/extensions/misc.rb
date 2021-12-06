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
  # === colour_to_rgb
  # ========================================================================= #
  def colour_to_rgb(colour = :steelblue)
    array = Colours.colour_to_rgb(colour)
    return array
  end

  # ========================================================================= #
  # === esystem
  # ========================================================================= #
  def esystem(i)
    puts i
    system i
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
  # === set_height
  # ========================================================================= #
  def set_height(
      i = 800
    )
    case i
    # ======================================================================= #
    # === :max_width
    # ======================================================================= #
    when :max_height
      i = assumed_max_height?
    end
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
  # === set_width
  # ========================================================================= #
  def set_width(
      i = 1024
    )
    case i
    # ======================================================================= #
    # === :max_width
    # ======================================================================= #
    when :max_width
      i = assumed_max_width?
    end
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

  # ========================================================================= #
  # === return_the_resolution_using_xrandr
  #
  # This method will only work on e. g. Linux.
  #
  # It will then return a String such as "1920x1080".
  # ========================================================================= #
  def return_the_resolution_using_xrandr
    _ = '800x600' # This is a generic failsafe value.
    begin
      xrandr_result = `xrandr`
      _ = xrandr_result.split("\n").select {|line|
        line.include? '*'
      }.first.strip.squeeze(' ').split(' ').first.to_s
    rescue Errno::ENOENT # Rescue for Windows systems.
    end
    return _ # This will yield e. g. "1920x1080"
  end

  # ========================================================================= #
  # === ui_table_params_malloc
  # ========================================================================= #
  def ui_table_params_malloc(optional_model = nil)
    _ = LibUI::FFI::TableParams.malloc
    if optional_model
      _.Model = optional_model
      _.RowBackgroundColorModelColumn = -1
    end
    return _
  end

  # ========================================================================= #
  # === ui_font_descriptor
  #
  # This method will return a new font-descriptor pointer.
  #
  # Usage example:
  #
  #   ui_font_descriptor('Hack')
  #
  # ========================================================================= #
  def ui_font_descriptor(
      use_this_font_family      = 'Hack',
      use_this_size             = 25,
      use_this_weight           = 500,
      is_in_italic_font_variant = :no,
      stretch_factor            = 4
    )
    case is_in_italic_font_variant
    when :yes
      is_in_italic_font_variant = 1 # true
    when :no
      is_in_italic_font_variant = 0 # false
    end
    font_descriptor = UI::FFI::FontDescriptor.malloc
    font_descriptor.to_ptr.free = Fiddle::RUBY_FREE
    font_descriptor.Family = use_this_font_family
    font_descriptor.Size = use_this_size
    font_descriptor.Weight = use_this_weight
    font_descriptor.Italic = is_in_italic_font_variant
    font_descriptor.Stretch = stretch_factor
    return font_descriptor
  end; alias font_descriptor ui_font_descriptor # === font_descriptor

  # ========================================================================= #
  # === ui_text_then_entry
  #
  # This method must return an Array containing three elements.
  #
  # Note that :padding specifies whether we will use padding or not in
  # libui. In ruby-gtk3 we can pass the pixels here; I am not sure
  # whether this is possible via libui as such.
  # ========================================================================= #
  def ui_text_then_entry(
      text = '',
      hash = {
        padding: 0
      }
    )
    text = ui_text(text)
    entry = ui_entry
    hbox = padded_hbox
    hbox.minimal(text,  hash[:padding])
    hbox.minimal(entry, hash[:padding])
    return [ hbox, text, entry ]
  end; alias text_then_entry ui_text_then_entry # === text_then_entry

  # ========================================================================= #
  # === use_libui?
  # ========================================================================= #
  def use_libui?
    true
  end

  # ========================================================================= #
  # === use_gtk?
  # ========================================================================= #
  def use_gtk?
    false
  end

  # ========================================================================= #
  # === try_to_use_this_font
  #
  # This is currently not in use - once libui supports setting
  # a font then this can be enabled.
  # ========================================================================= #
  def try_to_use_this_font(i = nil); end
    alias use_this_font=    try_to_use_this_font
    alias set_use_this_font try_to_use_this_font

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
  # === run_main
  # ========================================================================= #
  def run_main
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.draw_rectangle
  #
  # This method can be used to draw a rectangle.
  #
  # The third argument should be a HTML colour.
  # ========================================================================= #
  def self.draw_rectangle(
      width  = :default,
      height = :default,
      colour = :orange
    )
    unless ::LibuiParadise.respond_to?(:padded_vbox)
      require 'libui_paradise/libui_classes/vbox.rb'
    end
    unless Object.const_defined? :Colours
      begin
        require 'colours'
      rescue LoadError; end
    end
    case width
    when :default
      width = 25
    end
    case height
    when :default
      height = 25
    end
    handler = LibUI::FFI::AreaHandler.malloc
    handler.to_ptr.free = Fiddle::RUBY_FREE
    area    = LibUI.new_area(handler)
    brush   = LibUI::FFI::DrawBrush.malloc
    brush.to_ptr.free = Fiddle::RUBY_FREE

    handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) { |_, _, area_draw_params|
      path = LibUI.draw_new_path(0)
      LibUI.draw_path_add_rectangle(path, 0, 0, width, height)
      LibUI.draw_path_end(path)
      brush.Type = 0
      # ===================================================================== #
      # Need to find out the true RGB values. For now we divide by 255.
      #
      # See here:
      #
      #   https://stackoverflow.com/questions/10848990/rgb-values-to-0-to-1-scale
      #
      # ===================================================================== #
      array = Colours.colour_to_rgb(colour)
      brush.R = array[0] / 255.0 # 0.4
      brush.G = array[1] / 255.0 # 0.4
      brush.B = array[2] / 255.0 # 0.8
      brush.A = 1.0
      area_draw_params = LibUI::FFI::AreaDrawParams.new(area_draw_params)
      LibUI.draw_fill(area_draw_params.Context, path, brush.to_ptr)
      LibUI.draw_free_path(path)
    }

    do_nothing = Fiddle::Closure::BlockCaller.new(0, [0]) {}
    key_event  = Fiddle::Closure::BlockCaller.new(1, [0]) { 0 }

    handler.Draw         = handler_draw_event
    handler.MouseEvent   = do_nothing
    handler.MouseCrossed = do_nothing
    handler.DragBroken   = do_nothing
    handler.KeyEvent     = key_event

    box = ::LibuiParadise.padded_vbox
    box.maximal(area)
    return box
  end

end

# =========================================================================== #
# === LibuiParadise.draw_rectangle
# =========================================================================== #
def self.draw_rectangle(
    width  = :default,
    height = :default,
    colour = :orange
  )
  ::LibuiParadise::Extensions.draw_rectangle(width, height, colour)
end

end