#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/requires/require_the_libui_classes.rb'
# =========================================================================== #
module LibuiParadise

  require 'libui_paradise/project/project.rb'

  # ========================================================================= #
  # === LibuiParadise.do_require_the_libui_classes
  #
  # This method will batch-require all libui-paradise classes under
  # the libui_classes/ subdirectory.
  # ========================================================================= #
  def self.do_require_the_libui_classes
    target = LibuiParadise.project_base_dir?+'libui_classes/*.rb'
    files_that_are_to_be_required = Dir[target]
    files_that_are_to_be_required.each {|this_file|
      require "libui_paradise/libui_classes/#{File.basename(this_file)}"
    }
  end

end

if __FILE__ == $PROGRAM_NAME
  LibuiParadise.do_require_the_libui_classes
end