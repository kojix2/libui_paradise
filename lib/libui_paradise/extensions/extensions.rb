#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::Extensions
#
# This .rb file is primarly used to "extend" libui in a convenient
# way. Upon this file being required, several additional actions 
# are performed, such as "alias e puts". That way we only have
# to require this file and the rest will be set up correctly for
# us automatically, for reasons of convenience.
# =========================================================================== #
# require 'libui_paradise/extensions/extensions.rb
# include Libuiparadise::Extensions
# =========================================================================== #
require 'libui' # Mandatory require-call.

module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  require 'fileutils'
  require 'libui_paradise/colours/colours.rb'
  require 'libui_paradise/fiddle/fiddle.rb'
  require 'libui_paradise/libui_classes/libui_classes.rb'

  # ========================================================================= #
  # === WIDTH
  # ========================================================================= #
  WIDTH = 1024

  # ========================================================================= #
  # === @hash_fiddle_pointer_widgets
  #
  # This hash will contain all widgets, via pointer.
  # ========================================================================= #
  @hash_fiddle_pointer_widgets = {}

  # ========================================================================= #
  # === LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
  # ========================================================================= # 
  def self.hash_fiddle_pointer_widgets?
    @hash_fiddle_pointer_widgets
  end

  # ========================================================================= #
  # === main_hash?
  #
  # Access the main hash defined above.
  # ========================================================================= #
  def main_hash?
    ::LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
  end; alias toplevel_hash? main_hash? # === toplevel_hash?

  # ========================================================================= #
  # === LibuiParadise::Extensions.notification
  #
  # This method can be used to show a quick message box to the end
  # user.
  # ========================================================================= #
  def self.notification(
      text         = 'Backup complete!',
      title_to_use = ''
    )
    ::LibuiParadise::Extensions.message_box(
      text:         text,
      title_to_use: title_to_use
    )
  end

  # ========================================================================= #
  # === ui_sync_connect
  #
  # This method can connect two widgets: the first one should be a
  # combo-box, and the second one a ui-entry.
  # ========================================================================= #
  def ui_sync_connect(
      widget1,
      widget2,
      optional_array = nil
    )
    combobox_selected_callback = proc { |pointer|
      selected_value = selected?(pointer)
      if optional_array and optional_array.is_a?(Array)
        selected_value = optional_array[selected_value.to_i]
      end
      widget2.set_text(
        selected_value
      )
    }
    ::LibUI.combobox_on_selected(
      widget1, combobox_selected_callback, nil
    )
  end; alias sync_connect ui_sync_connect # === sync_connect

  # ========================================================================= #
  # === LibuiParadise::Extensions.register_this_fiddle_pointer_widget
  #
  # This method registers the particular widget in use.
  #
  # Every new_* method available via LibUI.new* that creates a new widget
  # has to be registered via this method here, by calling it.
  #
  # That way we have a main Hash that contains lots of Fiddle::Pointers
  # and we can, at a later time, modify these Fiddle::Pointer or call
  # toplevel methods with these registered pointers. This will only
  # work if we have registered these pointers, though, which is why
  # each method that creates a new libui-widget has to make use of
  # this method here.
  #
  # Since as of November 2022, the main window is also handled by
  # this.
  #
  # Perhaps it should also use the method here, but I found it simpler
  # to just refer to it via @main_window or main_window?. (Note that
  # in future releases of the libui_paradise gem, @main_window will
  # probably be removed and integrated just like any other
  # libui-widget. But this has not been done yet, so it is retained
  # as-is right now.)
  #
  # The mandatory entries given to this method must be of the
  # following format:
  #
  #   object_id -> [:the_fiddle_pointer_widget, :the_type]
  #
  # In other words, a key (as an Integer), and an Array as
  # its primary value.
  #
  # The object_id will be determined automatically, so it can
  # be omitted. It is the value that is simply returned by
  # calling the .object_id method, so we do not have to do
  # anything else here.
  #
  # The very last argument of the two-member Array should be a
  # symbol, such as :grid. This is automatically ensured via a
  # call to __method__ which returns a Symbol. That way we can
  # then call the correct method internally, once we know we
  # have a :grid or any other widget.
  # ========================================================================= #
  def self.register_this_fiddle_pointer_widget(
      the_fiddle_pointer_widget,
      the_type_of_the_widget = nil
    )
    # ======================================================================= #
    # Determine the object-id automatically next:
    # ======================================================================= #
    object_id_to_use = the_fiddle_pointer_widget.object_id
    # ======================================================================= #
    # Then, store it on the main Hash.
    # ======================================================================= #
    @hash_fiddle_pointer_widgets[object_id_to_use] =
      [
        the_fiddle_pointer_widget,
        the_type_of_the_widget
      ]
  end; self.instance_eval { alias add_to_the_registered_widgets register_this_fiddle_pointer_widget } # === LibuiParadise::Extensions.add_to_the_registered_widgets

  # ========================================================================= #
  # === LibuiParadise::Extensions.current_widget_pointer?
  # ========================================================================= #
  def self.current_widget_pointer?
    LibuiParadise::Extensions.hash_fiddle_pointer_widgets?.values.last.first
  end

  # ========================================================================= #
  # === last_pointer?
  #
  # This used to return the "current" widget pointer, but past September
  # 2021 this is rarely in use anymore. Use current_widget_pointer? 
  # instead, based on the main Hash that keeps all widgets registered.
  # ========================================================================= #
  def last_pointer?
    LibuiParadise::Extensions.current_widget_pointer?
  end; alias current_pointer?        last_pointer? # === current_pointer?
       alias current_widget_pointer? last_pointer? # === current_widget_pointer?

  # ========================================================================= #
  # === current_widget_pointer_type?
  # ========================================================================= #
  def current_widget_pointer_type?
    LibuiParadise::Extensions.hash_fiddle_pointer_widgets?.values.last.last
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
  # === close_properly
  # ========================================================================= #
  def close_properly(
      main_window = LibuiParadise::Extensions.main_window?
    )
    LibUI.window_on_closing(main_window) {
      LibUI.exit_from(main_window)
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
    ::LibUI.extend(LibuiParadise::Extensions) # This call will also trigger the extended-hook.
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
  # === register_this_fiddle_pointer_widget
  # ========================================================================= #
  def register_this_fiddle_pointer_widget(
      the_fiddle_pointer_widget,
      the_type_of_the_widget = nil
    )
    ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(
      the_fiddle_pointer_widget,
      the_type_of_the_widget
    )
  end; alias add_to_the_registered_widgets register_this_fiddle_pointer_widget # === add_to_the_registered_widgets

  # ========================================================================= #
  # === esystem
  #
  # This method can be used to run system(), with output. Thread.new is
  # used because that seems to work better in a GUI setup.
  # ========================================================================= #
  def esystem(i)
    puts i
    Thread.new { system i }
  end

  # ========================================================================= #
  # === delete_file
  #
  # This method can be used if you want to quickly delete a (local) file.
  # ========================================================================= #
  def delete_file(i)
    if File.file?(i)
      File.delete(i)
    else
      puts "Not a file: #{i}"
    end
  end

  # ========================================================================= #
  # === colour_to_rgb
  # ========================================================================= #
  def colour_to_rgb(colour = :steelblue)
    array = Colours.colour_to_rgb(colour)
    return array
  end

  # ========================================================================= #
  # === assumed_height?
  # ========================================================================= #
  def assumed_height?
    return_the_resolution_using_xrandr.split('x').last.to_i
  end; alias assumed_max_height? assumed_height? # === assumed_max_height?

  # ========================================================================= #
  # === without_trailing_comment
  # ========================================================================= #
  def without_trailing_comment(i)
    i = i.dup
    if i and i.end_with?('#')
      i = i[0 .. -2]
    end
    return i
  end

  # ========================================================================= #
  # === assumed_width?
  # ========================================================================= #
  def assumed_width?
    return_the_resolution_using_xrandr.split('x').first.to_i
  end; alias assumed_max_width? assumed_width? # === assumed_max_width?

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
  # === set_title
  # ========================================================================= #
  def set_title(i)
    @title = i
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.set_title
  #
  # Simpler window-set-title functionality.
  # ========================================================================= #
  def self.set_title(
      this_title,
      main_window = main_window?
    )
    window_set_title(main_window, this_title)
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
    return [hbox, text, entry]
  end; alias text_then_entry ui_text_then_entry # === text_then_entry

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
      # ===================================================================== #
      # Next check for width, height and title:
      # ===================================================================== #
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
    return ::LibUI::FFI::DrawTextLayoutParams.malloc
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
    LibUI.control_destroy(main_window)
    LibUI.quit
    0
  end

  # ========================================================================= #
  # === main_then_quit
  # ========================================================================= #
  def main_then_quit
    ::LibUI.main
    do_quit
  end

  # ========================================================================= #
  # === do_quit
  # ========================================================================= #
  def do_quit
    ::LibUI.quit
  end

  # ========================================================================= #
  # === copy
  # ========================================================================= #
  def copy(from, to)
    require 'fileutils'
    FileUtils.cp(from, to)
  end

  # ========================================================================= #
  # === use_gtk3?
  # ========================================================================= #
  def use_gtk3?
    Object.const_defined?(:Gtk)
  end; alias use_gtk? use_gtk3? # === use_gtk?

  # ========================================================================= #
  # === use_gtk?
  # ========================================================================= #
  def use_gtk?
    false
  end

  # ========================================================================= #
  # === use_libui?
  # ========================================================================= #
  def use_libui?
    true
  end

  # ========================================================================= #
  # === gtk3?
  # ========================================================================= #
  def gtk3?
    false
  end; alias is_on_gtk? gtk3? # === is_on_gtk?

  # ========================================================================= #
  # === return_pwd
  # ========================================================================= #
  def return_pwd
    "#{Dir.pwd}/".squeeze('/')
  end

  # ========================================================================= #
  # === try_to_use_this_font
  #
  # This is currently not in use - once libui supports setting
  # a font then this can be enabled.
  # ========================================================================= #
  def try_to_use_this_font(i = nil); end
    alias use_this_font=    try_to_use_this_font # === use_this_font=
    alias set_use_this_font try_to_use_this_font # === set_use_this_font

  # ========================================================================= #
  # === abort_on_exception
  # ========================================================================= #
  def abort_on_exception
    Thread.abort_on_exception
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
    # ======================================================================= #
    # === :default
    # ======================================================================= #
    when :default
      width = 25
    end
    case height
    # ======================================================================= #
    # === :default
    # ======================================================================= #
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

  # ========================================================================= #
  # === chdir                                             (cd tag, chdir tag)
  # ========================================================================= #
  def chdir(i)
    if i and File.directory?(i)
      Dir.chdir(i)
    end
  end; alias cd chdir # === cd

  # ========================================================================= #
  # === create_skeleton_then_connect_skeleton
  # ========================================================================= #
  def create_skeleton_then_connect_skeleton
    create_skeleton
    connect_skeleton
  end

  # ========================================================================= #
  # === connect_skeleton
  #
  # This is a stub method, because we want to allow the user to modify it.
  # ========================================================================= #
  def connect_skeleton
  end

  # ========================================================================= #
  # === title_width_height
  # ========================================================================= #
  def title_width_height(
      title,
      width  = WIDTH,
      height =  800
    )
    set_title(title)
    set_width(width)
    set_height(height)
  end; alias set_title_width_height title_width_height # === title_width_height

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
  # === copy_file
  # ========================================================================= #
  def copy_file(from, to)
    FileUtils.cp(from, to)
  end; alias cp_file copy_file # === cp_file

  # ========================================================================= #
  # === create_directory
  # ========================================================================= #
  def create_directory(i)
    FileUtils.mkdir_p(i)
  end; alias mkdir create_directory # === mkdir

  # ========================================================================= #
  # === run_main
  # ========================================================================= #
  def run_main
  end

  # ========================================================================= #
  # === set_commandline_arguments
  # ========================================================================= #
  def set_commandline_arguments(i = ARGV)
    @commandline_arguments = [i].flatten.compact
  end

  # ========================================================================= #
  # === commandline_arguments?
  # ========================================================================= #
  def commandline_arguments?
    @commandline_arguments
  end

end

# ========================================================================= #
# === LibuiParadise.register_this_fiddle_pointer_widget
# ========================================================================= #
def self.register_this_fiddle_pointer_widget(
    the_fiddle_pointer_widget,
    the_type_of_the_widget = nil
  )
  ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(
    the_fiddle_pointer_widget,
    the_type_of_the_widget
  )
end; self.instance_eval { alias add_to_the_registered_widgets register_this_fiddle_pointer_widget } # === LibuiParadise.add_to_the_registered_widgets

# =========================================================================== #
# === LibuiParadise.run_in_the_background
# =========================================================================== #
def self.run_in_the_background
  Process.daemon
end

# =========================================================================== #
# === LibuiParadise.notification
# =========================================================================== #
def self.notification(
    text         = 'Backup complete!',
    title_to_use = ''
  )
  ::LibuiParadise::Extensions.message_box(
    :default_window,
    text,
    title_to_use
  )
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

# =========================================================================== #
# === LibuiParadise.generic_window
#
# Usage example:
#
#   x = LibuiParadise.generic_window(LibuiParadise.button('1'), LibuiParadise.button('2'))
#   x = LibuiParadise.generic_window(LibuiParadise.button('1'), LibuiParadise.button('2')) {{ height: 50 }}
#   x = LibuiParadise.generic_window(LibuiParadise.button('1'), LibuiParadise.button('2')) {{ height: 50, width: 120 }}
#
# =========================================================================== #
def self.generic_window(
    *use_these_widgets,
    &block
  )
  unless LibuiParadise.respond_to?(:GenericWindow)
    require 'libui_paradise/generic_window/generic_window.rb'
  end
  generic_window = LibuiParadise::GenericWindow.new { :do_not_run_yet }
  # ========================================================================= #
  # === Handle blocks next
  # ========================================================================= #
  if block_given?
    yielded = yield
    if yielded.is_a? Hash
      # ===================================================================== #
      # === :height
      # ===================================================================== #
      if yielded.has_key?(:height)
        generic_window.set_height(
          yielded[:height]
        )
        generic_window.update_the_main_window
      end
      # ===================================================================== #
      # === :width
      # ===================================================================== #
      if yielded.has_key?(:width)
        generic_window.set_width(
          yielded[:width]
        )
        generic_window.update_the_main_window
      end
      # ===================================================================== #
      # === :title
      # ===================================================================== #
      if yielded.has_key?(:title)
        generic_window.set_title(
          yielded[:title]
        )
        generic_window.update_the_main_window
      end
    end
  end
  # ========================================================================= #
  # Next prepare adding more widgets to this generic window:
  # ========================================================================= #
  use_these_widgets.flatten!
  use_these_widgets.compact!
  if use_these_widgets.is_a?(Array) and !use_these_widgets.empty?
    generic_window.add_these_widgets(use_these_widgets)
  end
  return generic_window
end

end

alias e puts

LibuiParadise::Extensions.initializer # Make LibUI known here.

if __FILE__ == $PROGRAM_NAME
  pp LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
end