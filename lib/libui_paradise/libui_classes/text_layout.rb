#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/text_layout.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.text_layout
  # ========================================================================= #
  def self.text_layout(
      i = ''
    )
    _ = UI.draw_new_text_layout(i.to_s)
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

end

# =========================================================================== #
# === LibuiParadise.text_layout
# =========================================================================== #
def self.text_layout(
    i = ''
  )
  ::LibuiParadise::Extensions.text_layout(i)
end

end