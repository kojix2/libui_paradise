#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# This example display a single image. This is hardcoded to a local
# path, so change that constant if you want another image.
# =========================================================================== #
require 'libui_paradise/autoinclude'
require 'chunky_png'

# =========================================================================== #
# === THIS_FILE
# =========================================================================== #
THIS_FILE = '/home/x/data/images/NJOY/MEDITERRANEAN.png'
main_window = ui_main_window('The Red Turtle', 310, 350, 0)

hbox = ui_padded_hbox
main_window.child = hbox
main_window.intelligent_exit

# =========================================================================== #
# === IMAGES
#
# Must store it here to free it up lateron again.
# =========================================================================== #
IMAGES = []

canvas = ChunkyPNG::Canvas.from_file(THIS_FILE)
data = canvas.to_rgba_stream
width = canvas.width
height = canvas.height
# ========================================================================= #
# Add a new image here:
# ========================================================================= #
image = UI.new_image(width, height)
UI.image_append(image, data, width, height, width*4)
IMAGES << image # Store all images in the following area.

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

model_handler = UI::FFI::TableModelHandler.malloc
model_handler.NumColumns   = rbcallback(4) { 1 }
model_handler.ColumnType   = rbcallback(4) { 1 } # Image
model_handler.NumRows      = rbcallback(4) { 1 }
model_handler.CellValue    = rbcallback(1, [1, 1, 1, 1]) do |_, _, row, _column|
  UI.new_table_value_image(IMAGES[row])
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = UI.new_table_model(model_handler)

table_params = UI::FFI::TableParams.malloc
table_params.Model = model
table_params.RowBackgroundColorModelColumn = -1

table = UI.new_table(table_params)
UI.table_append_image_column(table, 'www.ghibli.jp/works/red-turtle', -1)
hbox.add(table)

main_window.show_the_controls

UI.window_on_closing(main_window) {
  UI.control_destroy(main_window)
  UI.free_table_model(model)
  IMAGES.each { |i| UI.free_image(i) }
  UI.quit
  0
}

UI.main_then_quit