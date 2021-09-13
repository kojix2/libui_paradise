#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/hbox.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.hbox                             (hbox tag)
  #
  # This method will create a horizontal box.
  # ========================================================================= #
  def self.hbox(*optional_widgets)
    _ = UI.new_horizontal_box
    add_to_the_registered_widgets(_, __method__)
    if optional_widgets and !optional_widgets.flatten.empty?
      optional_widgets.flatten.each {|this_widget|
        _.add(this_widget)
      }
    end
    return _
  end; self.instance_eval { alias ui_hbox     hbox } # === ui_hbox
       self.instance_eval { alias create_hbox hbox } # === create_hbox

  # ========================================================================= #
  # === ui_padded_hbox
  # ========================================================================= #
  def ui_padded_hbox(*optional_widgets)
    _ = ui_hbox(optional_widgets)
    _.is_padded
    return _
  end; alias padded_hbox ui_padded_hbox # === padded_hbox

  # ========================================================================= #
  # === ui_hbox                                                    (hbox tag)
  # ========================================================================= #
  def hbox(*optional_widgets)
    ::LibuiParadise::Extensions.hbox(optional_widgets)
  end; alias ui_hbox     hbox # === ui_hbox
       alias create_hbox hbox # === create_hbox

  # ========================================================================= #
  # === two_elements_hbox
  #
  # This method will return a horizontal box (hbox) that is accepting
  # two arguments (two widgets) that will be embedded onto that hbox.
  # Then the result is returned.
  # ========================================================================= #
  def two_elements_hbox(
      widget1,
      widget2,
      options = {
        layout_to_use: :maximal # This is the default.
      }
    )
    _ = ui_padded_hbox
    # ======================================================================= #
    # === Handle :layout_to_use
    #
    # This is mostly done to distinguish between maximal() and minimal()
    # for widgets.
    # ======================================================================= #
    if options.is_a?(Hash) and options.has_key?(:layout_to_use)
      case options[:layout_to_use]
      # ===================================================================== #
      # === :maximal
      # ===================================================================== #
      when :maximal
        _.maximal(widget1)
        _.maximal(widget2)
      # ===================================================================== #
      # === :minimal
      # ===================================================================== #
      when :minimal
        _.minimal(widget1)
        _.minimal(widget2)
      end
    else
      _.minimal(widget1)
      _.minimal(widget2)
    end
    return _
  end

end

# ========================================================================= #
# === LibuiParadise.hbox
# ========================================================================= #
def self.hbox(*optional_widgets)
  ::LibuiParadise::Extensions.hbox(optional_widgets)
end; self.instance_eval { alias ui_hbox     hbox } # === LibuiParadise.ui_hbox
     self.instance_eval { alias create_hbox hbox } # === LibuiParadise.create_hbox

end