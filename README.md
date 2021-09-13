[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](https://www.gobolinux.org/)
[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](https://www.ruby-lang.org/en/)
[![Gem Version](https://badge.fury.io/rb/libui_paradise.svg)](https://badge.fury.io/rb/libui_paradise)

This gem was <b>last updated</b> on the <span style="color: darkblue; font-weight: bold">12.09.2021</span> (dd.mm.yyyy notation), at <span style="color: steelblue; font-weight: bold">21:47:09</span> o'clock.

## The libui_paradise project

<img src="https://i.imgur.com/hYf3sum.png" style="margin: 1em; padding: 8px">

(This image has been partially auto-generated via **cfdg**, then modified
by me via **gimp** and ImageMagick - the rounded borders were
done via ImageMagick. You can re-use this image if you want to, including
the colour-pattern, via a **CC BY 3.0** licence. See the following link
for that licence: https://creativecommons.org/licenses/by/3.0/. For
cfdg itself, have a look at: https://www.contextfreeart.org/gallery/)

The **libui_paradise project** aims to enhance the official (upstream)
ruby-libui bindings a little bit. You can find the upstream ruby-libui
bindings, maintained by **kojix2**, here:

https://rubygems.org/gems/libui

(Or visit the github page for ruby-libui here: https://github.com/kojix2/LibUI )

Aside from this mentioned goal of enhancing the upstream bindings, the
**libui_paradise** project also attempts to demonstrate how we could
try to use a DSL to write less code in the long run; at the least
less syntax.

This is highly experimental at this stage - I want to see which API calls
make the most sense in the long run, ideally even across different GUIs
as well as the www. (For those of you who have some experience with ruby-gtk
this may seem familiar - API elements such as **.set_text()** or 
**widget1.add(widget2)**; I kind of learned GUIs first via
**ruby-gtk**, which evidently shaped my opinion on GUI layouts
to some extent.)

The official ruby-libui project comes with **13 examples**
(August 2021) so far. Have a look at the code provided on the github
page to understand what is going on - in particular the **histogram**
example is really nifty to play around with. It is probably the best,
because it features interactive and dynamic use in a visual way -
you can choose the colours, for example. A spin-button allows for
visual change too, but I think colours are more impressive than 
simple up-and-down counters.

I am trying to think about ways to simplify the code in these
examples as well, but as said: this is all **highly experimental**
and subject to change. I am going via slow babysteps here! Constant
wins the race in the long run, just remember the turtle versus
the rabbit.

**kojix2** pointed out that a half-baked OOP design may not make
a lot of sense in regards to ruby-libui - we have to think a bit
about **Fiddle::Pointer** which not everyone may have done before.
Otherwise you may end up segfaulting everything (which I did run
into already - but it is both scary and fun at the same time!).
Subclassing is also difficult - which functions should be called
to create a "proper" subclass? May there be problems as a consequence
of this? I have no idea right now. This is definitely more related
to the C API of ruby than "pure", plain ruby as such.

I do not really know C very well; **pointers** are way above my 
level of understanding, so **kojix2's** point is a fair one
to make, since someone may have to maintain a growing code base -
this may well be the case here too, so 'defensive programming'
is a viable strategy.

**However had**, at the same I still want to **experiment** and see
what may happen with the code in general - which pitfalls may happen
or which things could be improved. I think the more people use libui
and ruby-libui, the better this may become in the long run. Imagine
we could almost create a full desktop system based on libui! Even
if the original scope never was aimed towards that. :D

Lots of people could create widgets and add-ons when this were
possible ... but I digress.

**Write a GUI once, run everywhere** (well ... at the least in
theory). This is a great idea, even if libui may not be around
one day, that idea should be retained for other GUIs.

It's quite difficult to get GTK and ruby-gtk to work on
windows - I tried to compile it some days/weeks ago but I
ended up having "missing symbols" error messages afterwards.
On Linux this is much, much easier ... I literally just compile
GTK, after its dependencies are proper (glib, pango, atk,
and so forth), and then the ruby bindings maintained largely
by kou, and ... it works! At the least on linux.

(I used to be able to run ruby-gtk2 on windows in the past,
a long time ago, but sadly upstream GTK developers no longer
provide binaries, and there are no binary bundles for 
ruby-gtk on windows anymore either.)

libui is so much simpler to use on windows than GTK,
though - just do **gem install libui** and it'll work,
as-is. Literally. That's it. I tried it on my windows
laptop and it **does** indeed work. That convinced me
that it makes sense to use libui and ruby-libui.

Now I am trying to find more awesome examples to showcase
what can be done. Who knows - perhaps even CSS may be supported
one day (perhaps only on linux though, which limits the 
benefit of it; ruby-gtk3 does allow for CSS though). A
font example has also been provided, so we can upscale,
downscale, use different fonts, bold, in colours and so
on and so forth now.

Check out the colours in the file **basic_draw_text.rb**,
as courtesy provided by kojix2. That way you can style
the content of a widget more easily - only the fiddle-protection
against segfault parts is a bit strange, but that's a detail.

There currently is quite a bit of code to make this work;
in the long run I plan to simplify this if possible. **The
less code we have to write, the better** - as long as the
end code is still **readable**.

## How to require the libui_paradise project

In order to **require the libui_paradise project**, use
something like the following:

    require 'libui_paradise'

More frequently if you look at the **examples/** subdirectory, the
following is used instead:

    require 'libui_paradise/autoinclude'

Note that this particular require call does a few things automatically,
which may not always be what you may want to use. So, again - check
out the official ruby-libui repository first, including the examples,
before having a look at **libui_paradise**. This project here is a
tinker-project, very unstable, subject to change - don't use it in
production yet.

In my own projects I tend to use the above autoinclude variant
most of the time, because that way I can write less code (omit
a few lines).

## How to get started with ruby-libui and the libui_paradise project?

Well - I first recommend to you that you look directly at ruby-libui
of kojix2, in particular the examples. Run them and look what is possible
so far. Have a look at the code as well, in order to understand how it
works; after some minutes you should understand quite a bit already,
if you already know ruby.

Then you may look at the libui_paradise project and look to see what
has been added. Look at the examples of the libui_paradise project
(they are a bit simplified compared to the upstream examples), then
consider using libui_paradise/prototype/prototype.rb, copy it and 
adjust it to your project as-is. You may want to remove the grid
that is inside there and use a hbox or a vbox instead. It's all
quite simple actually once you understand the API. For example,
a button can be added in this way to a vbox:

    outer_vbox = padded_vbox # padded means that it will have some padding to the sides
    button = ui_button('Hello world!') # You can drop the ui_ prefix if you'd like to
    button.on_clicked {
      puts 'Hello world!'
    }
    outer_vbox.minimal(button) # Use minimal space if possible. Or use .add().

That's it! A button that is in a container (vbox) that outputs hello world
when clicked. Can't get much simpler than that. \o/

## Fiddle::Pointer and playing with pointers

The **ruby-libui bindings** make use of **Fiddle::Pointer** a lot -
see the file called **ffi.rb** in the ruby-libui gem ("gem install libui").
It's like **magic** to me - scary and awesome at the same time.

As a consequence the libui_paradise project has to 'handle' pointers
as well, indirectly so, via whatever ruby-libui makes available.

I decided that, at the least for the time being, we will add
**ad-hoc code** straight to Fiddle::Pointer. This is not the
optimal solution and I do not recommend doing so, even more so as 
we modify Fiddle::Pointer directly which I don't think is a good
idea; it may be better to have some proper data structures and
perhaps **subclass** from Fiddle::Pointer instead, and then modify
that subclass instead. That may be better. But for the time being,
the code here will remain as it is, until we can come up with
better ways to deal with the situation. For now **simplicity**
rules.

Some of the examples used require assigment to local variables
to avoid the GC to kick in and cause the program to end. This
is presently not very elegant - see a discussion between kojix2
and kou to improve on this part. For the time being, though,
some of the examples require 'boilerplate' assignment to 
variabless. Stay tuned for improvements in this regard; ideally
we can use libui without having to play with pointers ever.

## Constraints of the libui_paradise gem

The libui_paradise gem comes with some **constraints**.

For example, many of the ad-hoc methods on **Fiddle::Pointer**
will only work after you called e. g. **ui_vbox** or a 
similar constructor where we registered which widgets are
created (aka the **new_** methods that are available on
the **LibUI** 'namespace'). Only when this has happened
will that widget become registered in the main Hash.

That then means, logically, that if you use a method such as:

    check_button = ui_check_button
    check_button.is_active?

This will only work if that widget was created already prior
to that "method call".

What this means in practice is that it is best if you
**create all the skeleton** (the **basic UI elements**) **before**
calling any other code, including on-clicked or on-toggle
events. Otherwise you may find nil values and don't
know why that is the case so. If this seems too complicated
for you, don't worry - the examples distributed via the
libui_paradise gem should work fine (except two buggy ones), so
the point of this subsection here is to keep your attention to
the fact that, as of right now, if you use libui_paradise, the
**proper-order-of-elements is important**. Ideally create all
the widgets first, before you add additional functionality to them.

This is admittedly not a very elegant limitation right
now, and one day this restrictions may be removed or
lifted - but for now, it is a limitation that requires
a tiny bit of discipline to work around, for the time being.
So, again - it is best to split up the skeleton UI from
the function.

## How to use an 'Open File' button

I came up with the following solution for now:

    outer_vbox = padded_vbox
    button_open_file = button('Open file')
    button_open_file.on_clicked {
      filename = open_file(window).to_s # This is the part that will open a local file.
    }
    outer_vbox << button_open_file # Add the button to the outer-vbox.

Calling the **.to_s** method on the Fiddle::Pointer yields the actual
filename. You can then add more code to deal with this.

**window** above refers to the **main_window**. See the example
**019_open_file_button_example.rb** for how this actually works.

In the future this may be even further simplified a little, as
opening local files is a very common task in most GUIs. A
single method probably should suffice for using such a
specialized button.

## How to quit from a ruby-libui widget

I found that:

    UI.quit

Works best overall. And seems to suffice as well.

There are some other calls, such as destroy-control and similar
actions, which are probably clean-up related - but by and large
**UI.quit** seems to be the main part how to exit from a
libui-application.

I document this here in the event that I forget it in a few
months.

If you use the libui_paradise gem then you can use the
following method to use a quit button:

    a_quit_button = ui_quit_button

If you want another textual description then you can do the
following:

    a_quit_button = ui_quit_button(text: 'Open a local file') # That text description would be confusing though
    a_quit_button = ui_quit_button(text: 'Exit the application') # Much better now! \o/

## Subclassing

Currently subclassing from LibUI elements does not work - I simply
have no idea how to "subclass" from a **Fiddle::Pointer**. Perhaps we
have to build up a data structure that behaves like Fiddle::Pointer
but also has methods that allow 'OOP behaviour'. Has anyone tried
this yet? I am scared to try considering I already got segfaults ...

Eventually I may figure this out - or somene else with more knowledge
will make this available. We can probably 'fake' subclassing to
a pointer somehow ... after all ruby internally has to figure it
out as well and probably did so already, on the C-level side.

## Quickly adding text to a widget

You can use something like this:

    outer_vbox = ui_vbox
    outer_vbox.text(
      'This widget can be used to do xyz.'
    )

Again - this modifies **Fiddle::Pointer** so be wary. The second
argument is the default one for use in a label / ui_text widget.

## Working with combo-boxes

To create a combo-box, do:

    combo_box = ui_combo_box

You can fill it with an array of entries on creation-time via:

    combo_box = ui_combo_box([1,2,3,4])

This will also focus on the very first element when doing so.

If you need to do so manually you can use the toplevel method:

    UI.combobox_set_selected()

## Error messages and ui_error_message

In LibUI respectively ruby-libui you can display error messages
via a popup window.

The API is something like this:

    UI.msg_box(main_window, 'Information', 'You clicked the button')
    UI.msg_box_error(main_window, 'Information', 'You clicked the button')

The first line shows a normal message box; the second line shows how to
use a message box specifically 'adapted' for displaying errors to the
end user.

LibuiParadise makes this available via **ui_msg_box** and **ui_msg_box_error**
respectively.

## Libui Form

**Form** is a container that takes labels for its contents.

## Libui Checkbox

A simple checkbox example:

    checkbox = UI.checkbox('Checkbox')
    checkbox_toggle_callback = proc { |ptr|
      checked = UI.checkbox_checked(ptr) == 1
      UI.checkbox_set_text(ptr, "I am the checkbox (#{checked})")
    }

This may look like so on Linux:

<img src="https://i.imgur.com/d7qWalZ.png" style="margin-left: 2em; padding: 4px; border: 1px solid black;">

To query whether it is active:

    checkbox.is_active?
    checkbox.active?

This depends on the modifications to Fiddler::Pointer, so
be wary - there be dragons (perhaps). Most of these modifications
are based on .object_id, which is registered in a main, toplevel
Hash in the **libui_paradise project**.

## Adding a widget into another widget

I chose the following **API** for this:

    box1.add(box2, 1)

Note that this is "cheating" a bit because the method **.add()** is defined
on **Fiddle::Pointer**. That's scary! Segfaults coming your way. But it
also seems to work. Which is amazing ... :-)

In ruby-gtk it is quite common to use .add(). While .pack_start() and
.pack_end() are available in ruby-gtk as well, I think .add() is the
simpler name. We just add a widget to another widget - job done.

(I may also use << as alias to .add() and while << is great, remember
that it can not easily be used all the time, e. g. box1 << box2 << 
box3 versus box1.add(box2).add(box3) - the latter is a bit more
resilient syntax-wise.)

I also added << as an alias to .add() but I am not yet sure if this
is a good idea. It's super-nifty to use << everywhere, but it also
changes the syntax of the whole .rb file ... on the other hand, using
<< is easier than .add() so ... I'll go with that as well. Remember
there is more than one way to do something in ruby - you need to 
select the variant(s) that work best for you. I ignore the
others. ;)

Since a while the above can be simplified a bit.

Rather than:

    box1.add(box2, 1)

You can now do:

    box1.maximal(box2)

This is a tiny bit longer, but you can omit the ", 1" part, which is
nice. The alternative is .minimal(), which defaults to:

    add(second_widget, 1)

## Libui Tabs

The notebook-tab may look like this:

<img src="https://i.imgur.com/olWQAIJ.png" style="margin-left: 2em">

## Adding a horizontal separator

The method **UI.new_horizontal_separator** can be used to add (or rather
first create) a horizontal separator.

You can then add it via .add() or << if you use the libui_paradise
project. Alternatively use the toplevel method provided by ruby-libui,
since that is what the libui_paradise project is doing anyway.

To simplify this further, you can do something like this:

    outer_vbox = ui_vbox # I call the most-outer vbox usually outer-vbox
    outer_vbox.add_hsep
    # outer_vbox.add_horizontal_separator # Or this variant if you prefer some verbosity instead.

I needed this functionality to quickly add horizontal separators for some
visual cue in the **User Interface**. Using **.add_hsep** is very convenient
and fast to write/type.

## Entries in LibUI (ui_entry)

The source for Unix (including Linux) can be read here:

https://github.com/andlabs/libui/blob/master/unix/entry.c

Personally I tend to create a new entry element in this way:

    entry = ui_entry

To set new content to it, do:

    entry.set_text('foobar') # Make sure it is a String; that seems to work better.

To respond to events look at **OnChanged**.

It can be set read only via:

    entry.read_only # This has not been added into libui-paradise yet.

To respond to on-changed events, you can use:

   UI.entry_on_changed()

Complete example:

    text_changed_callback = proc { |ptr|
      puts "Current textbox data: '#{UI.entry_text(ptr)}'"
    }

    text_entry = ui_entry
    text_entry.set_text('Please enter a command')
    text_entry.on_changed {
      text_changed_callback
    }

The Proc object has to be passed into the {} block variation.

The latter uses:

    UI.entry_on_changed(text_entry, text_changed_callback, nil)

## Grids in LibUI

The API is quite complex and hard to remember:

    UI.grid_append(grid, entry1, 0, 0, 2, 1, 0, 0, 1, 0)

Who can remember offhand what these values mean?

The upstream struct is this:

    struct gridChild {
	    uiControl *c;
	    int left;
	    int top;
	    int xspan;
	    int yspan;
	    int hexpand;
	    uiAlign halign;
	    int vexpand;
	    uiAlign valign;

	    // have these here so they don't need to be reallocated each relayout
	    int finalx, finaly;
	    int finalwidth, finalheight;
	    int minwidth, minheight;
    };

The documentation for Go has this signature:

    func (g *Grid) Append(child Control, left, top int, xspan, yspan int, hexpand bool, halign Align, vexpand bool, valign Align)

Append adds the given control to the Grid, at the given coordinate. 

I assume that **uiControl c** refers to the widget that is to be embedded
into the grid, so the numbers that follow afterwards are the ones
that are important. Let's have a look at them, based on the above API
call, and only list these again, without the **()**:

    # left, top, xspan, yspan, hexpand, halign, vexpand, valign
    #  0,    0,    2,     1,      0,      0,       1,      0

xspan and yspan refer to width; left and top refer to the position
in the grid. hexpand and vexpand means whether the grid-cell will
expand horizontally or vertically. halign and valign, I think,
are used to align the grid-cell horizontally and vertically, so you
can position them exactly in the middle.

Recently (August 2021) I discovered that you can actually put 
a button-in-a-button. I don't know whether this is a bug or
a feature, but it is hilarious.

The 'raw' code I used for this was the following:

    UI.grid_append(grid, UI.new_button('3'),0,1,1,1,1,1,1,1)
    UI.grid_append(grid, UI.new_button('4'),1,1,1,1,1,1,1,1)
    UI.grid_append(grid, UI.new_button('5'),0,1,1,1,1,0,1,0)
    UI.grid_append(grid, UI.new_button('6'),1,1,1,1,1,0,1,0)

This led to the following image:

<img src="https://i.imgur.com/6sWwWKh.png" style="margin-left: 1em">

The smaller buttons and the larger buttons can be clicked. They
reside in the same grid-cell. I don't know whether this is a 
bug or a feature really, but this was quite hilarious to see.
In the event that I may forget this, I'll keep this here as
a reference.

## Margins in LibUI

The **margin** property specifies if the window content should have a
margin or not. The default value is false, meaning that there will
be no margin.

In order to understand the difference, a visual image may be
best - the first image that is shown next shows **no margin**,
whereas the second image **shows** a margin.

<img src="https://cloud.githubusercontent.com/assets/11197111/16465935/804a30d4-3e41-11e6-8189-150e8cddc152.png" style="margin-left: 2em"><br>
<img src="https://cloud.githubusercontent.com/assets/11197111/16465906/68304cfe-3e41-11e6-8ae0-3123205ee136.png" style="margin-left: 2em"><br>

Note that the API name is **margined** rather than **margin** - 
got me a little while to get used to that name.

The API in Go is: __func (*Group) SetMargined__ respectively
__func (g *Group) SetMargined(margined bool)__. When **true**
then the group has margins around the child widgets, as mentioned
already.

The **size** of the margins in use, is, unfortunately, determined
automatically by the OS - we currently (2021) do not have control
over the size of the margin at hand via **libui**.

Code examples for 'raw' **ruby-libui** are these:

    UI.window_set_margined(MAIN_WINDOW, 1)
    UI.group_set_margined(group, 1)

Because I prefer calling methods on objects, I added this instead:

    MAIN_WINDOW.is_margined
    MAIN_WINDOW.uses_a_margin # Or this variant.

Note that we are here faking method-calls on a Fiddle::Pointer, but
if we don't pay attention then it looks like **OOP**! If it walks
like a duck, quacks like a duck then ... it may be a
**Fiddle::Pointer:Duck**!!!

## Entry

An entry can be set read only (readOnly: Boolean, aka true or false).

An entry in libui may look like this:

<img src="https://raw.githubusercontent.com/parro-it/libui-node/master/docs/media/UiEntry.png" style="margin-left:1em">

## Borderless windows

A window that is **borderless: true** will not show any title or
outside frame. This may be useful for games and what not.

## Spinbutton / Spinbox

You can use:

    UI.new_spinbox

To create a new spinbox.

To specify the min and max range, pass them as parameters:

    UI.new_spinbox(0, 100)

If you use the extensions then you can do this instead:

    ui_spinbox
    spinbox # this is the simplest variant

You should be able to set a value via set_value but I have
not yet added an example for this.

Relevant methods are:

    UI.spinbox_on_changed()
    UI.spinbox_set_value()
    UI.spinbox_value() 

To set a value:

    spinbox.set_value(42)
    spinbox.value = 42 # this works as well

## Enabling / Disabling buttons in libui

This is, assumingly, already possible via:

    libui/ui.h

    Lines 105 to 107 in a0a9807
     _UI_EXTERN int uiControlEnabled(uiControl *); 
     _UI_EXTERN void uiControlEnable(uiControl *); 
     _UI_EXTERN void uiControlDisable(uiControl *); 

In ruby-libui this should be possible via:

    LibUI.control_enable()
    UI.control_enable()

    LibUI.control_disable()
    UI.control_disable()

## libui and ruby-libui internals

This is an incomplete subsection. I know almost nothing at all about
C; kojix2 knows more, so I refer you to the homepage of ruby-libui
respectively.

Most of the code for ruby-libui resides under ffi.rb. In August 2021
this file contains almost 1000 lines, including newlines. Still quite
some code.

The two most important components there, as far as I understand it,
are **try_extern** and **structs**.

For instance:

    try_extern 'void uiOnShouldQuit(int (*f)(void *data), void *data)'

    Control = struct [

I assume that any support made available for ruby **must** have a
corresponding entry in **ffi.rb**. At the least this is how I
understood it.

If it is not in **ffi.rb** then support for that was not (yet) added.

You can probably use the rubygems features of comparing old gem 
releases with one another to see which support has been added to
ruby-libui over the past months or so. Most work was probably done
in 2020 or even before that (there are some older ruby bindings
to libui, but these work differently as kojix2 explained).

## Todo List

Here I will list some todo entries - if anyone finds out how to solve
them, you are welcome to share!

- Find out how to create "proper" subclasses to Fiddle::Pointer, simulating a subclass to it.
- Find out how halign and valign work in Libui-Grid. Somehow I can not easily reposition it ...
  or perhaps I can and just have not noticed this (may have to embed one widget in another
  widget in order for this to come into effect)
- Find out how to do ad-hoc calls on linux to gtk, so that we can use CSS.

## Limitations of/in LibUI

LibUI is not perfect - it is missing many things that should work just fine
on the main operating systems. On top of that I'd love to support specific
features on a given operating system even if it is NOT cross-platform. But
this is not possible via LibUI.

The following subsection mentions a few constraints of LibUI in varying 
degrees of complexity/importance:

- No CSS support. I miss this. On ruby-gtk3 this is possible. In LibUI I can't.
- Unable to set different fonts for an application other than using FontButton.

## Structure of the project

In **September 2021** the libui_paradise project was re-arranged slightly. There
is now a dedicated libui_classes/ directory that "simulates" separate classes.
For example, libui_button now resides in button.rb. I use the same directory
layout in the gtk_paradise gem and I think it makes sense - at the least I 
can quickly find the code that I may want to modify or extend.

Another reason why the project was re-structured was so that we can use a
unified DSL for the GUI elements.

For example:

    _ = button
    _.on_clicked {
      puts 'Hello world!'
    }

Should work on ruby-gtk3, libui and so forth one day - even on the www. But
the different toolkits do not implement the same functionality. Libui only
offers a reduced functionality, for instance. Thus, the DSL that we may then
use can only support a subset of functionality, whereas other toolkits are
more useful in this regard. This was an additional reason why files such
as button.rb were created - it makes it easier to know which functionality
has to be changed in order for libui_paradise to enable such a unified
DSL approach.

Note that the older libui_paradise gem will be made available at the least
for three months (so until end of December 2021 at the least).

--------------------------------------------------------------------------------
## SNIPPETS.md

Next, the content of the file called **SNIPPETS.md** will be shown.


<pre>
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

# How to create a button (button tag, buttons tag):

  button1 = UI.new_button('Text')
  button2 = UI.new_button('▶')

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

# Define a vertical box:

  vbox = UI.new_vertical_box

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

# Create a textview:

  UI.new_non_wrapping_multiline_entry

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

# Create a new tabbed notebook:

  ui_tabs
  ui_notebook

# Add content to an editable combox:

  UI.append() # .append() adds the named item to the end of the EditableCombobox.

# How to run the main loop:

  UI.main

# How to quit:

  UI.quit

# Create a new table:

  table = UI.new_table

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

Available "new"-widgets in LibUI:

  UI.new_area
  UI.new_group
  UI.new_spinbox
  UI.new_attributed_string
  UI.new_horizontal_box
  UI.new_stretch_attribute
  UI.new_background_attribute
  UI.new_horizontal_separator                 # this is a simple horizontal separator
  UI.new_tab
  UI.new_button                               # this is a simple button
  UI.new_image                                # this is a simple image
  UI.new_table                                # this is a simple table
  UI.new_checkbox                             # this is a simple checkbox
  UI.new_italic_attribute                     # this is basically italic font-style
  UI.new_table_model
  UI.new_color_attribute
  UI.new_label
  UI.new_table_value_color
  UI.new_color_button
  UI.new_menu
  UI.new_table_value_image
  UI.new_combobox                             # this is a combobox
  UI.new_multiline_entry                      # this is a textview
  UI.new_table_value_int
  UI.new_date_picker
  UI.new_non_wrapping_multiline_entry
  UI.new_table_value_string
  UI.new_date_time_picker
  UI.new_open_type_features
  UI.new_time_picker
  UI.new_editable_combobox
  UI.new_password_entry
  UI.new_underline_attribute
  UI.new_entry
  UI.new_progress_bar                         # this is a progress_bar
  UI.new_underline_color_attribute
  UI.new_family_attribute
  UI.new_radio_buttons
  UI.new_vertical_box
  UI.new_features_attribute
  UI.new_scrolling_area                       # this is a scrolling area
  UI.new_vertical_separator
  UI.new_font_button
  UI.new_search_entry                         # this is a search entry
  UI.new_weight_attribute
  UI.new_form                                 # this is a form
  UI.new_size_attribute
  UI.new_window
  UI.new_grid
  UI.new_slider

</pre>


--------------------------------------------------------------------------------

## Advantages and Disadvantages of the libui project

It would be unfair to only selectively name advantages but not talk about
disadvantages, so this subsection will show some limitations, trade-offs,
constraints and opportunities. This is not complete, but it may become
somewhat more complete over time. Stay tuned.

(a) Advantages:

- Works on windows out-of-the-box after you installed the libui-gem.
- Is super-simple to use compared to other toolkits, including ruby-gtk.
- Super-simple to build up a prototype for a GUI, buttons that work,
spin-boxes, text-views and so forth. Faster than any other toolkit
IMO.
- Works cross-platform.

(b) Disadvantage:

- Limited ability to control the layout and size of widgets.
- May look like utter crap ... :-)
- Some functionality is missing, such as a scrolled-window for every widget.
- No way to use different fonts in the same application and choosing a font
is needlessly complicated.

Some more disadvantages relate to Fiddle::Pointer. You kind of need to
know C fairly well as well as the GC in ruby, in order to understand
what is going on. Since I don't, I hit a dead end, kind of.

This is so far in September 2021. Let's see what the future brings.
Perhaps other toolkits will learn from libui and implement the good
parts for **their own** widget set.

## Links related to libui or libui-based projects

This subsection may contain a few links, in the event that other
people want to see useful entries.

I will try to explain what is to be seen by these various pages.

(1) https://wiki.call-cc.org/eggref/4/libui

This is using chicken-egg scheme for bindings to libui. I like the
simplicity and overview - it's really nice to read and use. I'd
wish we would have this for ruby too. :)

Note that the documentation is outdated as of 2021, though. A fate
shared with a lot of documentation in general out there ...

(2) https://pkg.go.dev/github.com/andlabs/ui

This is andlabs documentation for libui, from the point of view of
Go. It is probably the biggest documentation for libui. While it
is specific to Go, as it was written by the same author you can
expect the documentation to be quite decent.


## Contact information

If your creative mind has ideas and specific suggestions to make this
gem more useful in general, feel free to drop me an email at any
time, via:

    shevy@inbox.lt

Before that email I used an email account at Google gmail, but in **2021** I
decided to slowly abandon gmail for various reasons. In part this is because
the UI annoys me (on non-chrome browser loading takes too long), but also
because of Google's attempt to establish mass surveillance via its
federated cohorts sniffing (FLoC). I do not know what happened at Google,
but enough is enough - there is only so much you can take while supporting
greed. When it comes to data mining done by private groups, ultimately
the user became the product.

Do keep in mind that responding to emails may take some time,
depending on the amount of work I may have at that moment, due
to reallife time constraints. I will, however had, read feedback
eventually. Patches and code changes are welcome too, of course,
as long as they are in the spirit of the project at hand, e. g.
fitting to the general theme. For this I may make use of github
as a discussion site, but this has a low priority right now.
