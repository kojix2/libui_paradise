#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui'

LibUI.init

UI = LibUI

music_directory = File.expand_path(ARGV[0] || '~/Music/')
midi_files      = Dir.glob(File.join(music_directory, '**/*.mid'))
                     .sort_by { |path| File.basename(path) }
VERSION = '0.0.1'.freeze

@pid = nil

play_midi = proc do
  if @pid.nil? && @selected_file
    begin
      @pid = spawn "timidity #{@selected_file}"
      @th = Process.detach @pid
    rescue Errno::ENOENT => _error
      warn 'Timidty++ was not found. Please install Timidity++.'
      warn 'https://sourceforge.net/projects/timidity/'
    end
  end
  0
end

stop_midi = proc do
  if @pid
    if @th.alive?
      Process.kill(:SIGKILL, @pid)
      @pid = nil
    else
      @pid = nil
    end
  end
end

help_menu = LibUI.new_menu('Help')
version_item = LibUI.menu_append_item(help_menu, 'Version')

LibUI.new_window('Tiny Midi Player', 200, 50, 1).tap do |main_window|
  LibUI.menu_item_on_clicked(version_item) {
    LibUI.msg_box(main_window,
               'Tiny Midi Player',
               "Written in Ruby\n" \
               "https://github.com/kojix2/libui\n Version #{VERSION}"
    )
    0
  }

  LibUI.window_on_closing(main_window) {
    LibUI.control_destroy(main_window)
    LibUI.quit
    0
  }

  LibUI.new_horizontal_box.tap do |hbox|
    LibUI.new_vertical_box.tap do |vbox|
      LibUI.new_button('▶').tap { |button1|
        LibUI.button_on_clicked(button1, play_midi)
        LibUI.box_append(vbox, button1, 1)
      }
      LibUI.new_button('■').tap { |button2|
        LibUI.button_on_clicked(button2, stop_midi)
        at_exit(&stop_midi)
        LibUI.box_append(vbox, button2, 0)
      }
      LibUI.box_append(hbox, vbox, 0)
    end
    LibUI.window_set_child(main_window, hbox)

    LibUI.new_combobox.tap do |cbox|
      midi_files.each { |path|
        name = File.basename(path)
        LibUI.combobox_append(cbox, name)
      }
      LibUI.combobox_on_selected(cbox) { |ptr|
        @selected_file = midi_files[UI.combobox_selected(ptr)]
        if @th && @th.alive?
          stop_midi.call
          play_midi.call
        end
        0
      }
      LibUI.box_append(hbox, cbox, 1)
    end
  end
  LibUI.control_show(main_window)
end

LibUI.main
LibUI.quit
