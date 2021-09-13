#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/ui_classes/image.rb
# =========================================================================== #
module LibuiParadise

module Extensions # === LibuiParadise::Extensions
  
  # ========================================================================= #
  # === image
  #
  # This is currently limited to .png files only, due to ChunkyPng.
  #
  # At some later point in the future this limitation may be lifted. For
  # now it has to remain in place.
  # ========================================================================= #
  def image(
      this_file,
      width  = :try_to_infer_automatically,
      height = :infer_automatically
    )
    if (width  == :infer_automatically) or
       (height == :infer_automatically)
      unless Object.const_defined? :ChunkyPNG
        begin
          require 'chunky_png'
        rescue LoadError; end
      end
      canvas = ChunkyPNG::Canvas.from_file(this_file)
      data   = canvas.to_rgba_stream
      width  = canvas.width
      height = canvas.height
      _ = UI.new_image(width, height) # Create the image here.
      add_to_the_registered_widgets(_, __method__)
      UI.image_append(
        _,
        data,
        width,
        height,
        width
      )
      return _
    end
    nil
  end; alias ui_image image # === ui_image

end; end