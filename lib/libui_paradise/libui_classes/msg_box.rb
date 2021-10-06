#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# Official API documentation can be found here:
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
# =========================================================================== #
# require 'libui_paradise/ui_classes/msg_box.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.msg_box
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
      require 'libui_paradise/libui_classes/window.rb'
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

end

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

end