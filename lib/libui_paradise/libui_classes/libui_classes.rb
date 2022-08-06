#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/libui_classes/libui_classes.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  require 'libui_paradise/libui_classes/box.rb'
  require 'libui_paradise/libui_classes/grid.rb'

  # ========================================================================= #
  # === ui_open_file
  # ========================================================================= #
  def ui_open_file(
      main_window = ::LibuiParadise::Extensions.main_window?
    )
    return ::LibuiParadise::Extensions.open_file(main_window)
  end

  # ========================================================================= #
  # === message_box_error
  # ========================================================================= #
  def message_box_error(
      main_window  = LibuiParadise.main_window?,
      title_to_use = '',
      whatever     = ''
    )
    return ::LibuiParadise::Extensions.message_box_error(
      main_window,
      title_to_use,
      whatever
    )
  end; alias ui_msg_box_error          message_box_error # === ui_msg_box_error
       alias ui_error_msg              message_box_error # === ui_error_msg
       alias ui_error_message          message_box_error # === ui_error_message
       alias error_message_to_the_user message_box_error # === error_message_to_the_user

  # ========================================================================= #
  # === LibuiParadise::Extensions.message_box_error
  # ========================================================================= #
  def self.message_box_error(
      main_window  = LibuiParadise.main_window?,
      title_to_use = '',
      whatever     = ''
    )
    _ = ::LibUI.msg_box_error(
      main_window,
      title_to_use,
      whatever
    )
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_msg_box_error          message_box_error } # === LibuiParadise::Extensions.ui_msg_box_error
       self.instance_eval { alias ui_error_msg              message_box_error } # === LibuiParadise::Extensions.ui_error_msg
       self.instance_eval { alias ui_error_message          message_box_error } # === LibuiParadise::Extensions.ui_error_message
       self.instance_eval { alias error_message_to_the_user message_box_error } # === LibuiParadise::Extensions.error_message_to_the_user

  # ========================================================================= #
  # === LibuiParadise::Extensions.msg_box
  #
  # Official API documentation for dialogs can be found here:
  #
  #   https://github.com/andlabs/libui/blob/master/unix/stddialogs.c
  #
  # The API signature of msgbox is:
  #
  #   GtkWindow *parent
  #   const char *title
  #   const char *description
  #   GtkMessageType type
  #   GtkButtonsType buttons
  #
  # So the first string is the title and the second string is the description.
  #
  # This method is a convenience-wrapper over UI.msg_box().
  # ========================================================================= #
  def self.msg_box(
      main_window        = :default_window,
      title_to_use       = '',
      description_to_use = ''
    )
    case main_window
    # ======================================================================= #
    # === :default_window
    # ======================================================================= #
    when :default_window,
         :default
      main_window = ::LibuiParadise.main_window?
    end
    _ = ::LibUI.msg_box(
      main_window,
      title_to_use,
      description_to_use
    )
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_msg_box             msg_box } # === LibuiParadise::Extensions.ui_msg_box
       self.instance_eval { alias message_to_the_user    msg_box } # === LibuiParadise::Extensions.message_to_the_user
       self.instance_eval { alias message_box            msg_box } # === LibuiParadise::Extensions.message_box
       self.instance_eval { alias popup_over_this_widget msg_box } # === LibuiParadise::Extensions.popup_over_this_widget

  # ========================================================================= #
  # === ui_msg_box
  #
  # This method is a convenience-wrapper over UI.msg_box().
  # ========================================================================= #
  def ui_msg_box(
      main_window  = :default_window,
      title_to_use = '',
      whatever     = ''
    )
    ::LibuiParadise::Extensions.msg_box(
      main_window,
      title_to_use,
      whatever
    )
  end; alias message_to_the_user    ui_msg_box # === message_to_the_user
       alias message_box            ui_msg_box # === message_box
       alias popup_over_this_widget ui_msg_box # === popup_over_this_widget
       alias popup_message          ui_msg_box # === popup_message
       # alias msg_box                ui_msg_box # === msg_box
       # ^^^ this would lead to an error.

  # ========================================================================= #
  # === LibuiParadise::Extensions.open_file
  # ========================================================================= #
  def self.open_file(
      main_window = ::LibuiParadise::Extensions.main_window?
    )
    _ = ::LibUI.open_file(main_window)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_open_file open_file } # === LibuiParadise::Extensions.ui_open_file

  # ========================================================================= #
  # === open_file
  #
  # This here creates a problem, because ::Libui.open_file is already
  # defined. We'd have to use an alias to make this work.
  # ========================================================================= #
  # def open_file(
  #     main_window = LibuiParadise::Extensions.main_window?
  #   )
  #   return ::LibuiParadise::Extensions.open_file(main_window)
  # end; alias ui_open_file open_file # === ui_open_file

  # ========================================================================= #
  # === @main_window
  #
  # This variable can be used to keep track of the main window in use.
  # ========================================================================= #
  @main_window = nil

  # ========================================================================= #
  # === LibuiParadise::Extensions.main_window?
  # ========================================================================= #
  def self.main_window?
    @main_window
  end

  # ========================================================================= #
  # === main_window?
  # ========================================================================= #
  def main_window?
    ::LibuiParadise::Extensions.main_window?
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.set_main_window
  # ========================================================================= #
  def self.set_main_window(i)
    @main_window = i
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.window                         (window tag)
  #
  # This method will create a new main-window.
  #
  # It will also call UI.simple_exit(). This is done mostly so that we
  # can omit that line whenever we use e. g. ui_main_window().
  # ========================================================================= #
  def self.window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1, # hasMenubar or has not.
      &block
    )
    case the_title
    # ======================================================================= #
    # === :filename
    # ======================================================================= #
    when :filename,
         :file_name
      # ===================================================================== #
      # __FILE__ contains the desired name. We only need the raw name, though.
      # Well, in 2022 it was realized that the real filename is stored in
      # $PROGRAM_NAME, so ...
      # ===================================================================== #
      the_title = File.basename($PROGRAM_NAME) # (__FILE__)
    end
    raw_has_menubar = 0
    if has_menubar.is_a? Numeric
      raw_has_menubar = has_menubar
    end
    # ======================================================================= #
    # Instantiate a new main-window next:
    # ======================================================================= #
    main_window = LibUI.new_window(
      the_title,
      width,
      height,
      raw_has_menubar
    )
    set_main_window(main_window) # Keep a reference stored here.
    # ======================================================================= #
    # Since as of 30.08.2021 we will also register the main-window.
    #
    # In the long run we may obsolete and deprecate @main_window, since
    # it is no longer needed - but for now we will retain that variable.
    # ======================================================================= #
    add_to_the_registered_widgets(main_window, __method__)
    if has_menubar and has_menubar.is_a?(Hash)
      if has_menubar.has_key? :margin
        if has_menubar[:margin] == true
          main_window.has_margin
        end
      end
    end
    ::LibUI.simple_exit(main_window)
    if block_given?
      yield
    end
    return main_window # Always return it here.
  end; self.instance_eval { alias main_window     window } # === LibuiParadise::Extensions.main_window
       self.instance_eval { alias ui_main_window  window } # === LibuiParadise::Extensions.ui_main_window
       self.instance_eval { alias margined_window window } # === LibuiParadise::Extensions.margined_window
       self.instance_eval { alias ui_window       window } # === LibuiParadise::Extensions.ui_window
       self.instance_eval { alias window_or_vbox  window } # === LibuiParadise::Extensions.window_or_vbox

  # ========================================================================= #
  # === window
  # ========================================================================= #
  def window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1  # hasMenubar or has not.
    )
    LibuiParadise::Extensions.window(
      the_title, width, height, has_menubar
    )
  end; alias main_window    window # === main_window

  # ========================================================================= #
  # === ui_margined_main_window
  #
  # This variant is like ui_main_window() but it will automatically
  # put a margin on the window, via .is_margined().
  #
  # Note that the variant name "ui_padded_main_window" is a misnomer,
  # since it is a margin rather than padding - but I found that it
  # is easier to not care about this, so for the time being (September
  # 2021) this is how it is. It may be subject to change in the future,
  # though.
  # ========================================================================= #
  def ui_margined_main_window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1  # hasMenubar or has not.
    )
    _ = LibuiParadise.window(the_title, width, height, has_menubar)
    _.is_margined
    return _
  end; alias ui_margined_window    ui_margined_main_window # === ui_margined_window
       alias ui_padded_main_window ui_margined_main_window # === ui_padded_main_window
       alias margined_window       ui_margined_main_window # === margined_window
       alias padded_window         ui_margined_main_window # === padded_window
       alias ui_padded_window      ui_margined_main_window # === ui_padded_window
       alias padded_main_window    ui_margined_main_window # === padded_main_window
       alias ui_main_window        ui_margined_main_window # === ui_main_window
       alias ui_window             ui_margined_main_window # === ui_window
       alias window_or_vbox        ui_margined_main_window # === window_or_vbox

  # ========================================================================= #
  # === LibuiParadise::Extensions.new_progress_bar
  #
  # The upstream C API for the libui-progressbar can be found here:
  #
  #   https://github.com/andlabs/libui/blob/master/unix/progressbar.c
  #
  # ========================================================================= #
  def self.new_progress_bar
    _ = ::LibUI.new_progress_bar
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === new_progress_bar
  # ========================================================================= #
  def new_progress_bar
    return ::LibuiParadise::Extensions.new_progress_bar
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.slider
  # ========================================================================= #
  def self.slider(
      start_value =   0,
      end_value   = 100
    )
    _ = ::LibUI.new_slider(start_value, end_value)
    # ======================================================================= #
    # Register it at once:
    # ======================================================================= #
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_slider slider } # === LibuiParadise::Extensions.ui_slider

  # ========================================================================= #
  # === slider
  # ========================================================================= #
  def slider(
      start_value =   0,
      end_value   = 100
    )
    return ::LibuiParadise::Extensions.slider(start_value, end_value)
  end; alias ui_slider slider # === ui_slider

  # ========================================================================= #
  # === LibuiParadise::Extensions.horizontal_separator
  #
  # This method will add a new horizontal separator. The name "hsep"
  # is a shorter alias to this.
  # ========================================================================= #
  def self.horizontal_separator
    ::LibUI.new_horizontal_separator
  end; self.instance_eval { alias ui_hseparator     horizontal_separator } # === LibuiParadise::Extensions.ui_hseparator
       self.instance_eval { alias ui_hsep           horizontal_separator } # === LibuiParadise::Extensions.ui_hsep
       self.instance_eval { alias hspacer           horizontal_separator } # === LibuiParadise::Extensions.hspacer
       self.instance_eval { alias horizontal_spacer horizontal_separator } # === LibuiParadise::Extensions.horizontal_spacer
       self.instance_eval { alias hsep              horizontal_separator } # === LibuiParadise::Extensions.hsept

  # ========================================================================= #
  # === horizontal_separator
  # ========================================================================= #
  def horizontal_separator
    ::LibuiParadise::Extensions.horizontal_separator
  end; alias ui_hseparator     horizontal_separator # === ui_hseparator
       alias ui_hsep           horizontal_separator # === ui_hsep
       alias hspacer           horizontal_separator # === hspacer
       alias horizontal_spacer horizontal_separator # === horizontal_spacer
       alias hsep              horizontal_separator # === hsep
       alias libui_hsep        horizontal_separator # === libui_hsep

  # ========================================================================= #
  # === LibuiParadise::Extensions.search_entry
  # ========================================================================= #
  def self.search_entry
    _ = ::LibUI.new_search_entry
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_search_entry search_entry } # === LibuiParadise::Extensions.ui_search_entry

  # ========================================================================= #
  # === search_entry
  # ========================================================================= #
  def search_entry
    ::LibuiParadise::Extensions.search_entry
  end; alias ui_search_entry search_entry # === ui_search_entry

  # ========================================================================= #
  # === LibuiParadise::Extensions.entry                           (entry tag)
  #
  # The upstream C API for libui-entry can be found here:
  #
  #   https://github.com/andlabs/libui/blob/master/unix/entry.c
  #
  # This method is tapping into LibUI.new_entry.
  #
  # Usage example:
  #
  #   entry1 = LibUI.entry('ATG')
  #
  # ========================================================================= #
  def self.entry(
      optional_text = ''
    )
    optional_text = optional_text.to_s
    entry = ::LibUI.new_entry
    unless optional_text.empty?
      ::LibUI.entry_set_text(entry, optional_text)
    end
    add_to_the_registered_widgets(entry, __method__)
    return entry
  end; self.instance_eval { alias ui_entry entry } # === LibuiParadise::Extensions.ui_entry

  # ========================================================================= #
  # === entry                                                     (entry tag)
  #
  # This method is tapping into UI.new_entry.
  #
  # Usage example:
  #
  #   entry1 = ui_entry('ATG')
  #
  # ========================================================================= #
  def entry(
      optional_text = ''
    )
    ::LibuiParadise::Extensions.entry(optional_text)
  end; alias ui_entry entry # === ui_entry

  # ========================================================================= #
  # === text?
  #
  # This method will guarantee a String to be returned.
  #
  # This is a bit weird, though. We may have to remove this method one
  # day. I forgot why I added it to entry.rb specifically. After all
  # other widgets also should respond to .text?.
  # ========================================================================= #
  def text?(from_this_pointer)
    _ = ::LibUI.entry_text(from_this_pointer).to_s
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.non_wrapping_multiline_entry
  #
  # The upstream C API for the non-wrapping multiline edit can be found here:
  #
  #   https://raw.githubusercontent.com/andlabs/libui/master/unix/multilineentry.c
  #
  # ========================================================================= #
  def self.non_wrapping_multiline_entry
    _ = ::LibUI.new_non_wrapping_multiline_entry
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.font                  (font tag, fonts tag)
  # ========================================================================= #
  def self.font(&block)
    use_this_font = ::LibUI::FFI::FontDescriptor.malloc
    if block_given?
      yielded = yield
      if yielded.is_a? Hash
        # =================================================================== #
        # === :font_size
        # =================================================================== #
        if yielded.has_key? :font_size
          use_this_font.Size = yielded.delete(:font_size)
        end
        # =================================================================== #
        # === :font_family
        # =================================================================== #
        if yielded.has_key? :font_family
          use_this_font.Family = yielded.delete(:font_family)
        end
        # =================================================================== #
        # === :stretch
        # =================================================================== #
        if yielded.has_key? :stretch
          use_this_font.Stretch = yielded.delete(:stretch)
        end
        # =================================================================== #
        # === :weight
        # =================================================================== #
        if yielded.has_key? :weight
          use_this_font.Weight = yielded.delete(:weight)
        end
        # =================================================================== #
        # === :italic
        # =================================================================== #
        if yielded.has_key? :italic
          _ = yielded.delete(:italic_family)
          if _ == true
            _ = 1
          elsif _ == false
            _ = 0
          end
          use_this_font.Italic = _
        end
      end
    end
    return use_this_font
  end; self.instance_eval { alias ui_font         font } # === LibuiParadise::Extensions.ui_font
       self.instance_eval { alias font_descriptor font } # === LibuiParadise::Extensions.font_descriptor

  # ========================================================================= #
  # === font
  # ========================================================================= #
  def font(&block)
    LibuiParadise::Extensions.font(&block)
  end; alias ui_font         font # === ui_font
       alias font_descriptor font # === font_descriptor

  # ========================================================================= #
  # === LibuiParadise::Extensions.non_wrapping_multiline_entry
  # ========================================================================= #
  def non_wrapping_multiline_entry
    return ::LibuiParadise::Extensions.non_wrapping_multiline_entry
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.menu                             (menu tag)
  # ========================================================================= #
  def self.menu(title = '')
    _ = ::LibUI.new_menu(title)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_menu menu } # === ui_menu

  # ========================================================================= #
  # === menu                                                       (menu tag)
  # ========================================================================= #
  def menu(
      title = ''
    )
    return ::LibuiParadise::Extensions.menu(title)
  end; alias ui_menu menu # === ui_menu

  # ========================================================================= #
  # === LibuiParadise::Extensions.vertical_separator
  #
  # This method will add a new vertical separator.
  # ========================================================================= #
  def self.vertical_separator
    ::LibUI.new_vertical_separator
  end; self.instance_eval { alias ui_vseparator     vertical_separator } # === LibuiParadise::Extensions.ui_verticalseparator
       self.instance_eval { alias ui_vsep           vertical_separator } # === LibuiParadise::Extensions.ui_vsep
       self.instance_eval { alias vspacer           vertical_separator } # === LibuiParadise::Extensions.vspacer
       self.instance_eval { alias vertical_spacer   vertical_separator } # === LibuiParadise::Extensions.vertical_spacer
       self.instance_eval { alias vsep              vertical_separator } # === LibuiParadise::Extensions.vsept

  # ========================================================================= #
  # === vertical_separator
  # ========================================================================= #
  def vertical_separator
    ::LibuiParadise::Extensions.vertical_separator
  end; alias ui_vseparator     vertical_separator # === ui_vseparator
       alias ui_vsep           vertical_separator # === ui_vsep
       alias vertical_spacer   vertical_separator # === vertical_spacer
       alias vspacer           vertical_separator # === vspacer
       alias vsep              vertical_separator # === vsep

  # ========================================================================= #
  # === LibuiParadise::Extensions.spinbox
  #
  # This method will return a spin-button, also called a spin-box.
  #
  # The first argument is the start value; the second argument is the end
  # value.
  # ========================================================================= #
  def self.spinbox(
      start_point =   0,
      end_point   = 100
    )
    if start_point.is_a? Hash
      # ===================================================================== #
      # === :end
      # ===================================================================== #
      if start_point.has_key? :end
        end_point = start_point[:end]
      end
      # ===================================================================== #
      # === :start
      # ===================================================================== #
      if start_point.has_key? :start
        start_point = start_point[:start]
      end
    end
    _ = ::LibUI.new_spinbox(start_point.to_i, end_point.to_i)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_spinbox    spinbox } # === LibuiParadise::Extensions.ui_spinbox
       self.instance_eval { alias ui_spinbutton spinbox } # === LibuiParadise::Extensions.ui_spinbutton
       self.instance_eval { alias spinbutton    spinbox } # === LibuiParadise::Extensions.spinbutton

  # ========================================================================= #
  # === LibuiParadise::Extensions.password_entry
  #
  # This method will create and returns a new password entry widget. This
  # means that input will be "disguised" via the '*' character.
  #
  # Usage example:
  #
  #   entry = LibuiParadise::Extensions.password_entry
  #
  # ========================================================================= #
  def self.password_entry
    entry = ::LibUI.new_password_entry
    add_to_the_registered_widgets(entry, __method__)
    return entry
  end; self.instance_eval { alias ui_password_entry password_entry } # === LibuiParadise::Extensions.ui_password_entry

  # ========================================================================= #
  # === password_entry
  #
  # Usage example:
  #
  #   entry = ui_password_entry
  #
  # ========================================================================= #
  def password_entry
    ::LibuiParadise::Extensions.password_entry
  end; alias ui_password_entry password_entry # === ui_password_entry

  # ========================================================================= #
  # === LibuiParadise::Extensions.text_layout
  # ========================================================================= #
  def self.text_layout(
      i = ''
    )
    _ = ::LibUI.draw_new_text_layout(i.to_s)
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === text_layout
  # ========================================================================= #
  def text_layout(
      i = ''
    )
    ::LibuiParadise::Extensions.text_layout(i)
  end

  # ========================================================================= #
  # === spinbox
  #
  # This method will return a spin-button, also called a spin-box.
  # ========================================================================= #
  def spinbox(
      start_point =   0,
      end_point   = 100
    )
    ::LibuiParadise::Extensions.spinbox(start_point, end_point)
  end; alias ui_spinbox          spinbox # === ui_spinbox
       alias ui_spinbutton       spinbox # === ui_spinbutton
       alias up_and_down_counter spinbox # === up_and_down_counter
       alias spinbutton          spinbox # === spinbutton

  # ========================================================================= #
  # === LibuiParadise::Extensions.table
  #
  # The argument should be of type table_params.
  #
  # Example for this:
  #
  #   table_params = LibUI::FFI::TableParams.malloc
  #   table_params.Model = model
  #   table_params.RowBackgroundColorModelColumn = -1
  #
  # ========================================================================= #
  def self.table(i)
    _ = ::LibUI.new_table(i)
    LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias ui_table table } # === LibuiParadise::Extensions.ui_table

  # ========================================================================= #
  # === LibuiParadise::Extensions.checkbox                     (checkbox tag)
  # ========================================================================= #
  def self.checkbox(i = '')
    _ = ::LibUI.new_checkbox(i)
    add_to_the_registered_widgets(_, __method__)
    return _
  end

  # ========================================================================= #
  # === checkbox
  # ========================================================================= #
  def checkbox(i = '')
    ::LibuiParadise::Extensions.checkbox(i)
  end; alias ui_checkbox     checkbox # === ui_checkbox
       alias ui_check_button checkbox # === ui_check_button

  # ========================================================================= #
  # === LibuiParadise::Extensions.button                         (button tag)
  #
  # The upstream API for buttons, in C, can be found here:
  #
  #   https://raw.githubusercontent.com/andlabs/libui/master/unix/button.c
  #
  # ========================================================================= #
  def self.button(text)
    _ = ::LibUI.new_button(text)
    ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias ui_button button } # === LibuiParadise::Extensions.ui_button

  # ========================================================================= #
  # === LibuiParadise::Extensions.multiline_entry       (multiline_entry tag)
  #
  # The upstream code for the linux-variant for a multiline-entry can
  # be found here:
  #
  #   https://raw.githubusercontent.com/andlabs/libui/master/unix/multilineentry.c
  #
  # A multiline-entry, also known more traditionally as a "textview",
  # is a widget that allows the user to input text and modify that
  # text as well.
  # ========================================================================= #
  def self.multiline_entry(optional_content = nil)
    _ = ::LibUI.new_multiline_entry
    add_to_the_registered_widgets(_, __method__)
    if optional_content and optional_content.is_a?(String) and !optional_content.empty?
      _.set_text(optional_content)
    end
    return _
  end; self.instance_eval { alias ui_multiline_entry multiline_entry } # === LibuiParadise::Extensions.ui_multiline_entry
       self.instance_eval { alias textview           multiline_entry } # === LibuiParadise::Extensions.textview
       self.instance_eval { alias text_view          multiline_entry } # === LibuiParadise::Extensions.text_view
       self.instance_eval { alias ui_text_view       multiline_entry } # === LibuiParadise::Extensions.ui_text_view
       self.instance_eval { alias ui_textview        multiline_entry } # === LibuiParadise::Extensions.ui_textview
       self.instance_eval { alias ui_text_buffer     multiline_entry } # === LibuiParadise::Extensions.ui_text_buffer
       self.instance_eval { alias input_field        multiline_entry } # === LibuiParadise::Extensions.input_field
       self.instance_eval { alias input              multiline_entry } # === LibuiParadise::Extensions.input

  # ========================================================================= #
  # === Libuiparadise::Extensions.image
  #
  # This is currently limited to .png files only, due to ChunkyPng.
  #
  # At some later point in the future this limitation may be lifted. For
  # now it has to remain in place.
  # ========================================================================= #
  def self.image(
      this_file,
      width  = :try_to_infer_automatically,
      height = :infer_automatically
    )
    if (width  == :infer_automatically) or
       (height == :infer_automatically)
      unless Object.const_defined? :ChunkyPNG
        begin
          require 'chunky_png'
        rescue LoadError; end
      end
      canvas = ChunkyPNG::Canvas.from_file(this_file)
      data   = canvas.to_rgba_stream
      width  = canvas.width
      height = canvas.height
      _ = ::LibUI.new_image(width, height) # Create the image here.
      add_to_the_registered_widgets(_, __method__)
      ::LibUI.image_append(
        _,
        data,
        width,
        height,
        width
      )
      return _
    end
    nil
  end; self.instance_eval { alias ui_image image } # === LibuiParadise::Extensions.ui_image

  # ========================================================================= #
  # === LibuiParadise::Extensions.font_button
  #
  # Create a new font button via this method.
  # ========================================================================= #
  def self.font_button
    _ = ::LibUI.new_font_button
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_font_button font_button } # === Libuiparadise::Extensions.ui_font_button

  # ========================================================================= #
  # === font_button
  #
  # Create a new font button via this method.
  # ========================================================================= #
  def font_button
    return ::LibuiParadise::Extensions.font_button
  end; alias ui_font_button font_button # === ui_font_button

  # ========================================================================= #
  # === image
  #
  # This is currently limited to .png files only, due to ChunkyPng.
  #
  # At some later point in the future this limitation may be lifted. For
  # now it has to remain in place.
  # ========================================================================= #
  def image(
      this_file,
      width  = :try_to_infer_automatically,
      height = :infer_automatically
    )
    Libuiparadise::Extensions.image(
      this_file, width, height
    )
  end; alias ui_image image # === ui_image

  # ========================================================================= #
  # === multiline_entry
  # ========================================================================= #
  def multiline_entry(optional_content = nil)
    ::LibuiParadise::Extensions.multiline_entry(optional_content)
  end; alias ui_multiline_entry multiline_entry # === ui_multiline_entry
       alias textview           multiline_entry # === textview
       alias text_view          multiline_entry # === text_view
       alias ui_text_view       multiline_entry # === ui_text_view
       alias ui_textview        multiline_entry # === ui_textview
       alias ui_text_buffer     multiline_entry # === ui_text_buffer
       alias input_field        multiline_entry # === input_field
       alias input              multiline_entry # === input

  # ========================================================================= #
  # === LibuiParadise::Extensions.radio_buttons
  #
  # This method will create some radio buttons.
  #
  # You can pass an Array into this method, which should be an Array of
  # Strings. This is optional. If such an Array is given, though, then
  # these entries will become radio-buttons, with the associated label
  # (the text they display) becoming the label right next to the radio
  # button element (that round circle that the user can select via
  # the mouse cursor).
  # ========================================================================= #
  def self.radio_buttons(
      optional_array = []
    )
    _ = ::LibUI.new_radio_buttons
    if optional_array and optional_array.is_a?(Array) and !optional_array.empty?
      optional_array.each {|this_element|
        ::LibUI.radio_buttons_append(_, this_element)
      }
    end
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_radio_buttons radio_buttons } # === LibuiParadise::Extensionsui_radio_buttons

  # ========================================================================= #
  # === radio_buttons
  # ========================================================================= #
  def radio_buttons(optional_array = [])
    return ::LibuiParadise::Extensions.radio_buttons(optional_array)
  end; alias ui_radio_buttons radio_buttons # === ui_radio_buttons

  # ========================================================================= #
  # === LibuiParadise::Extensions.new_colour_button
  #
  # The upstream API for a colour-button (in C) can be found here:
  #
  #   https://github.com/andlabs/libui/blob/master/unix/colorbutton.c
  #
  # ========================================================================= #
  def self.colour_button
    _ = ::LibUI.new_color_button
    ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias new_colour_button colour_button } # === LibuiParadise::Extensions.new_colour_button
       self.instance_eval { alias new_color_button  colour_button } # === LibuiParadise::Extensions.new_color_button
       self.instance_eval { alias ui_colour_button  colour_button } # === LibuiParadise::Extensions.ui_colour_button

  # ========================================================================= #
  # === colour_button
  # ========================================================================= #
  def colour_button
    ::LibuiParadise::Extensions.new_colour_button
  end; alias color_button     colour_button # === color_button
       alias ui_colour_button colour_button # === ui_color_button

  # ========================================================================= #
  # === LibuiParadise::Extensions.scrolling_area
  #
  # It seems as if scrolling is not yet easily available in libui.
  #
  # The upstream API is like this:
  #
  #   uiArea *area = uiNewScrollingArea(&handler, 400, 400);
  #
  # The two numbers are width and height, as integers, respectively.
  # In total three arguments are required. The first argument is
  # a so-called "AreaHandler".
  #
  # The code may be found here:
  #
  #   https://github.com/andlabs/libui/blob/master/windows/areascroll.cpp
  #
  # ========================================================================= #
  def self.scrolling_area(
      widget,
      width           = 400,
      height          = 400
    )
    case width
    when :default, nil
      width = 400
    end
    case height
    when :default, nil
      height = 400
    end
    _ = ::LibUI.new_scrolling_area(widget, width, height)
    # ======================================================================= #
    # The next part does not yet work - is it even possible to add widgets
    # to a scrolling area in libui?
    # if optional_widget
    #   _.add(optional_widget)
    # end
    # ======================================================================= #
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_scrolling_area  scrolling_area } # === LibuiParadise::Extensions.ui_scrolling_area
       self.instance_eval { alias ui_scrolled_window scrolling_area } # === LibuiParadise::Extensions.ui_scrolling_window

  # ========================================================================= #
  # === scrolling_area
  #
  # It seems as if scrolling is not yet easily available in libui.
  #
  # The upstream API is like this:
  #
  #   uiArea *area = uiNewScrollingArea(&handler, 400, 400);
  #
  # ========================================================================= #
  def scrolling_area(
      optional_widget = nil
    )
    LibuiParadise::Extensions.scrolling_area(optional_widget)
  end; alias ui_scrolling_area  scrolling_area # === ui_scrolling_area
       alias ui_scrolled_window scrolling_area # === ui_scrolling_window

  # ========================================================================= #
  # === bold_button
  #
  # This currently does not work. We have to wait until upstream libui
  # supports bold font text.
  # ========================================================================= #
  def bold_button(i)
    button(i)
  end

  # ========================================================================= #
  # === button                                                   (button tag)
  # ========================================================================= #
  def button(text)
    text = text.to_s.dup
    if text.start_with? '_'
      text[0,1] = '' # Right now we do not support accelerators.
    end
    ::LibuiParadise::Extensions.button(text)
  end; alias ui_button button # === ui_button

  # ========================================================================= #
  # === quit_button                                                (quit tag)
  #
  # This method can be used to, by default, implement a quit button
  # that, upon a click-event, will cause the application to exit
  # and close/quit.
  # ========================================================================= #
  def quit_button(
      optional_arguments = {}
    )
    use_this_text = 'Quit'
    if optional_arguments and optional_arguments.is_a?(Hash)
      # ===================================================================== #
      # === :text
      # ===================================================================== #
      if optional_arguments.has_key? :text
        use_this_text = optional_arguments.delete(:text)
      end
    end
    if block_given?
      yielded = yield
      case yielded
      # ===================================================================== #
      # === :with_emoji
      # ===================================================================== #
      when :with_emoji,
           :with_icon
        use_this_text = use_this_text.to_s.dup
        use_this_text << ' 🛑'
      end
    end
    quit_button = button(use_this_text)
    quit_button.on_clicked {
      ::LibUI.quit
      0
    }
    return quit_button
  end; alias ui_quit_button quit_button # === ui_quit_button

  # ========================================================================= #
  # === table
  # ========================================================================= #
  def table(i)
    ::LibuiParadise::Extensions.table(i)
  end; alias ui_table table # === ui_table

  # ========================================================================= #
  # === LibuiParadise::Extensions.editable_combobox
  #
  # This is a combo-box that the user can modify.
  # ========================================================================= #
  def self.editable_combobox(
      optional_array = nil, &block
    )
    _ = ::LibUI.new_editable_combobox
    if block_given?
      optional_array = yield
    end
    if optional_array and optional_array.is_a?(Array)
      append_this_array_to_that_combobox(optional_array, _)
    end
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias editable_combo_box    editable_combobox } # === LibuiParadise::Extensions.editable_combo_box
       self.instance_eval { alias ui_editable_combo_box editable_combobox } # === LibuiParadise::Extensions.ui_editable_combo_box

  # ========================================================================= #
  # === LibuiParadise::Extensions.combobox
  # ========================================================================= #
  def self.combobox(
      optional_array = nil, &block
    )
    combobox = ::LibUI.new_combobox
    # ======================================================================= #
    # Register it at once:
    # ======================================================================= #
    add_to_the_registered_widgets(combobox, __method__)
    if block_given?
      optional_array = yield
    end
    if optional_array and optional_array.is_a?(Array)
      # append_this_array_to_that_combobox(optional_array, combobox)
      combobox.append_this_array(optional_array)
    end
    return combobox
  end; self.instance_eval { alias combo_box    combobox } # === LibuiParadise::Extensions.combo_box
       self.instance_eval { alias ui_combo_box combobox } # === LibuiParadise::Extensions.ui_combo_box
       self.instance_eval { alias ui_combobox  combobox } # === LibuiParadise::Extensions.ui_combobox

  # ========================================================================= #
  # === selected?
  #
  # Unsure whether this works. It appears to work, but I am not even
  # certain as to why.
  # ========================================================================= #
  def selected?(pointer)
    ::LibUI.combobox_selected(pointer).to_s
  end

  # ========================================================================= #
  # === combobox
  #
  # The first argument can be an Array.
  # ========================================================================= #
  def combobox(
      optional_array = nil, &block
    )
    return ::LibuiParadise::Extensions.combobox(optional_array, &block)
  end; alias combo_box       combobox # === combo_box
       alias ui_combo_box    combobox # === ui_combo_box
       alias ui_combobox     combobox # === ui_combobox
       alias combo_box_entry combobox # === combo_box_entry
       alias libui_combo_box combobox # === libui_combo_box

  # ========================================================================= #
  # === editable_combobox
  # ========================================================================= #
  def editable_combobox(
      optional_array = nil, &block
    )
    return ::LibuiParadise::Extensions(optional_array, &block)
  end; alias editable_combo_box    editable_combobox # === editable_combo_box
       alias ui_editable_combo_box editable_combobox # === ui_editable_combo_box

  # ========================================================================= #
  # === LibuiParadise::Extensions.label                (text tag, label tag)
  #
  # Add text to the widget at hand. This is actually called a "label".
  # ========================================================================= #
  def self.label(
      i = ''
    )
    if i.include? '</'
      # ===================================================================== #
      # For now we must remove "HTML tags" from the given input. Perhaps
      # at some later point in time we can retain them.
      # ===================================================================== #
      i = i.dup if i.frozen?
      i.gsub!(%r{<[^>]+>}, '')
    end
    _ = ::LibUI.new_label(i.to_s)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias text     label } # === LibuiParadise::Extensions.text
       self.instance_eval { alias ui_text  label } # === LibuiParadise::Extensions.ui_text
       self.instance_eval { alias ui_label label } # === LibuiParadise::Extensions.ui_label

  # ========================================================================= #
  # === label
  #
  # The last two aliases, left_aligned_label, should be different, but
  # right now I don't know how to do this in libui.
  # ========================================================================= #
  def label(
      i = ''
    )
    ::LibuiParadise::Extensions.label(i)
  end; alias text               label # === text
       alias ui_text            label # === ui_text
       alias ui_label           label # === ui_label
       alias left_aligned_label label # === left_aligned_label
       alias left_aligned_text  label # === left_aligned_text

  # ========================================================================= #
  # === bold_label
  #
  # This currently does not work properly. We may have to re-examine this
  # eventually at a later point.
  # ========================================================================= #
  def bold_label(i = '')
    return label(i)
  end

  # ========================================================================= #
  # === bold_text
  #
  # This currently does NOT make the text bold - the method exists solely
  # as a placeholder, until upstream libui supports bold text as such.
  # ========================================================================= #
  def bold_text(i = '')
    return label(i)
  end

  # ========================================================================= #
  # === bold_text_left_aligned
  # ========================================================================= #
  def bold_text_left_aligned(i = '')
    return label(i)
  end

  # ========================================================================= #
  # === fancy_text
  #
  # This text variant can be styled.
  # ========================================================================= #
  def fancy_text(i = '')
    _ = LibUI.new_attributed_string(i.to_s)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; alias attributed_string fancy_text # === attributed_string

  # ========================================================================= #
  # === LibuiParadise::Extensions.tab
  #
  # This could be also called "notebook_tab".
  # ========================================================================= #
  def self.tab
    _ = ::LibUI.new_tab
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_tab       tab } # === LibuiParadise::Extensions.ui_tab
       self.instance_eval { alias ui_tabs      tab } # === LibuiParadise::Extensions.ui_tabs
       self.instance_eval { alias notebook     tab } # === LibuiParadise::Extensions.notebook
       self.instance_eval { alias ui_notebook  tab } # === LibuiParadise::Extensions.ui_notebook
       self.instance_eval { alias notebook_tab tab } # === LibuiParadise::Extensions.notebook_tab

  # ========================================================================= #
  # === tab
  #
  # This could be also called "notebook_tab".
  # ========================================================================= #
  def tab
    ::LibuiParadise::Extensions.tab
  end; alias ui_tab       tab # === ui_tab
       alias ui_tabs      tab # === ui_tabs
       alias notebook     tab # === notebook
       alias ui_notebook  tab # === ui_notebook
       alias notebook_tab tab # === notebook_tab

  # ========================================================================= #
  # === LibuiParadise::Extensions.area
  #
  # AreaHandler defines the functionality needed for handling events from
  # an Area.
  #
  # Upstream documentation, at the least for Go, can be found here:
  #
  #   https://github.com/andlabs/ui/blob/master/areahandler.go
  #
  # ========================================================================= #
  def self.area(
      i = :use_new_area_handler
    )
    case i
    # ======================================================================= #
    # === :use_new_area_handler
    # ======================================================================= #
    when :use_new_area_handler,
         :default
      # ===================================================================== #
      # malloc a new area-handled next:
      # ===================================================================== #
      i = ::LibUI::FFI::AreaHandler.malloc
      i.to_ptr.free = Fiddle::RUBY_FREE # This one is done in upstream LibUI as well.
    end
    _ = ::LibUI.new_area(i) # Our new area, with the given handler.
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias area_handler area } # === LibuiParadise::Extensions.area_handler

  # ========================================================================= #
  # === area
  #
  # AreaHandler defines the functionality needed for handling events
  # from an Area.
  #
  # Upstream documentation, at the least for Go, can be found here:
  #
  #   https://github.com/andlabs/ui/blob/master/areahandler.go
  #
  # ========================================================================= #
  def area(
      i = :use_new_area_handler
    )
    return ::LibuiParadise::Extensions.area(i)
  end; alias area_handler area # === area_handler

  # ========================================================================= #
  # === is_on_windows?
  # ========================================================================= #
  def is_on_windows?
    Gem.win_platform?
  end

end

# =========================================================================== #
# === LibuiParadise.window
# =========================================================================== #
def self.window(
    the_title   = '',  # Pick a title for the window here.
    width       = 500, # width  in n pixels.
    height      = 300, # height in n pixels.
    has_menubar =   1  # hasMenubar or has not.
  )
  ::LibuiParadise::Extensions.window(
    the_title,
    width,
    height,
    has_menubar
  )
end; self.instance_eval { alias main_window           window } # === LibuiParadise.main_window
     self.instance_eval { alias margined_window       window } # === LibuiParadise.margined_window
     self.instance_eval { alias ui_window             window } # === LibuiParadise.ui_window
     self.instance_eval { alias ui_main_window        window } # === LibuiParadise.ui_main_window
     self.instance_eval { alias ui_padded_main_window window } # === LibuiParadise.margined_window
     self.instance_eval { alias padded_window         window } # === LibuiParadise.padded_window
     self.instance_eval { alias padded_main_window    window } # === LibuiParadise.padded_main_window
     self.instance_eval { alias window_or_vbox        window } # === LibuiParadise.window_or_vbox

# =========================================================================== #
# === LibuiParadise.main_window?
# =========================================================================== #
def self.main_window?
  LibuiParadise::Extensions.main_window?
end

# =========================================================================== #
# === LibuiParadise::Extensions.editable_combobox
# =========================================================================== #
def self.editable_combobox(
    optional_array = nil, &block
  )
  return ::LibuiParadise::Extensions.editable_combobox(optional_array, &block)
end; self.instance_eval { alias editable_combo_box    editable_combobox } # === LibuiParadise.editable_combo_box
     self.instance_eval { alias ui_editable_combo_box editable_combobox } # === LibuiParadise.ui_editable_combo_box

# ========================================================================= #
# === LibuiParadise.label
#
# Toplevel method to create a new label, aka new text.
# ========================================================================= #
def self.label(
    i = ''
  )
  ::LibuiParadise::Extensions.label(i)
end; self.instance_eval { alias text     label } # === LibuiParadise.text
     self.instance_eval { alias ui_text  label } # === LibuiParadise.ui_text
     self.instance_eval { alias ui_label label } # === LibuiParadise.ui_label

# ========================================================================= #
# === LibuiParadise.string
# ========================================================================= #
def self.string(i = '')
  return ::LibUI.new_attributed_string(i)
end; self.instance_eval { alias fancy_text string } # === LibuiParadise.fancy_text

# =========================================================================== #
# === LibuiParadise.table
# =========================================================================== #
def self.table(i)
  ::LibuiParadise::Extensions.table(i)
end; self.instance_eval { alias ui_table table } # === LibuiParadise.ui_table

# =========================================================================== #
# === LibuiParadise.spinbox
# =========================================================================== #
def self.spinbox(
    start_point =   0,
    end_point   = 100
  )
  ::LibuiParadise::Extensions.spinbox(start_point, end_point)
end; self.instance_eval { alias ui_spinbox    spinbox } # === LibuiParadise.ui_spinbox
     self.instance_eval { alias ui_spinbutton spinbox } # === LibuiParadise.ui_spinbutton
     self.instance_eval { alias spinbutton    spinbox } # === LibuiParadise.spinbutton

# =========================================================================== #
# === LibuiParadise.slider
# =========================================================================== #
def self.slider(
    start_value =   0,
    end_value   = 100
  )
  ::LibuiParadise::Extensions.slider(start_value, end_value)
end; self.instance_eval { alias ui_slider slider } # === LibuiParadise.ui_slider

# =========================================================================== #
# === LibuiParadise.button
# =========================================================================== #
def self.button(text)
  ::LibuiParadise::Extensions.button(text)
end

# =========================================================================== #
# === LibuiParadise.checkbox
# =========================================================================== #
def self.checkbox(i = '')
  ::LibuiParadise::Extensions.checkbox(i)
end

# =========================================================================== #
# === LibuiParadise.open_file
# =========================================================================== #
def self.open_file(
    main_window = LibuiParadise::Extensions.main_window?
  )
  return ::LibuiParadise::Extensions.open_file(main_window)
end; self.instance_eval { alias ui_open_file open_file } # === LibuiParadise.ui_open_file

# =========================================================================== #
# === LibuiParadise.msg_box
# =========================================================================== #
def self.msg_box(
    main_window  = :default_window,
    title_to_use = '',
    whatever     = ''
  )
  ::LibuiParadise::Extensions.msg_box(
    main_window,
    title_to_use,
    whatever
  )
end; self.instance_eval { alias ui_msg_box             msg_box } # === LibuiParadise.ui_msg_box
     self.instance_eval { alias message_to_the_user    msg_box } # === LibuiParadise.message_to_the_user
     self.instance_eval { alias message_box            msg_box } # === LibuiParadise.message_box
     self.instance_eval { alias popup_over_this_widget msg_box } # === LibuiParadise.popup_over_this_widget
     self.instance_eval { alias popup_message          msg_box } # === LibuiParadise.popup_message

# =========================================================================== #
# === LibuiParadise.new_progress_bar
# =========================================================================== #
def self.new_progress_bar
  return ::LibuiParadise::Extensions.new_progress_bar
end

# ========================================================================= #
# === LibuiParadise.vertical_separator
# ========================================================================= #
def self.vertical_separator
  ::LibuiParadise::Extensions.vertical_separator
end; self.instance_eval { alias ui_vseparator vertical_separator } # === LibuiParadise.ui_vseparator
     self.instance_eval { alias ui_vsep       vertical_separator } # === LibuiParadise.ui_vsep
     self.instance_eval { alias vsep          vertical_separator } # === LibuiParadise.vsep

# =========================================================================== #
# === LibuiParadise.text_layout
# =========================================================================== #
def self.text_layout(
    i = ''
  )
  ::LibuiParadise::Extensions.text_layout(i)
end

# =========================================================================== #
# === LibuiParadise.search_entry
# =========================================================================== #
def self.search_entry
  ::LibuiParadise::Extensions.search_entry
end; self.instance_eval { alias ui_search_entry search_entry } # === LibuiParadise.ui_search_entry

# =========================================================================== #
# === LibuiParadise.scrolling_area
# =========================================================================== #
def self.scrolling_area(
    widget,
    width  = :default,
    height = :default
  )
  ::LibuiParadise::Extensions.scrolling_area(widget, width, height)
end

# =========================================================================== #
# === LibuiParadise.radio_buttons
# =========================================================================== #
def self.radio_buttons(optional_array = [])
  return ::LibuiParadise::Extensions.radio_buttons(optional_array)
end

# =========================================================================== #
# === LibuiParadise.password_entry
# =========================================================================== #
def self.password_entry
  ::LibuiParadise::Extensions.password_entry
end; self.instance_eval { alias ui_password_entry password_entry } # === LibuiParadise.ui_password_entry

# =========================================================================== #
# === LibuiParadise.non_wrapping_multiline_entry
# =========================================================================== #
def self.non_wrapping_multiline_entry
  return ::LibuiParadise::Extensions.non_wrapping_multiline_entry
end

# =========================================================================== #
# === LibuiParadise.multiline_entry
# =========================================================================== #
def self.multiline_entry(optional_content = nil)
  ::LibuiParadise::Extensions.multiline_entry(optional_content)
end; self.instance_eval { alias textview           multiline_entry } # === LibuiParadise.textview
     self.instance_eval { alias text_view          multiline_entry } # === LibuiParadise.text_view
     self.instance_eval { alias ui_text_view       multiline_entry } # === LibuiParadise.ui_text_view
     self.instance_eval { alias ui_textview        multiline_entry } # === LibuiParadise.ui_textview
     self.instance_eval { alias ui_text_buffer     multiline_entry } # === LibuiParadise.ui_text_buffer
     self.instance_eval { alias input_field        multiline_entry } # === LibuiParadise.input_field

# =========================================================================== #
# === LibuiParadise.menu
# =========================================================================== #
def self.menu(title = '')
  return LibuiParadise::Extensions.menu(title)
end; self.instance_eval { alias ui_menu menu } # === LibuiParadise.ui_menu

# ========================================================================= #
# === Libuiparadise.image
# ========================================================================= #
def self.image(
    this_file,
    width  = :try_to_infer_automatically,
    height = :infer_automatically
  )
  ::LibuiParadise::Extensions.image(
    this_file, width, height
  )
end; self.instance_eval { alias ui_image image } # === LibuiParadise.ui_image

# =========================================================================== #
# === LibuiParadise.colour_button
# =========================================================================== #
def self.colour_button
  ::LibuiParadise::Extensions.new_colour_button
end; self.instance_eval { alias color_button colour_button } # === LibuiParadise.color_button

# =========================================================================== #
# === LibuiParadise.font_button
# =========================================================================== #
def self.font_button
  return ::LibuiParadise::Extensions.font_button
end

# ========================================================================= #
# === LibuiParadise.horizontal_separator
# ========================================================================= #
def self.horizontal_separator
  ::LibuiParadise::Extensions.horizontal_separator
end; self.instance_eval { alias ui_hseparator horizontal_separator } # === LibuiParadise.ui_hseparator
     self.instance_eval { alias ui_hsep       horizontal_separator } # === LibuiParadise.ui_hsep
     self.instance_eval { alias hsep          horizontal_separator } # === LibuiParadise.hsep

# =========================================================================== #
# === LibuiParadise.font
# =========================================================================== #
def self.font(&block)
  ::LibuiParadise::Extensions.font(&block)
end

# =========================================================================== #
# === LibuiParadise.entry
# =========================================================================== #
def self.entry(
    optional_text = ''
  )
  ::LibuiParadise::Extensions.entry(optional_text)
end; self.instance_eval { alias ui_entry entry } # === LibuiParadise.ui_entry

end