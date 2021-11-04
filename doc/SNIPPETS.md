# How to require libui:

  require 'libui'

# How to instantiate libui:

  UI = LibUI
  init = UI.init

# How to add a new main window:
                                             # width, height, hasMenubar
  main_window = UI.new_window('hello world', 300, 200, 1)

  Source code:

    https://raw.githubusercontent.com/andlabs/libui/master/unix/window.c

# How to add a libui-widget to the main window / Designate a child widget:

  UI.window_set_child(main_window, button)

# Act on closing-event (on quit tag):

  UI.window_on_closing(main_window) {
    puts 'Bye Bye'
    UI.control_destroy(main_window)
    UI.quit
    0
  }
  # Or simpler:
  close_properly(main_window)

# How to properly close via LibuiExtensions:

  main_window = UI.window('Notepad', 500, 300, 1)
  UI.close_properly(main_window)
  # Or simpler:
  close_properly(main_window)

# Add the window to the main UI:

  UI.control_show(main_window)
  main_window.show_the_controls # Or use this one here.

# Set the padding on a grid:

  UI.grid_set_padded(grid, 25)

# Attach a new widget onto the grid:

  UI.grid_append(grid, text('Yo2'), 1, 0, 1, 1, 0, 0, 1, 0)

# How to add a click-action to the button:

  UI.button_on_clicked(button) {
    UI.msg_box(main_window, 'Information', 'You clicked the button')
    0
  }

# How to add a margin:

  UI.window_set_margined(MAIN_WINDOW, 1)

# How to exit easily:

  UI.window_on_closing(main_window) {
    UI.exit_from(main_window)
  }

# Create an attributed String:

  string = UI.new_attributed_string
  attributes = UI.new_family_attribute("Courier New 30")
  attribute = UI.new_color_attribute(0.75, 0.25, 0.5, 0.75)
  UI.append_with_attribute("text color", attribute, nil)

# How to set a padded box:

  UI.box_set_padded(box, 1) # The value is either 0 or 1.

  Alignment may be:
    0: Fill
    1: Start
    2: Center
    3: End
 Positioning:
    0: Left
    1: Top
    2: Right

# Create a message-box and an error message box:

  UI.msg_box(main_window, 'Information', 'You clicked the button')
  UI.msg_box_error(main_window, 'Information', 'You clicked the button')

# Add a checkbox (checkbox tag, checkbutton)

  checkbox = UI.new_checkbox('Checkbox') # or ui_checkbox
  checkbox_toggle_callback = proc { |pointer|
    checked = UI.checkbox_checked(pointer) == 1
    UI.window_set_title(MAIN_WINDOW, "Checkbox is #{checked}")
    UI.checkbox_set_text(pointer, "I am the checkbox (#{checked})")
    0
  }
  UI.checkbox_on_toggled(checkbox, checkbox_toggle_callback, nil)
  UI.box_append(inner, checkbox, 0)

  To set it checked:

  checkbox.set_checked(1)

  To query its state:

    checked = UI.checkbox_checked(pointer) == 1

# And the control:

  UI.control_show(main_window)

# Using a text-entry (ui entry tag):

  text_entry = UI.new_entry
  UI.entry_set_text(text_entry, 'Please enter your feelings')
  UI.entry_on_changed(text_entry, text_changed_callback, nil)

  # To set this on a "multiline entry", aka spanning several
  # rows, do use:
  UI.multiline_entry_set_text(entry1, 'Yo there')
  ui_text_view # an alias used in libui_paradise

  text1 = UI.entry_text(entry1) # Obtain text. You may have to call .to_s on it, to guarantee the String.
  UI.multiline_entry_text # Obtain the text from a multiline entry.

# Putting the text-entry into a hbox:

  UI.box_append(hbox1, text_entry, 1)

# Create a combobox (combo tag, combobox tag):

  combobox_selected_callback = proc { |ptr|
    puts "New combobox selection: #{UI.combobox_selected(ptr)}"
  }
  cbox = UI.new_combobox
  UI.combobox_append(cbox, 'combobox Item 1')
  UI.combobox_append(cbox, 'combobox Item 2')
  UI.combobox_append(cbox, 'combobox Item 3')
  UI.box_append(inner, cbox, 0)
  UI.combobox_on_selected(cbox, combobox_selected_callback, nil)

  # Or more concise:
  combo_box = UI.combobox {
    ['combobox Item 1', 'combobox Item 2', 'combobox Item 3']
  }

  # Select the first entry:

  UI.combobox_set_selected(combobox, 0) # The first one will be active too.

# Add content to an editable combox:

  UI.append() # .append() adds the named item to the end of the EditableCombobox.

# How to run the main loop:

  UI.main

# How to quit:

  UI.quit

# How to build a menu-interface (menu tag):

  help_menu = UI.new_menu('Help')
  version_item = UI.menu_append_item(help_menu, 'Version')

# Create a new image:

  image = UI.new_image(width, height)

# Fonts and LibUI:

  font_descriptor = UI::FFI::FontDescriptor.malloc
  p 'Font family: '+font_descriptor.Family.to_s+
    'Font size: '+font_descriptor.Size+
    'Font weight: '+font_descriptor.Weight+
    'Font italic: '+font_descriptor.Italic+
    'Font stretch: '+font_descriptor.Stretch

# Available widgets in libUI:

  Button                 A button with a label
  Checkbox               A checkbox with a label
  Combobox               A simple combobox
  ColorButton            A button for selecting a color
  EditableCombobox       A combobox that can be edited.
  Entry                  Text input, can be disabled.
  FontButton             A button for selecting a font (Incomplete: Cannot set programmatically)
  Form                   A container that takes labels for its contents
  Grid                   A container that aligns widgets for window design
  Group                  A container that provides a title for a set of items
  Label                  Displays a single line of text
  Menu                   Creates a single column of an application menu
  MultilineEntry         An entry that allows multiple lines.
  Time and Date Pickers  Allows choosing of a date and/or time.
  ProgressBar            Displays a progress bar
  RadioButton            A set of radio buttons
  Separator              A simple vertical or horizontal separator
  Slider                 A draggable slider for choosing a value in a range
  Spinbox                A numerical input with a minimum and maximum range
  Tab                    A set named tabs for placing items in
  Window                 Contains any other widget, cannot be embedded in a container
  VBox, HBox             A vertical or horizontal box for grouping items
