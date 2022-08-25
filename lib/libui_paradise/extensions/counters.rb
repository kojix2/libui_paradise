#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/extensions/counters.rb
# =========================================================================== #
module LibuiParadise

# =========================================================================== #
# === @counter_left
# =========================================================================== #
@counter_left = 0

# =========================================================================== #
# === LibuiParadise.counter_left?
# =========================================================================== #
def self.counter_left?
  @counter_left
end; self.instance_eval { alias counter_left  counter_left? } # === LibuiParadise.counter_left
     self.instance_eval { alias left_counter  counter_left? } # === LibuiParadise.left_counter
     self.instance_eval { alias left_counter? counter_left? } # === LibuiParadise.left_counter?

# =========================================================================== #
# === LibuiParadise.counter_left=
# =========================================================================== #
def self.counter_left=(i = 1)
  @counter_left = i
end

# =========================================================================== #
# === @counter_top
# =========================================================================== #
@counter_top = 0

# =========================================================================== #
# === LibuiParadise.counter_top?
# =========================================================================== #
def self.counter_top?
  @counter_top
end; self.instance_eval { alias counter_top  counter_top? } # === LibuiParadise.counter_top
     self.instance_eval { alias top_counter  counter_top? } # === LibuiParadise.top_counter
     self.instance_eval { alias top_counter? counter_top? } # === LibuiParadise.top_counter?

# =========================================================================== #
# === LibuiParadise.counter_top=
# =========================================================================== #
def self.counter_top=(i = 1)
  @counter_top = i
end

# =========================================================================== #
# === LibuiParadise.counters?
# =========================================================================== #
def self.counters?
  return [@counter_left, @counter_top]
end

end