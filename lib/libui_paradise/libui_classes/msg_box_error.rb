#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/msg_box_error.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.msg_box_error
  # ========================================================================= #
  def self.msg_box_error(
      main_window  = LibuiParadise.main_window?,
      title_to_use = '',
      whatever     = ''
    )
    _ = UI.msg_box_error(
      main_window,
      title_to_use,
      whatever
    )
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias ui_msg_box_error          msg_box_error } # === LibuiParadise::Extensions.ui_msg_box_error
       self.instance_eval { alias ui_error_msg              msg_box_error } # === LibuiParadise::Extensions.ui_error_msg
       self.instance_eval { alias ui_error_message          msg_box_error } # === LibuiParadise::Extensions.ui_error_message
       self.instance_eval { alias error_message_to_the_user msg_box_error } # === LibuiParadise::Extensions.error_message_to_the_user

  # ========================================================================= #
  # === msg_box_error
  # ========================================================================= #
  def msg_box_error(
      main_window  = LibuiParadise.main_window?,
      title_to_use = '',
      whatever     = ''
    )
    return ::LibuiParadise::Extensions.msg_box_error(
      main_window,
      title_to_use,
      whatever
    )
  end; alias ui_msg_box_error          msg_box_error # === ui_msg_box_error
       alias ui_error_msg              msg_box_error # === ui_error_msg
       alias ui_error_message          msg_box_error # === ui_error_message
       alias error_message_to_the_user msg_box_error # === error_message_to_the_user

end; end