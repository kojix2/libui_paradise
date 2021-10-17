#!/usr/bin/ruby -w
# Encoding: UTF-8
# frozen_string_literal: true
# =========================================================================== #
# Todo:
# - Add editable entry to the table
# =========================================================================== #
require 'libui_paradise/autoinclude'

main_window = padded_window('30) Table example', 300, 200, 1)
hbox = padded_hbox
data = [
  %w( cat calm meow ),
  %w( dog loyal woof ),
  %w( chicken bird cock-a-doodle-doo ),
  %w( horse fast neigh ),
  %w( cow slow moo )
]

# Protect BlockCaller objects from garbage collection.
@block_callers = []
def rbcallback(*args, &block)
  args << [0] if args.size == 1 # Argument types are ommited
  block_caller = Fiddle::Closure::BlockCaller.new(*args, &block)
  @block_callers << block_caller
  block_caller
end

model_handler = LibUI::FFI::TableModelHandler.malloc
model_handler.to_ptr.free = Fiddle::RUBY_FREE

model_handler.NumColumns = rbcallback(4) { 2 }
model_handler.ColumnType = rbcallback(4) { 0 }
model_handler.NumRows    = rbcallback(4) { 5 }
model_handler.CellValue  = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
  UI.new_table_value_string(data[row][column])
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = LibUI.new_table_model(model_handler)

table_params = ui_table_params_malloc(model)

table = ui_table(table_params)
table.append_text_column('Animal',      0, -1)
table.append_text_column('Description', 1, -1)
table.append_text_column('Fancy Stuff', 2, -1)

hbox.add(table, 1)
main_window.child = hbox
main_window.intelligent_quit
