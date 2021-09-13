#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/extensions/hash_fiddle_pointer_widgets.rb'
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === @hash_fiddle_pointer_widgets
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
  # ========================================================================= #
  def main_hash?
    ::LibuiParadise::Extensions.hash_fiddle_pointer_widgets?
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.register_this_fiddle_pointer_widget
  #
  # This method registers the particular widget in use.
  #
  # Every new_* method available on UI.new* - actually on LibUI.new* -
  # that creates a new widget be registered via this method here. That
  # way we have a Hash that contains lots of Fiddle::Pointers and we
  # can, at a later time, modify these Fiddle::Pointer or call
  # toplevel methods with these registered pointers. This will only work
  # if we have registered these pointers though, which is why each 
  # method that creates a new libui-widget has to make use of this method
  # here.
  #
  # The only exception to the above rule is the main window. The main
  # window is always stored at @main_window instead. Perhaps it
  # should also use the method here, but I found it simpler to
  # just refer to it via @main_window.
  #
  # The mandatory entries must be:
  #
  #   object_id -> [:the_fiddle_pointer_widget, :the_type]
  #
  # The object_id will be determined automatically, so it can be
  # omitted.
  #
  # The very last argument of the two-member Array should be a symbol,
  # such as :grid. This is automatically ensured via a call to
  # __method__ which returns a Symbol.
  # ========================================================================= #
  def self.register_this_fiddle_pointer_widget(
      the_fiddle_pointer_widget,
      the_type_of_the_widget = nil
    )
    object_id_to_use = the_fiddle_pointer_widget.object_id
    # ======================================================================= #
    # Next, store it on the main Hash.
    # ======================================================================= #
    @hash_fiddle_pointer_widgets[object_id_to_use] =
      [
        the_fiddle_pointer_widget,
        the_type_of_the_widget
      ]
  end; self.instance_eval { alias add_to_the_registered_widgets register_this_fiddle_pointer_widget } # === LibuiParadise::Extensions.add_to_the_registered_widgets

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
  # === LibuiParadise::Extensions.current_widget_pointer?
  # ========================================================================= #
  def self.current_widget_pointer?
    LibuiParadise::Extensions.hash_fiddle_pointer_widgets?.values.last.first
  end

  # ========================================================================= #
  # === current_widget_pointer_type?
  # ========================================================================= #
  def current_widget_pointer_type?
    LibuiParadise::Extensions.hash_fiddle_pointer_widgets?.values.last.last
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

end