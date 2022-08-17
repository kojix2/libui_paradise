#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# === LibuiParadise::Extensions
#
# This .rb file is primarly used to "extend" libui in a convenient
# way. That way we only have to require this file and the rest will
# be set up correctly for us.
# =========================================================================== #
# require 'libui_paradise/extensions/extensions.rb
# include Libuiparadise::Extensions
# =========================================================================== #
require 'libui' # Mandatory require-call.

module LibuiParadise

module Extensions # === LibuiParadise::Extensions

  require 'libui_paradise/fiddle/pointer.rb'
  require 'libui_paradise/extensions/hash_fiddle_pointer_widgets.rb'
  require 'libui_paradise/extensions/misc.rb'
  require 'libui_paradise/libui_classes/libui_classes.rb'

end; end

alias e puts

LibuiParadise::Extensions.initializer # Make UI known here.