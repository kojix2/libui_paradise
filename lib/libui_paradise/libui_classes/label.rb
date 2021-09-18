#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/label.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === LibuiParadise::Extensions.label                (text tag, label tag)
  #
  # Add text to the widget at hand. This is actually called a "label".
  # ========================================================================= #
  def self.label(
      i = ''
    )
    _ = UI.new_label(i.to_s)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; self.instance_eval { alias text     label } # === LibuiParadise::Extensions.text
       self.instance_eval { alias ui_text  label } # === LibuiParadise::Extensions.ui_text
       self.instance_eval { alias ui_label label } # === LibuiParadise::Extensions.ui_label

  # ========================================================================= #
  # === label
  # ========================================================================= #
  def label(
      i = ''
    )
    ::LibuiParadise::Extensions.label(i)
  end; alias text     label # === text
       alias ui_text  label # === ui_text
       alias ui_label label # === ui_label

  # ========================================================================= #
  # === bold_label
  #
  # This currently does not work properly. We may have to re-examine this
  # eventually at a later point.
  # ========================================================================= #
  def bold_label(i = '')
    return label(i)
  end

  # ========================================================================= #
  # === bold_text
  #
  # This currently does NOT make the text bold - the method exists solely
  # as a placeholder, until upstream libui supports bold text as such.
  # ========================================================================= #
  def bold_text(i = '')
    return label(i)
  end

  # ========================================================================= #
  # === fancy_text
  #
  # This text variant can be styled.
  # ========================================================================= #
  def fancy_text(i = '')
    _ = UI.new_attributed_string(i.to_s)
    add_to_the_registered_widgets(_, __method__)
    return _
  end; alias attributed_string fancy_text # === attributed_string

end

# ========================================================================= #
# === LibuiParadise.label
#
# Toplevel method to create a new label, aka new text.
# ========================================================================= #
def self.label(
    i = ''
  )
  ::LibuiParadise::Extensions.label(i)
end; self.instance_eval { alias text     label } # === LibuiParadise.text
     self.instance_eval { alias ui_text  label } # === LibuiParadise.ui_text
     self.instance_eval { alias ui_label label } # === LibuiParadise.ui_label

end