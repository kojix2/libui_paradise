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
  # The only exception to the above rule is the main window. The
  # main window is always stored in the @main_window variable instead.
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