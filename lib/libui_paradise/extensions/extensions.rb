#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::Extensions
# =========================================================================== #
# require 'libui_paradise/extensions/extensions.rb
# include Libuiparadise::Extensions
# =========================================================================== #
require 'libui' # Mandatory require-call.

module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  require 'libui_paradise/extensions/hash_fiddle_pointer_widgets.rb'
  require 'libui_paradise/fiddle/pointer.rb'
  require 'libui_paradise/libui_classes/window.rb'
  require 'libui_paradise/extensions/misc.rb'

end; end

alias e puts

LibuiParadise::Extensions.initializer # Make UI known here.