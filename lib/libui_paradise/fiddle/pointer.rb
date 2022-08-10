#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === Fiddle::Pointer
#
# Modify Fiddle::Pointer - but this is super-specific to Libui, so it is
# really not recommended to do this.
#
# A cleaner solution would be to modify just in-place, such as via
# refinements, but I don't quite like the syntax of refinements,
# so I opted for the simpler toplevel modification instead.
# =========================================================================== #
# require 'libui_paradise/fiddle/pointer.rb'
# =========================================================================== #
module Fiddle

class Pointer # === Fiddle::Pointer

  # ========================================================================= #
  # === hash_grid
  #
  # Usage example:
  #
  #   hash_grid(text('Yo6'), { left: 0, top: 3, xspan: 1, yspan: 1, hexpand: 0, halign: 0, vexpand: 0, valign: 0 })
  #
  # ========================================================================= #
  def hash_grid(
      pass_this_widget,
      hash = {}
    )
    array_to_be_passed = []
    # ======================================================================= #
    # === :left
    # ======================================================================= #
    if hash.has_key? :left
      array_to_be_passed << hash[:left]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :top
    # ======================================================================= #
    if hash.has_key? :top
      array_to_be_passed << hash[:top]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :xspan
    # ======================================================================= #
    if hash.has_key? :xspan
      array_to_be_passed << hash[:xspan]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :yspan
    # ======================================================================= #
    if hash.has_key? :yspan
      array_to_be_passed << hash[:yspan]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :hexpand
    # ======================================================================= #
    if hash.has_key? :hexpand
      array_to_be_passed << hash[:hexpand]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :halign
    # ======================================================================= #
    if hash.has_key? :halign
      array_to_be_passed << hash[:halign]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :vexpand
    # ======================================================================= #
    if hash.has_key? :vexpand
      array_to_be_passed << hash[:vexpand]
    else
      array_to_be_passed << 0
    end
    # ======================================================================= #
    # === :valign
    # ======================================================================= #
    if hash.has_key? :valign
      array_to_be_passed << hash[:valign]
    else
      array_to_be_passed << 0
    end
    ui_grid_append(pass_this_widget, *array_to_be_passed)
  end

  # ========================================================================= #
  # === ui_grid_append
  #
  # This method can be used to append onto a grid in LibUI.
  #
  # Usage example:
  #
  #   grid.grid_append(text('Right'), 1, 0, 1, 1, 0, 0.5, 1, 0)
  #
  # ========================================================================= #
  def ui_grid_append(
      widget_to_append,
      left    = 0,
      top     = 0,
      xspan   = 1,
      yspan   = 1,     # 
      hexpand = 0, # A "boolean". 0 means false here.
      halign  = 0,
      vexpand = 0, # A "boolean". 0 means false here.
      valign  = 0
    )
    # ======================================================================= #
    # The signature in Go is:
    #
    #   Append(child Control, left, top int, xspan, yspan int, hexpand bool, halign Align, vexpand bool, valign Align)
    #
    # ======================================================================= #
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    this_widget = hash[object_id].first
    _type       = hash[object_id].last # This should be :grid. But it is not used here.
    # ======================================================================= #
    # left, top, xspan, yspan, hexpand, halign, vexpand, valign
    #  0,    0,    2,     1,      0,      0,       1,      0
    # ======================================================================= #
    LibUI.grid_append(
      this_widget,
      widget_to_append,
      left,
      top,
      xspan,
      yspan,
      hexpand,
      halign,
      vexpand,
      valign
    )
  end; alias grid_append ui_grid_append # === grid_append

  # ========================================================================= #
  # === append                                          (append tag, add tag)
  #
  # This is simply a wrapper over LibUI.box_append().
  # ========================================================================= #
  def append(
      this_widget,
      padding_to_use = 1,
      *remaining_arguments
    )
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last
    case type
    # ======================================================================= #
    # === :grid
    #
    # This entry-point is specifically for a ui-grid element.
    # ======================================================================= #
    when :grid
      LibUI.grid_append(
        self,
        this_widget.to_s,
        padding_to_use,
        remaining_arguments[0],
        remaining_arguments[1],
        remaining_arguments[2],
        remaining_arguments[3],
        remaining_arguments[4],
        remaining_arguments[5],
        remaining_arguments[6]
      )
    # ======================================================================= #
    # === :tab
    #
    # This is specifically for the notebook-tab. In this case the argument
    # names do not make a lot of sense. For instance, this_widget is
    # actually the text-title for the tab, and padding_to_use is the
    # actual widget that will be embedded. Because this is, however had,
    # the "minor use case", compared to the subsequent "else" clause, I
    # will keep the name as-is. The comment here should be kept, in order
    # to explain this peculiar oddity though.
    # ======================================================================= #
    when :tab
      LibUI.tab_append(self, this_widget.to_s, padding_to_use)
    # ======================================================================= #
    # === :window
    #
    # Add support for the toplevel window here, as of September 2021.
    # ======================================================================= #
    when :window
      LibUI.window_set_child(self, this_widget)
    else # This is the default.
      LibUI.box_append(
        self, this_widget, padding_to_use
      )
    end
  end; alias add append # === add
       alias <<  append # === <<

  # ========================================================================= #
  # === clear
  # ========================================================================= #
  def clear(
      current_widget = available_pointers?[self.object_id] # This will be an Array.
    )
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last

    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    if type.nil?
      type = hash[object_id].last # This should be :grid. But it is not used here.
    end
    case type
    # ======================================================================= #
    # === :combobox
    #
    # This currently does not work; it depends on libui-ng, which has not
    # yet been added completely.
    # ======================================================================= #
    when :combobox
    #   LibUI.multiline_entry_set_text(
    #     this_widget,
    #     display_this_text.to_s
    #   )
    else
      puts 'Unhandled case in clear(): '+
           type.to_s
    end
  end

  # ========================================================================= #
  # === empty?
  # ========================================================================= #
  def empty?(
      type = nil
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    if type.nil?
      # ===================================================================== #
      # In this case we must determine the type in use.
      # ===================================================================== #
      if hash.has_key? object_id
        type = hash[object_id].last # The last entry contains the type.
      end
    end
    case type
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      self.text?.empty?
    else
      return true
    end
  end

  # ========================================================================= #
  # === set_text
  #
  # This method can be used to set the text of a particular libui-widget,
  # in particular entries.
  # ========================================================================= #
  def set_text(
      display_this_text = '', # This is the text that will be used.
      type              = nil
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    this_widget = hash[object_id].first
    if type.nil?
      type = hash[object_id].last # This should be :grid. But it is not used here.
    end
    case type
    # ======================================================================= #
    # === :multiline_entry
    #
    # This is a text-view widget actually.
    # ======================================================================= #
    when :multiline_entry
      LibUI.multiline_entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :text
    # ======================================================================= #
    when :text,
         :label
      LibUI.label_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :textview
    # ======================================================================= #
    when :textview
      LibUI.multiline_entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      LibUI.entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :search_entry
    #
    # This is specifically for a search-entry.
    # ======================================================================= #
    when :search_entry
      LibUI.entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    else
      puts 'Unhandled case in set_text(): '+
           type.to_s
    end
  end; alias set_content set_text # === set_content

  # ========================================================================= #
  # === is_read_only
  # ========================================================================= #
  def is_read_only(
      current_widget = available_pointers?[self.object_id] # This will be an Array.
    )
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last
    case type
    # ======================================================================= #
    # === :multiline_entry
    # ======================================================================= #
    when :multiline_entry
      LibUI.multiline_entry_set_read_only(self, 1)
    else
      pp caller()
      puts "#{type} (class #{type.class}) is not yet implemented in .padded=."
    end
  end

  # ========================================================================= #
  # === text?
  #
  # This method queries the content of any widget that may contain text, in
  # particular entries such as a gtk-entry.
  # ========================================================================= #
  def text?(
      type = nil
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    if type.nil?
      # ===================================================================== #
      # In this case we must determine the type in use.
      # ===================================================================== #
      if hash.has_key? object_id
        type = hash[object_id].last # The last entry contains the type.
      end
    end
    case type
    # ======================================================================= #
    # === :multiline_entry
    #
    # This is, I believe, synonymous to :textview.
    # ======================================================================= #
    when :multiline_entry,
         :textview
      return LibUI.multiline_entry_text(self).to_s
    # ======================================================================= #
    # === :combobox
    # ======================================================================= #
    when :combobox
      return LibUI.combobox_selected(self).to_s
    else # This is the "historic" default. May have to be removed one day.
      return LibUI.entry_text(self).to_s
    end
  end; alias buffer?   text? # === buffer?
       alias selected? text? # === selected?

  # ========================================================================= #
  # === on_changed
  #
  # The idea for this method is to respond to on-changed events, in
  # particular on a spinbox. Currently it is enabled only for :entry
  # widgets. This may have to be expanded one day to add more widgets.
  #
  # For a combobox we may have to use this code:
  #
  #   LibUI.combobox_on_selected
  #     UI.spinbox_on_changed(self, spinbox_changed_callback, nil)
  #   end
  #
  # Be sure to pass the proc object into the method, in a block.
  #
  # Usage examples:
  #
  #   text_entry.on_changed { text_changed_callback }
  #   slider.on_changed { slider_changed_callback }
  #
  # ========================================================================= #
  def on_changed(&block)
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last
    case type
    # ======================================================================= #
    # === :multiline_entry
    # ======================================================================= #
    when :multiline_entry
      LibUI.multiline_entry_on_changed(self, block.call, nil)
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      LibUI.entry_on_changed(self, block.call, nil)
    # ======================================================================= #
    # === :spinbox
    # ======================================================================= #
    when :spinbox
      LibUI.spinbox_on_changed(self, block.call, nil)
    # ======================================================================= #
    # === :slider
    #
    # This is for a slider bar.
    # ======================================================================= #
    when :slider
      LibUI.slider_on_changed(self, block.call, nil)
    # ======================================================================= #
    # === :colour_button
    # ======================================================================= #
    when :colour_button
      LibUI.color_button_on_changed(self, block.call, nil)
    # ======================================================================= #
    # === :combobox
    # ======================================================================= #
    when :combobox
      LibUI.combobox_on_selected(self, block.call, nil)
    else
      e 'Not registered type in .on_changed(): '+type.to_s
    end
  end

  # ========================================================================= #
  # === append_this_string
  #
  # This method can be used to append a String to an existing String.
  # ========================================================================= #
  def append_this_string(i)
    ::LibUI.attributed_string_append_unattributed(self, i)
  end

  # ========================================================================= #
  # === append_text_column
  #
  # This method is specifically used for libui-tables.
  # ========================================================================= #
  def append_text_column(text, a, b)
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last # The last entry contains the type.
    case type
    # ======================================================================= #
    # === :button
    # ======================================================================= #
    when :table
      LibUI.table_append_text_column(self, text, a, b)
    else
      e 'Not registered type in .append_text_column(): '+type.to_s
    end
  end

  # ========================================================================= #
  # === padded=
  #
  # Set a uniform padding via this method.
  # ========================================================================= #
  def padded=(
      pad_n_px = 25,
      type     = nil
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    if type.nil?
      # ===================================================================== #
      # In this case we must determine the type in use.
      # ===================================================================== #
      if hash.has_key? object_id
        type = hash[object_id].last # The last entry contains the type.
      end
    end
    case type
    # ======================================================================= #
    # === :grid
    # ======================================================================= #
    when :grid
      LibUI.grid_set_padded(self, pad_n_px) # This line should be changed at a later time.
    # ======================================================================= #
    # === :button
    #
    # This entry point probably does not work, so don't use it.
    # ======================================================================= #
    when :button
      LibUI.box_set_padded(self, pad_n_px)
    # ======================================================================= #
    # === :vbox
    # ======================================================================= #
    when :vbox,
         :hbox
      LibUI.box_set_padded(self, pad_n_px)
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      # ===================================================================== #
      # This method does not seem to exist. We'll leave this here for the
      # time being.
      # ===================================================================== #
      # LibUI.entry_set_padded(self, pad_n_px) # This line should be changed at a later time.
    else
      pp caller()
      puts "#{type} (class #{type.class}) is not yet implemented in .padded=."
    end
  end; alias set_padded padded= # === set_padded

  # ========================================================================= #
  # === disable                                                  (disable tag)
  # ========================================================================= #
  def disable(&block)
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last # The last entry contains the type.
    case type
    # ======================================================================= #
    # === :button
    # ======================================================================= #
    when :button
      LibUI.control_disable(self)
    else
      e 'Not registered type in .disable(): '+type.to_s
    end
  end

  # ========================================================================= #
  # === enable                                                   (enable tag)
  # ========================================================================= #
  def enable(&block)
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last # The last entry contains the type.
    case type
    # ======================================================================= #
    # === :button
    # ======================================================================= #
    when :button
      LibUI.control_enable(self)
    else
      e 'Not registered type in .enable(): '+type.to_s
    end
  end

  # ========================================================================= #
  # === @left_counter
  # ========================================================================= #
  @left_counter = 0

  # ========================================================================= #
  # === Fiddle::Pointer.reset_the_left_counter
  # ========================================================================= #
  def self.reset_the_left_counter
    @left_counter = 0
  end

  # ========================================================================= #
  # === Fiddle::Pointer.increment_the_left_counter
  # ========================================================================= #
  def self.increment_the_left_counter
    @left_counter += 1
  end

  # ========================================================================= #
  # === Fiddle::Pointer.left_counter?
  # ========================================================================= #
  def self.left_counter?
    @left_counter
  end

  # ========================================================================= #
  # === @top_counter
  # ========================================================================= #
  @top_counter = 0

  # ========================================================================= #
  # === Fiddle::Pointer.increment_the_top_counter
  # ========================================================================= #
  def self.increment_the_top_counter
    @top_counter += 1
  end

  # ========================================================================= #
  # === Fiddle::Pointer.top_counter?
  # ========================================================================= #
  def self.top_counter?
    @top_counter
  end

  # ========================================================================= #
  # === right                                                     (right tag)
  # ========================================================================= #
  def right(
      widget,
      left  = Fiddle::Pointer.left_counter?,
      top   = Fiddle::Pointer.top_counter?,
      xspan = 1,
      yspan = 1
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last # The last entry contains the type.
    case type
    # ======================================================================= #
    # === :vbox
    # ======================================================================= #
    when :vbox
      self.add(widget)
    # ======================================================================= #
    # === :grid
    # ======================================================================= #
    when :grid
      self.ui_grid_append(
        widget,
        left, # left
        top,  # top
        xspan,
        yspan
      )
      Fiddle::Pointer.reset_the_left_counter
      Fiddle::Pointer.increment_the_top_counter
    else
    end
  end

  # ========================================================================= #
  # === left                                                       (left tag)
  # ========================================================================= #
  def left(
      widget,
      left  = Fiddle::Pointer.left_counter?,
      top   = Fiddle::Pointer.top_counter?,
      xspan = 1,
      yspan = 1
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last # The last entry contains the type.
    case type
    # ======================================================================= #
    # === :vbox
    # ======================================================================= #
    when :vbox
      self.add(widget)
    # ======================================================================= #
    # === :grid
    # ======================================================================= #
    when :grid
      self.ui_grid_append(
        widget,
        self,
        left, # left
        top,  # top
        xspan,
        yspan
      )
      Fiddle::Pointer.increment_the_left_counter
    else
    end
  end

  # ========================================================================= #
  # === populate
  # ========================================================================= #
  def populate(dataset)
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    type = hash[object_id].last
    case type
    # ======================================================================= #
    # === :combobox
    # ======================================================================= #
    when :combobox
      self.append_this_array(dataset)
    end
  end

  # ========================================================================= #
  # === is_padded
  # ========================================================================= #
  def is_padded
    set_padded(1)
  end

  # ========================================================================= #
  # === main_then_quit
  # ========================================================================= #
  def main_then_quit
    LibUI.main
    LibUI.quit
  end

  # ========================================================================= #
  # === show_then_main_then_quit
  #
  # This method ultimately combines three other method calls.
  # ========================================================================= #
  def show_then_main_then_quit
    LibUI.control_show(self)
    main_then_quit
  end; alias elegant_exit           show_then_main_then_quit # === elegant_exit
       alias complex_finalizer      show_then_main_then_quit # === complex_finalizer
       alias intelligent_close_down show_then_main_then_quit # === intelligent_close_down
       alias intelligent_quit       show_then_main_then_quit # === intelligent_quit
       alias intelligent_exit       show_then_main_then_quit # === intelligent_exit

  # ========================================================================= #
  # === on_clicked
  #
  # This method is in general called on a button-widget.
  # ========================================================================= #
  def on_clicked(&block)
    LibUI.button_on_clicked(self, &block)
  end; alias on_click_event on_clicked # === on_click_event

  # ========================================================================= #
  # === available_pointers?
  # ========================================================================= #
  def available_pointers?
    LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
  end; alias main_hash? available_pointers? # === main_hash?

  # ========================================================================= #
  # === set_value
  #
  # This method has initially been created to assign a value to a
  # spinbutton. That way the following API is made possible:
  #
  #   spinbutton.set_value(42)
  #
  # ========================================================================= #
  def set_value(
      new_value
    )
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    this_widget = hash[object_id].first
    type = hash[object_id].last
    case type
    # ======================================================================= #
    # === :spinbox
    # ======================================================================= #
    when :spinbox
      LibUI.spinbox_set_value(
        this_widget,
        new_value.to_i # Must be an Integer.
      )
    else
      e 'Not registered type: '+type.to_s
    end
  end; alias value=          set_value # === value=
       alias start_position= set_value # === start_position=

  # ========================================================================= #
  # === append_this_array
  # ========================================================================= #
  def append_this_array(array)
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    _this_widget = hash[object_id].first # This variable is currently not in use.
    type        = hash[object_id].last
    case type
    # ======================================================================= #
    # === :combobox
    # ======================================================================= #
    when :combobox
      array.each {|this_entry|
        LibUI.combobox_append(self, this_entry)
      }
      LibUI.combobox_set_selected(self, 0) # The first one will be active too.    
    end
  end

  # ========================================================================= #
  # === maximal
  # ========================================================================= #
  def maximal(this_widget, optional_padding = 1)
    add(this_widget, optional_padding)
  end

  # ========================================================================= #
  # === group_maximal
  # ========================================================================= #
  def group_maximal(*i)
    i.flatten.each {|entry|
      maximal(entry)
    }
  end

  # ========================================================================= #
  # === minimal
  # ========================================================================= #
  def minimal(this_widget, optional_padding = 0)
    add(this_widget, optional_padding)
  end

  # ========================================================================= #
  # === text
  #
  # This ad-hoc method can be used to write text onto a widget.
  #
  # Usage example:
  #
  #   outer_vbox.text(
  #     'This widget can be used to modify the ID3 tags '\
  #     'of .mp3 files. The taglib-ruby gem is required for this functionality.'
  #   )
  #
  # ========================================================================= #
  def text(
      i              = '',
      padding_to_use = 0
    )
    i = i.to_s # Let's ensure we have a String past this point.
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    _this_widget = hash[object_id].first # This variable is currently not in use.
    type        = hash[object_id].last
    case type
    # ======================================================================= #
    # === :vbox
    # ======================================================================= #
    when :vbox,
         :hbox
      _ = ui_text(i)
      self.add(_, padding_to_use)
    end
  end; alias add_text text # === text

  # ========================================================================= #
  # === add_hsep
  #
  # This method adds a horizontal separator.
  # ========================================================================= #
  def add_hsep
    object_id = self.object_id
    hash = LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
    this_widget = hash[object_id].first
    this_widget.add(::LibuiParadise::Extensions.horizontal_separator, 0)
  end; alias add_horizontal_separator add_hsep # === add_horizontal_separator

  # ========================================================================= #
  # === active?
  # ========================================================================= #
  def active?
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    pointer = current_widget.first
    type    = current_widget.last
    case type
    # ======================================================================= #
    # === :checkbox
    # ======================================================================= #
    when :checkbox
      checked = (UI.checkbox_checked(pointer) == 1)
      return (checked == true)
    # ======================================================================= #
    # === :entry
    #
    # This is unhandled.
    # ======================================================================= #
    when :entry
      e 'An entry can not be "active". Check the code - there may '\
        'an erroneous assumption if the method .active? is called.'
    end
  end; alias is_active? active? # === is_active?

  # ========================================================================= #
  # === set_active
  # ========================================================================= #
  def set_active
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    pointer = current_widget.first
    type    = current_widget.last
    case type
    # ======================================================================= #
    # === :checkbox
    # ======================================================================= #
    when :checkbox
      LibUI.checkbox_set_checked(pointer, 1)
    end
  end; alias is_active     set_active # === is_active
       alias is_now_active set_active # === is_now_active

  # ========================================================================= #
  # === set_inactive
  # ========================================================================= #
  def set_inactive
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    pointer = current_widget.first
    type    = current_widget.last
    case type
    # ======================================================================= #
    # === :checkbox
    # ======================================================================= #
    when :checkbox
      LibUI.checkbox_set_checked(pointer, 0)
    end
  end; alias is_inactive     set_inactive # === is_inactive
       alias is_now_inactive set_inactive # === is_now_inactive

  # ========================================================================= #
  # === child
  #
  # This method should only be called on a LibUI-Window.
  # ========================================================================= #
  def child(child_widget)
    LibUI.window_set_child(self, child_widget)
  end; alias children= child # === children=
       alias child=    child # === child=

  # ========================================================================= #
  # === show_the_controls
  # ========================================================================= #
  def show_the_controls
    LibUI.control_show(self)
  end; alias control_show show_the_controls # === control_show

  # ========================================================================= #
  # === close_properly
  #
  # This can be invoked via, for instance:
  #
  #   main_window.simple_exit
  #
  # ========================================================================= #
  def close_properly
    LibUI.window_on_closing(self) {
      LibUI.exit_from(self)
    }
  end; alias simple_exit close_properly # === simple_exit
       alias sane_exit   close_properly # === sane_exit
       alias should_quit close_properly # === should_quit

  # ========================================================================= #
  # === is_margined                                (margin tag, margined tag)
  #
  # For now this only works on @main_window.
  # ========================================================================= #
  def is_margined(
      i = LibuiParadise::Extensions.main_window?
    )
    id = self.object_id
    hash = main_hash?
    if hash.has_key? id
      _ = hash[id]
      type = _.last
      case type
      # ===================================================================== #
      # === :window
      # ===================================================================== #
      when :window
        LibUI.window_set_margined(_.first, 1)
      else
        e 'The type '+type.to_s+' in is_margined() is currently not supported.'
      end
    else
      e
      e '-'*80
      e 'An unhandled situation has been created:'
      e
      e '  No available key in is_margined() for id: '+id.to_s
      e
      e '-'*80
      e
    end
  end; alias uses_a_margin is_margined # === uses_a_margin
       alias has_margin    is_margined # === has_margin

  # ========================================================================= #
  # === Skeleton methods:
  #
  # A "skeleton" method is one that doesn't do anything right now. These
  # were added to increase compatibility with the gtk_paradise gem in
  # particular.
  #
  # Some of these skeleton methods may become real methods one day,
  # depending on how sophisticated the libui code will be - but
  # until then we will simply use different options on different
  # toolkits.
  # ========================================================================= #
  def bblack1; end
  def bblack2; end
  def bblack3; end
  def pad1px;  end
  def pad2px;  end
  def pad3px;  end
  def pad4px;  end
  def pad5px;  end
  def pad6px;  end
  def pad7px;  end
  def pad8px;  end
  def pad9px;  end
  def pad10px; end
  def yellow_background; end
  def hint=(i = nil); end
    alias popup_hint hint= # === popup_hint
  def modify_background(a = :active,   b = :coral); end
  def set_focus(true_or_false = true); end
  def clear_background; end
  def position=(i = 10); end
  def reset_the_internal_variables; end
  def editable=(true_or_false = false); end
  def set_max_length(n = 100); end
  def use_gtk_paradise_project_css_file; end
  def append_project_CSS_file; end
  def infer_the_size_automatically; end
  def set_column_spacing(i = 1); end
  def set_row_spacing(i = 1); end
  def css_class(i = ''); end
  def set_border_width(i = 2); end
  def set_colour(i = 'blue'); end
  def make_bold; end
  def set_name(i = ''); end
  def do_use_underline; end
  def lightblue; end
  def set_font(i = ''); end
  def do_markify; end
  def default=(i = ''); end
  def on_click_select_all; end
  def do_center; end
  def on_hover(i = ''); end
  def lightgreen; end
  def set_background_colour(i = ''); end
  def set_size_request(a = 42, b = 42); end
  def the_first_entry_is_active; end
  def clear_old_datapoints; end
  def width_height(a = 500, b = 500); end
  def row_spacing=(i = 10); end
  def line_spacing=(i = 10); end
  def to_the_left; end
  def set_editable(i = true); end
  def try_to_add_default_CSS_rules; end
  def enable_free_form_css; end
  def show_all; end # This one here may become a real method one day, but right now I don't know how to enable that.
  def align_to_the_left; end
  def yellowish_background; end
  def on_enter; end
  def on_value_changed; end
  def try_to_use_this_font(i = nil); end
    alias use_this_font=    try_to_use_this_font
    alias set_use_this_font try_to_use_this_font
  def horizontal_center; end
  def light_green_background; end
  def center; end
  def align_to_center; end
  def make_selectable; end
  def very_light_yellow_background; end
  def very_light_yellowish_background; end
  def remove_background; end
  def rounded_border(a = '', b = '', c = ''); end
  def bblack4; end
  def on_mouse_click_select_everything; end
  def font=(i = ''); end
  def set_activates_default(i = true); end
  def enable_events; end
  def do_focus; end
  def border(i = '', *a); end
  def fancy_hint(i = ''); end
  def fancy_hints(i = ''); end
  def fancy_hint=(i = ''); end
  def fancy_hints=(i = ''); end
  def shadow_hint=(i = ''); end
  def on_enter_key(i = ''); end
  def signal_connect(i = ''); end

  # ========================================================================= #
  # === on_key_press_event
  # ========================================================================= #
  def on_key_press_event(&block)
    # e 'NOT YET IMPLEMENTED.'
  end

  # ========================================================================= #
  # === on_button_press_event
  # ========================================================================= #
  def on_button_press_event(&block)
    # e 'NOT YET IMPLEMENTED'
  end

end; end