#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# require 'libui_paradise/examples/simple/004_date_time_picker.rb'
# =========================================================================== #
require 'libui'

# =========================================================================== #
# === TITLE
# =========================================================================== #
TITLE = 'Date Time Pickers'

LibUI.init

vbox = LibUI.new_vertical_box

date_time_picker = LibUI.new_date_time_picker

time = LibUI::FFI::TM.malloc

LibUI.date_time_picker_on_changed(date_time_picker) {
  LibUI.date_time_picker_time(date_time_picker, time)
  p sec: time.tm_sec,
    min: time.tm_min,
    hour: time.tm_hour,
    mday: time.tm_mday,
    mon: time.tm_mon,
    year: time.tm_year,
    wday: time.tm_wday,
    yday: time.tm_yday,
    isdst: time.tm_isdst
}

LibUI.box_set_padded(vbox, 1)
LibUI.box_append(vbox, date_time_picker, 1)

main_window = LibUI.new_window(TITLE, 300, 200, 1)
LibUI.window_set_margined(main_window, 1)

LibUI.window_on_closing(main_window) {
  LibUI.control_destroy(main_window)
  LibUI.quit
  0
}

LibUI.window_set_child(main_window, vbox)
LibUI.control_show(main_window)
LibUI.main
LibUI.quit
