#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/window.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  # ========================================================================= #
  # === @main_window
  #
  # This variable can be used to keep track of the main window in use.
  # ========================================================================= #
  @main_window = nil

  # ========================================================================= #
  # === LibuiParadise::Extensions.main_window?
  # ========================================================================= #
  def self.main_window?
    @main_window
  end

  # ========================================================================= #
  # === main_window?
  # ========================================================================= #
  def main_window?
    ::LibuiParadise::Extensions.main_window?
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.set_main_window
  # ========================================================================= #
  def self.set_main_window(i)
    @main_window = i
  end

  # ========================================================================= #
  # === LibuiParadise::Extensions.window                         (window tag)
  #
  # This method will create a new main-window.
  #
  # It will also call UI.simple_exit(). This is done mostly so that we
  # can omit that line whenever we use e. g. ui_main_window().
  # ========================================================================= #
  def self.window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1, # hasMenubar or has not.
      &block
    )
    case the_title
    # ======================================================================= #
    # === :filename
    # ======================================================================= #
    when :filename,
         :file_name
      # ===================================================================== #
      # __FILE__ contains the desired name. We only need the raw name, though.
      # ===================================================================== #
      the_title = File.basename(__FILE__)
    end
    raw_has_menubar = 0
    if has_menubar.is_a? Numeric
      raw_has_menubar = has_menubar
    end
    # ======================================================================= #
    # Instantiate a new main-window next:
    # ======================================================================= #
    main_window = LibUI.new_window(
      the_title,
      width,
      height,
      raw_has_menubar
    )
    set_main_window(main_window) # Keep a reference stored here.
    # ======================================================================= #
    # Since as of 30.08.2021 we will also register the main-window.
    #
    # In the long run we may obsolete and deprecate @main_window, since
    # it is no longer needed - but for now we will retain that variable.
    # ======================================================================= #
    add_to_the_registered_widgets(main_window, __method__)
    if has_menubar and has_menubar.is_a?(Hash)
      if has_menubar.has_key? :margin
        if has_menubar[:margin] == true
          main_window.has_margin
        end
      end
    end
    UI.simple_exit(main_window)
    if block_given?
      yield
    end
    return main_window # Always return it here.
  end; self.instance_eval { alias main_window     window } # === LibuiParadise::Extensions.main_window
       self.instance_eval { alias ui_main_window  window } # === LibuiParadise::Extensions.ui_main_window
       self.instance_eval { alias margined_window window } # === LibuiParadise::Extensions.margined_window
       self.instance_eval { alias ui_window       window } # === LibuiParadise::Extensions.ui_window

  # ========================================================================= #
  # === window
  # ========================================================================= #
  def window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1  # hasMenubar or has not.
    )
    LibuiParadise::Extensions.window(
      the_title, width, height, has_menubar
    )
  end; alias main_window window # === main_window

  # ========================================================================= #
  # === ui_margined_main_window
  #
  # This variant is like ui_main_window() but it will automatically
  # put a margin on the window, via .is_margined().
  #
  # Note that the variant name "ui_padded_main_window" is a misnomer,
  # since it is a margin rather than padding - but I found that it
  # is easier to not care about this, so for the time being (September
  # 2021) this is how it is. It may be subject to change in the future,
  # though.
  # ========================================================================= #
  def ui_margined_main_window(
      the_title   = '',  # Pick a title for the window here.
      width       = 500, # width  in n pixels.
      height      = 300, # height in n pixels.
      has_menubar =   1  # hasMenubar or has not.
    )
    _ = LibuiParadise.window(the_title, width, height, has_menubar)
    _.is_margined
    return _
  end; alias ui_margined_window    ui_margined_main_window # === ui_margined_window
       alias ui_padded_main_window ui_margined_main_window # === ui_padded_main_window
       alias margined_window       ui_margined_main_window # === margined_window
       alias padded_window         ui_margined_main_window # === padded_window
       alias padded_main_window    ui_margined_main_window # === padded_main_window
       alias ui_main_window        ui_margined_main_window # === ui_main_window
       alias ui_window             ui_margined_main_window # === ui_window

end

# =========================================================================== #
# === LibuiParadise.window
# =========================================================================== #
def self.window(
    the_title   = '',  # Pick a title for the window here.
    width       = 500, # width  in n pixels.
    height      = 300, # height in n pixels.
    has_menubar =   1  # hasMenubar or has not.
  )
  ::LibuiParadise::Extensions.window(
    the_title,
    width,
    height,
    has_menubar
  )
end; self.instance_eval { alias main_window           window } # === LibuiParadise.main_window
     self.instance_eval { alias margined_window       window } # === LibuiParadise.margined_window
     self.instance_eval { alias ui_window             window } # === LibuiParadise.ui_window
     self.instance_eval { alias ui_main_window        window } # === LibuiParadise.ui_main_window
     self.instance_eval { alias ui_padded_main_window window } # === LibuiParadise.margined_window
     self.instance_eval { alias padded_window         window } # === LibuiParadise.padded_window
     self.instance_eval { alias padded_main_window    window } # === LibuiParadise.padded_main_window

# =========================================================================== #
# === LibuiParadise.main_window?
# =========================================================================== #
def self.main_window?
  LibuiParadise::Extensions.main_window?
end

end