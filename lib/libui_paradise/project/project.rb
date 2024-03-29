#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/project/project.rb'
# LibuiParadise.project_base_dir?
# =========================================================================== #
module LibuiParadise

  # ========================================================================= #
  # === LibuiParadise::PROJECT_BASE_DIRECTORY
  # ========================================================================= #
  PROJECT_BASE_DIRECTORY =
    File.absolute_path("#{__dir__}/..")+'/'
    BASE_DIR = PROJECT_BASE_DIRECTORY

  # ========================================================================= #
  # === LibuiParadise.project_base_dir?
  #
  # Preferentially use this method rather than the constant above directly.
  # ========================================================================= #
  def self.project_base_dir?
    PROJECT_BASE_DIRECTORY
  end; self.instance_eval { alias project_base_dir        project_base_dir? } # === LibuiParadise.project_base_dir
       self.instance_eval { alias project_base_dir?       project_base_dir? } # === LibuiParadise.project_base_dir?
       self.instance_eval { alias project_base_directory? project_base_dir? } # === LibuiParadise.project_base_directory?

end

if __FILE__ == $PROGRAM_NAME
  puts LibuiParadise.project_base_dir?  
end