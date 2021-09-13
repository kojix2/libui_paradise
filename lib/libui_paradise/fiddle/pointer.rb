#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === Fiddle::Pointer
#
# Modify Fiddle::Pointer - but this is super-specific to Libui, so it
# is really not recommended to do this.
#
# A cleaner solution would be to modify just in-place, such as via
# refinements, but I don't like the syntax of refinements really,
# so I opted for the simpler toplevel modification instead.
# =========================================================================== #
# require 'libui_paradise/fiddle/pointer.rb'
# =========================================================================== #
module Fiddle

class Pointer # === Fiddle::Pointer

  # ========================================================================= #
  # === text?
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
    # === :textview
    # ======================================================================= #
    when :textview
      UI.multiline_entry_text(self).to_s
    else # This is the "historic" default.
      UI.entry_text(self).to_s
    end
  end; alias buffer? text? # === buffer?

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
    # === :button
    #
    # This entry point probably does not work, so don't use it.
    # ======================================================================= #
    when :button
      UI.box_set_padded(self, pad_n_px)
    # ======================================================================= #
    # === :vbox
    # ======================================================================= #
    when :vbox,
         :hbox
      UI.box_set_padded(self, pad_n_px)
    # ======================================================================= #
    # === :grid
    # ======================================================================= #
    when :grid
      UI.grid_set_padded(self, pad_n_px) # This line should be changed at a later time.
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      # ===================================================================== #
      # This method does not seem to exist. We'll leave this here for the
      # time being.
      # ===================================================================== #
      # UI.entry_set_padded(self, pad_n_px) # This line should be changed at a later time.
    else
      pp caller()
      puts "#{type} (class #{type.class}) is not yet implemented in .padded=."
    end
  end; alias set_padded padded= # === set_padded

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
    UI.main
    UI.quit
  end

  # ========================================================================= #
  # === show_then_main_then_quit
  #
  # This method ultimately combines three other method calls.
  # ========================================================================= #
  def show_then_main_then_quit
    UI.control_show(self)
    main_then_quit
  end; alias elegant_exit           show_then_main_then_quit # === elegant_exit
       alias complex_finalizer      show_then_main_then_quit # === complex_finalizer
       alias intelligent_close_down show_then_main_then_quit # === intelligent_close_down
       alias intelligent_quit       show_then_main_then_quit # === intelligent_quit
       alias intelligent_exit       show_then_main_then_quit # === intelligent_exit

  # ========================================================================= #
  # === set_text
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
    # === :text
    # ======================================================================= #
    when :text,
         :label
      UI.label_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :textview
    # ======================================================================= #
    when :textview
      UI.multiline_entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      UI.entry_set_text(
        this_widget,
        display_this_text.to_s
      )
    # else;  puts 'Unhandled case so far: '+type.to_s
    end
  end; alias set_content set_text # === set_content

  # ========================================================================= #
  # === on_clicked
  #
  # This method is in general called on a button-widget.
  # ========================================================================= #
  def on_clicked(&block)
    UI.button_on_clicked(self, &block)
  end; alias on_click_event on_clicked # === on_click_event

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
  # Usage example:
  #
  #   text_entry.on_changed { text_changed_callback }
  #
  # ========================================================================= #
  def on_changed(&block)
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last
    case type
    # ======================================================================= #
    # === :entry
    # ======================================================================= #
    when :entry
      UI.entry_on_changed(self, block.call, nil)
    end
  end

  # ========================================================================= #
  # === on_key_press_event
  # ========================================================================= #
  def on_key_press_event(&block)
    e 'NOT YET IMPLEMENTED.'
  end

  # ========================================================================= #
  # === on_button_press_event
  # ========================================================================= #
  def on_button_press_event(&block)
    e 'NOT YET IMPLEMENTED'
  end

  # ========================================================================= #
  # === append                                          (append tag, add tag)
  #
  # This is simply a wrapper over UI.box_append().
  # ========================================================================= #
  def append(
      this_widget,
      padding_to_use = 1
    )
    current_widget = available_pointers?[self.object_id] # This will be an Array.
    _pointer = current_widget.first # Not used currently in this method.
    type     = current_widget.last
    case type
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
      UI.tab_append(self, this_widget.to_s, padding_to_use)
    # ======================================================================= #
    # === :window
    #
    # Add support for the toplevel window here, as of September 2021.
    # ======================================================================= #
    when :window
      UI.window_set_child(self, this_widget)
    else # This is the default.
      UI.box_append(
        self, this_widget, padding_to_use
      )
    end
  end; alias add append # === add
       alias <<  append # === <<

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
      UI.spinbox_set_value(
        this_widget,
        new_value.to_i # Must be an Integer.
      )
    else
      e 'Not registered type: '+type.to_s
    end
  end; alias value= set_value # === value=

  # ========================================================================= #
  # === ui_grid_append
  #
  # This method can be used to append onto a grid in LibUI.
  # ========================================================================= #
  def ui_grid_append(
      widget_to_append,
      left    = 0,
      top     = 0,
      xspan   = 1,
      yspan   = 1,     # 
      hexpand = false, # A "boolean".
      halign  = 0,
      vexpand = false, # A "boolean".
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
    UI.grid_append(
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
  end

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
        UI.combobox_append(self, this_entry)
      }
      UI.combobox_set_selected(self, 0) # The first one will be active too.    
    end
  end

  # ========================================================================= #
  # === maximal
  # ========================================================================= #
  def maximal(this_widget, optional_padding = 1)
    add(this_widget, optional_padding)
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
      UI.checkbox_set_checked(pointer, 1)
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
      UI.checkbox_set_checked(pointer, 0)
    end
  end; alias is_inactive     set_inactive # === is_inactive
       alias is_now_inactive set_inactive # === is_now_inactive

  # ========================================================================= #
  # === child
  #
  # This method should only be called on a LibUI-Window.
  # ========================================================================= #
  def child(child_widget)
    UI.window_set_child(self, child_widget)
  end; alias children= child # === children=
       alias child=    child # === child=

  # ========================================================================= #
  # === show_the_controls
  # ========================================================================= #
  def show_the_controls
    UI.control_show(self)
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
    UI.window_on_closing(self) {
      UI.exit_from(self)
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
        UI.window_set_margined(_.first, 1)
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
  # === right
  # ========================================================================= #
  def right(
      widget
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
      e ':grid is not yet implemented.'
    else
    end
  end

  # ========================================================================= #
  # === left
  # ========================================================================= #
  def left(
      widget
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
      e ':grid is not yet implemented.'
    else
    end
  end

  # ========================================================================= #
  # Skeleton methods:
  #
  # A "skeleton" method is one that doesn't do anything right now. These
  # were added to increase compatibility with the gtk_paradise gem. Some
  # of these skeleton methods may become real methods one day, depending
  # on how sophisticated the libui code will be - but until then we will
  # simply use different options on different toolkits.
  # ========================================================================= #
  def bblack1; end
  def bblack2; end
  def bblack3; end
  def try_to_add_default_CSS_rules; end
  def enable_free_form_css; end
  def show_all; end # This one here may become a real method one day, but right now I don't know how to enable that.
  def align_to_the_left; end
  def pad1px; end
  def pad2px; end
  def pad3px; end
  def pad4px; end
  def pad5px; end
  def pad6px; end
  def pad7px; end
  def pad8px; end
  def yellow_background; end
  def try_to_use_this_font(i = nil); end
    alias use_this_font= try_to_use_this_font
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

end; end