#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example displays images that can be freely downloaded from the
# Studio Ghibli website.
# =========================================================================== #
# require 'examples/complex/026_basic_table_image.rb'
# =========================================================================== #
require 'libui_paradise/autoinclude'
require 'chunky_png'
require 'open-uri'

N_TIMES = 10
# =========================================================================== #
# === REMOTE_URL
# =========================================================================== #
REMOTE_URL = 'https://www.ghibli.jp/gallery/thumb-redturtle%03d.png'

main_window = ui_main_window('The Red Turtle', 310, 350, 0)

hbox = ui_padded_hbox
main_window.simple_exit
main_window.child = hbox

# =========================================================================== #
# === IMAGES
# =========================================================================== #
IMAGES = []

N_TIMES.times { |i|
  url = format(REMOTE_URL, (i + 1))
  this_file = URI.open(url)
  # =========================================================================== #
  # Use ChunkyPNG::Canvas to get information about the image at hand.
  # =========================================================================== #
  canvas = ChunkyPNG::Canvas.from_io(this_file)
  this_file.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  # ========================================================================= #
  # Add a new image next:
  # ========================================================================= #
  image = UI.new_image(width, height)
  UI.image_append(image, data, width, height, width * 4)
  IMAGES << image # Store all images in the following area.
rescue StandardError => error
  warn url, error.message
}

# =========================================================================== #
# Protects BlockCaller objects from garbage collection.
# =========================================================================== #
@blockcaller = []
# =========================================================================== #
# === rbcallback
# =========================================================================== #
def rbcallback(*args, &block)
  args << [0] if args.size == 1 # Argument types are ommited
  blockcaller = Fiddle::Closure::BlockCaller.new(*args, &block)
  @blockcaller << blockcaller
  blockcaller
end

model_handler = LibUI::FFI::TableModelHandler.malloc
model_handler.NumColumns   = rbcallback(4) { 1 }
model_handler.ColumnType   = rbcallback(4) { 1 } # Image
model_handler.NumRows      = rbcallback(4) { IMAGES.size }
model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, _column|
  LibUI.new_table_value_image(IMAGES[row])
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = LibUI.new_table_model(model_handler)

table_params = LibUI::FFI::TableParams.malloc
table_params.Model = model
table_params.RowBackgroundColorModelColumn = -1

table = ui_table(table_params)
UI.table_append_image_column(table, 'www.ghibli.jp/works/red-turtle', -1)
hbox.maximal(table)

main_window.show_the_controls

UI.window_on_closing(main_window) {
  e 'Bye Bye'
  UI.control_destroy(main_window)
  UI.free_table_model(model)
  IMAGES.each { |i| UI.free_image(i) }
  UI.quit
  0
}

UI.main_then_quit