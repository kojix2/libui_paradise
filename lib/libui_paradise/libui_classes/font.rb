#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/font.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.font                  (font tag, fonts tag)
  # ========================================================================= #
  def self.font(&block)
    use_this_font = UI::FFI::FontDescriptor.malloc
    if block_given?
      yielded = yield
      if yielded.is_a? Hash
        # =================================================================== #
        # === :font_size
        # =================================================================== #
        if yielded.has_key? :font_size
          use_this_font.Size = yielded.delete(:font_size)
        end
        # =================================================================== #
        # === :font_family
        # =================================================================== #
        if yielded.has_key? :font_family
          use_this_font.Family = yielded.delete(:font_family)
        end
        # =================================================================== #
        # === :stretch
        # =================================================================== #
        if yielded.has_key? :stretch
          use_this_font.Stretch = yielded.delete(:stretch)
        end
        # =================================================================== #
        # === :weight
        # =================================================================== #
        if yielded.has_key? :weight
          use_this_font.Weight = yielded.delete(:weight)
        end
        # =================================================================== #
        # === :italic
        # =================================================================== #
        if yielded.has_key? :italic
          _ = yielded.delete(:italic_family)
          if _ == true
            _ = 1
          elsif _ == false
            _ = 0
          end
          use_this_font.Italic = _
        end
      end
    end
    return use_this_font
  end; self.instance_eval { alias ui_font         font } # === LibuiParadise::Extensions.ui_font
       self.instance_eval { alias font_descriptor font } # === LibuiParadise::Extensions.font_descriptor

  # ========================================================================= #
  # === font
  # ========================================================================= #
  def font(&block)
    LibuiParadise::Extensions.font(&block)
  end; alias ui_font         font # === ui_font
       alias font_descriptor font # === font_descriptor

end

# =========================================================================== #
# === LibuiParadise.font
# =========================================================================== #
def self.font(&block)
  ::LibuiParadise::Extensions.font(&block)
end

end