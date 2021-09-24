#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
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
      main_window  = :default_window,
      title_to_use = '',
      whatever     = ''
    )
    case main_window
    when :default_window
      main_window = LibuParadise.window?
    end
    _ = UI.msg_box(
      main_window,
      title_to_use,
      whatever
    )
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_msg_box             msg_box } # === LibuiParadise::Extensions.ui_msg_box
       self.instance_eval { alias message_to_the_user    msg_box } # === LibuiParadise::Extensions.message_to_the_user
       self.instance_eval { alias message_box            msg_box } # === LibuiParadise::Extensions.message_box
       self.instance_eval { alias popup_over_this_widget msg_box } # === LibuiParadise::Extensions.popup_over_this_widget

  # ========================================================================= #
  # === msg_box
  #
  # This method is a convenience-wrapper over UI.msg_box().
  # ========================================================================= #
  def msg_box(
      main_window  = :default_window,
      title_to_use = '',
      whatever     = ''
    )
    ::LibuiParadise::Extensions.msg_box(
      main_window,
      title_to_use,
      whatever
    )
  end; alias ui_msg_box             msg_box # === ui_msg_box
       alias message_to_the_user    msg_box # === message_to_the_user
       alias message_box            msg_box # === message_box
       alias popup_over_this_widget msg_box # === popup_over_this_widget
       alias popup_message          msg_box # === popup_message

end

# =========================================================================== #
# === LibuiParadise.msg_box
# =========================================================================== #
def self.msg_box(
    main_window  = :default_window,
    title_to_use = '',
    whatever     = ''
  )
  Libuiparadise::Extensions.msg_box(
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