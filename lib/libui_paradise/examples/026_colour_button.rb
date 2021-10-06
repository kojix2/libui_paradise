#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This button doesn't work properly right now. :(
# =========================================================================== #
require 'libui_paradise/autoinclude'

window = main_window('Colour Button', 500, 300, 0)
outer_vbox = padded_vbox
our_colour_button = ui_colour_button

# colour_button.on_changed {|callback|
#   pp callback.class
#   rgba = callback.color
#   pp rgba
# }

# on_changed_proc = proc {|callback|
#   rgba = callback.color
#   pp rgba
# }

xyz = proc {|pointer|
  # rgba = pointer.color
  #pp rgba
  pp pointer.to_s
  nil
}

LibUI.color_button_on_changed(our_colour_button, xyz, nil)
#   # rgba = pointer.color
#   # pp rgba
#   pp pointer
#   pp pointer.to_s
# }


# UI.color_button_on_changed(color_button) do
#   UI.area_queue_redraw_all(histogram)
# end

#, on_changed_proc.call, nil)

#UI.spinbox_on_changed(spinbox) do |ptr|
#  puts "New Spinbox value: #{UI.spinbox_value(ptr)}"
#end

outer_vbox.minimal(our_colour_button, 1)
window.child = outer_vbox
window.intelligent_quit