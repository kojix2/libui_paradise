#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
require 'libui_paradise/autoinclude'

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
    rescue Errno::ENOENT => e
      warn 'Timidty++ not found. Please install Timidity++.'
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

help_menu = UI.new_menu('Help')
version_item = UI.menu_append_item(help_menu, 'Version')

UI.new_window('Tiny Midi Player', 200, 50, 1).tap do |main_window|
  UI.menu_item_on_clicked(version_item) {
    UI.msg_box(main_window,
               'Tiny Midi Player',
               "Written in Ruby\n" \
               "https://github.com/kojix2/libui\n Version #{VERSION}"
    )
    0
  }

  UI.window_on_closing(main_window) {
    UI.control_destroy(main_window)
    UI.quit
    0
  }

  UI.new_horizontal_box.tap do |hbox|
    UI.new_vertical_box.tap do |vbox|
      UI.new_button('▶').tap do |button1|
        UI.button_on_clicked(button1, play_midi)
        UI.box_append(vbox, button1, 1)
      end
      UI.new_button('■').tap do |button2|
        UI.button_on_clicked(button2, stop_midi)
        at_exit(&stop_midi)
        vbox.add(button2, 1)
      end
      hbox.add(vbox, 0)
    end
    UI.window_set_child(main_window, hbox)

    UI.new_combobox.tap do |cbox|
      midi_files.each { |path|
        name = File.basename(path)
        UI.combobox_append(cbox, name)
      }
      UI.combobox_on_selected(cbox) { |ptr|
        @selected_file = midi_files[UI.combobox_selected(ptr)]
        if @th && @th.alive?
          stop_midi.call
          play_midi.call
        end
        0
      }
      hbox.add(cbox, 1)
    end
  end
  UI.control_show(main_window)
end

UI.main_then_quit