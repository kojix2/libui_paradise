#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# The upstream API in C can be found here:
#
#   https://raw.githubusercontent.com/andlabs/libui/master/unix/button.c
#
# =========================================================================== #
# require 'libui_paradise/ui_classes/button.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

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
  # === LibuiParadise::Extensions.button                         (button tag)
  # ========================================================================= #
  def self.button(text)
    _ = UI.new_button(text)
    ::LibuiParadise::Extensions.register_this_fiddle_pointer_widget(_, __method__)
    return _
  end; self.instance_eval { alias ui_button button } # === LibuiParadise::Extensions.ui_button

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
    quit_button = button(use_this_text)
    quit_button.on_clicked {
      UI.quit
      0
    }
    return quit_button
  end; alias ui_quit_button quit_button # === ui_quit_button

end

# =========================================================================== #
# === LibuiParadise.button
# =========================================================================== #
def self.button(text)
  ::LibuiParadise::Extensions.button(text)
end

end