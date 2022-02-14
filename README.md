[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](https://www.gobolinux.org/)
[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](https://www.ruby-lang.org/en/)
[![Gem Version](https://badge.fury.io/rb/libui_paradise.svg)](https://badge.fury.io/rb/libui_paradise)

This gem was <b>last updated</b> on the <span style="color: darkblue; font-weight: bold">14.02.2022</span> (dd.mm.yyyy notation), at <span style="color: steelblue; font-weight: bold">03:40:27</span> o'clock.

## The libui_paradise project

<img src="https://i.imgur.com/hYf3sum.png" style="margin: 1em; padding: 8px">

(This image has been partially auto-generated via **cfdg**, then modified
by me via **gimp** and ImageMagick - the rounded borders were
done via ImageMagick. You can re-use this image if you want to, including
the colour-pattern, via a **CC BY 3.0** licence. See the following link
for that licence: https://creativecommons.org/licenses/by/3.0/. For
cfdg itself, have a look at: https://www.contextfreeart.org/gallery/)

The **libui_paradise project** aims to enhance the official (upstream)
ruby-libui bindings a little bit.

You can find the upstream ruby-libui bindings, maintained by **kojix2**,
here:

https://rubygems.org/gems/libui

(Or visit the github page for ruby-libui here via this link:
https://github.com/kojix2/LibUI )

(Be wary of the name that I use on this page - the currently maintained gem is
called **libui**; the older gem, which was called **libui-ruby**, is no longer
maintained since as of **2019**. In the document here I may call kojix2' gem
**ruby-libui**, but the official name is simply **libui**, which refers to the
gem mentioned above: https://rubygems.org/gems/libui - I understand that I
am using a misnomer when I refer to this as **ruby-libui**, but it helps
me remember, so ...)

Aside from this mentioned goal of **trying to enhance** the upstream ruby-bindings,
the **libui_paradise** project also attempts to demonstrate how we could **try to
use a DSL** to write less code in the long run; at the least less syntax.

Less syntax is not automatically a win-win situation, but often it can
be very useful.

Example for this:

    _ = button('Hello world!') # for libui

You can use a similar variant in ruby-gtk3, for example:

    _ = Gtk::Button.new('Hello world!')

Or, if you want to use "toplevel-methods", like the above, identical to the
first variant:

    _ = button('Hello world!') # for ruby-gtk

In fact: if you notice the above three lines of code then there is indeed no
difference between which toolkit to use between the first variant and
the last variant. We could then, in theory, "plug in" different toolkits,
be it ruby-gtk, ruby-tk, ruby-libui and so forth. The **glimmer** project
is doing this to some extent, as a general DSL wrapper over GUI-related
functionality, including the www - see here: https://github.com/AndyObtiva/glimmer

We could even extend this to the www and generate the appropriate 
tags that way, by treating HTML tags as "objects". Note that this is
"in theory"; in practice there are some shortcomings, or limitations,
such as different toolkits not supporting the same widgets or
functionality. The old ruby-qt toolkit, for example, required you to
connect slots to signals, due to qt requiring this. I do not know if
this is still the case or not, but back in the days this was 
necessary and it complicated using ruby-qt a little bit.

The **libui_paradise gem** here is highly experimental at this stage
and may not work for all use cases, or may have bugs - I am still
learning myself here. I want to see which API calls make the most sense
in the long run, ideally even across different GUIs as well as the
www. (For those of you who have some experience with ruby-gtk this may
seem familiar, as pointed out above - API elements such as **.set_text()**
or **widget1.add(widget2)**; I kind of learned GUIs first via
**ruby-gtk**, which evidently shaped my opinion on GUI layouts
to some extent.)

The official ruby-libui project maintained by kojix2 comes with
**13 examples** (August 2021) so far. I assume that more examples
may be added over the coming months and years depending on use
case, time availability, motivation and so forth. Have a look at
the code provided on the github page to understand what is going
on - in particular the **histogram** example is really nifty if
you want to play around with it **interactively**. It is probably the
best example in this regard, because it features interactive and
dynamic use in a visual way - you can choose the colours, for
example. A spin-button allows for visual change too, but I think 
colours are more impressive than simple up-and-down counters.

On windows this may look like so (via kotlin-libui):

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/histogram/histogram-windows7.png" style="margin-left: 2em">

Also check out kojix2' other examples in ruby-gtk - would be great
if we could have the same in libui one day, but this also depends
on what upstream libui makes available, unless it is somehow
possible to connect multiple shared libraries into libui; then
we could perhaps extend libui.

I am trying to think about ways to simplify the code in these
examples as well, so that we can "do more by writing less". But as
stated before: this is all **highly experimental** and subject
to change. I am going via slow, tiny babysteps here! Constant
wins the race in the long run, just remember the turtle versus
the rabbit. The rabbit always believed that he would win the
race ...

**kojix2** pointed out that a half-baked or incomplete OOP design may
not make a lot of sense in regards to ruby-libui - we have to think a
bit about **Fiddle::Pointer** which not everyone may have done before.

Otherwise you may end up segfaulting everything all over the place
(which I did run into already - but it is both scary and fun at the
same time!). Subclassing is also difficult to do properly - which
functions should be called to create a "proper" subclass? May there
be problems as a consequence of trying this? I have no idea right
now. This is definitely more related to the C API of ruby than
"pure", plain ruby as such. You kind of have to understand the 
underlying C code to some extent.

I do not really know C very well; **pointers** are way above my 
level of understanding, so **kojix2's** point is a fair one
to make, since someone may have to maintain a growing code base -
this may well be the case here too, so 'defensive programming'
is a viable strategy. There are examples where one has to work
around ruby's GC too, for instance - this all makes this a little
bit more complicated than plain, "pure" ruby code.

**However had**, at the same I still want to **experiment** and see
what may happen with the code in general - which pitfalls may happen
or which things could be improved upon. I think the more people use
libui and ruby-libui, the better this may become in the long run.
Imagine we could almost create a full desktop system based on
libui! Even if the original scope never was aimed towards that. :D

This may then be fast enough for ruby-on-the-desktop, and simple
enough to do that, too. Right now this has too many shortcomings;
I miss CSS styling in particular. But, in theory, we could do
this. Anyone feels clever enough to use ruby as a desktop-UI
language via libui? I suppose it still requires some decent
knowledge of C ...

Lots of different people could create widgets and add-ons when
this were possible ... but I digress.

**Write a GUI once, run everywhere** (well ... at the least in
theory). This is an excellent idea, even if libui may not be
around one day, that idea should be retained for other GUIs
in the future.

It's quite difficult to get GTK and ruby-gtk to work on
**windows** - I tried to compile it some weeks ago but I
ended up having "missing symbols" error messages afterwards.
I managed to get the hello-world.c example working, but the
more complicated examples did not work for me.

On Linux this is much, much easier to do ... I literally just
compile GTK, after its dependencies are properly installed (glib,
pango, atk, and so forth), and then the ruby bindings maintained
largely by kou (and others), and ... it works! At the least
on linux.

(I used to be able to run ruby-gtk2 on windows in the past,
a long time ago, using the provided binaries, but sadly upstream
GTK developers no longer provide binaries as-is, and there are
no binary bundles for ruby-gtk on windows anymore either. I
assume it is possible if you know msys2, and the windows 
platform, but I am no expert on either, so ...)

**libui** is so much simpler to use on windows than GTK,
though - just do **gem install libui** and it'll work,
as-is. Literally. That's it. I tried it on my windows
laptop and it **does** indeed work. That convinced me
that it makes sense to use libui and ruby-libui. The reason it
works is because the ruby-libui gem (just called **libui**)
bundles the respective binaries, and it is quite small. This
would be much harder to do with ruby-gtk.

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

Note that the subclass situation may change eventually; see
upstream kojix2 and related discussion for fiddle. For
the time being, though, I'll retain my old approach until
I am sufficiently content with the project as-is. Right now
libui_paradise has way too much undocumented and untested
code and I still have not added all examples either (coloured
text, for instance, still has to be added; and more image-related
examples that are smaller). Stay tuned.

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

## How to require libui itself

Simply do:

    require 'libui'

Note that the **libui_paradise gem** does so automatically if you require it.
The idea here is to simply use **libui_paradise** directly, while still allowing
you to use **libui** at the same time as well, should you prefer to do so.

## How to get started with ruby-libui and the libui_paradise project?

Well - as stated elsewhere, I first recommend to you that you look directly
at ruby-libui provided by kojix2, in particular the examples that he 
distributes in the gem. Work through the examples step-by-step, possibly
starting with the smallest example, see whether they work (they do,
or should) and have a look at how things work - just to get an
overview.

Have a look at the code as well, in order to understand how it
works roughly; after some minutes or perhaps a very few hours of tinker-time
you should understand quite a bit already, if you already know ruby. Even
more so if you did work with GUIs before, including GUIs via a www-interface.

Then you are recommended to look at the libui_paradise project and look to 
see what has been added on top of what kojix2 provides. Look at the examples 
of the libui_paradise project as well (they are a bit simplified compared
to the upstream examples; unfortunately a few of them currently do not 
work), then consider using **libui_paradise/prototype/prototype.rb** in
particular. Copy it and adjust it to your project and use case, as-is. You
may want to remove the grid that is inside there and use a hbox or a vbox
instead, or a padded_hbox and padded_vbox. It's all quite simple actually
once you understand the basic API: windows, widgets, buttons, entries.

For example, a button can be added in this way to a vbox, if you use
the libui_paradise gem:

    outer_vbox = padded_vbox # padded means that it will have some padding to the sides
    button = ui_button('Hello world!') # You can drop the ui_ prefix if you'd like to
    button.on_clicked {
      puts 'Hello world!'
    }
    outer_vbox.minimal(button) # Use minimal space if possible. Or use .add().

That's it! Inside of the **.on_clicked {}** block you can run the ruby code
that you want to use. A button that is in a container (such as **vbox**) that
outputs hello world when clicked. Can't get much simpler than that. \o/

You can omit the **ui_** part above. I just use it to point out the difference;
and because I'd otherwise may have to use "button = button" aka "button = button()"
which may be confusing- Thus, using **ui_button()** appeared to make more
sense in this regard.

## How to add a margin in LibUI:

Use something like:

    LibUI.window_set_margined(MAIN_WINDOW, 1)

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
      filename = ui_open_file(window).to_s # This is the part that will open a local file.
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

## How to properly quit from a ruby-libui widget

I found that:

    LibUI.quit

Works best overall. And seems to suffice as well.

There are some other calls, such as destroy-control and similar
actions, which are probably clean-up related - but by and large
**LibUI.quit** seems to be the main part how to exit from a
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

So, as a reminder:

    main_window = LibUI.window('Notepad', 500, 300, 1)
    LibUI.close_properly(main_window)
    # Or simpler:
    close_properly(main_window)

# How to instantiate libui:

    UI = LibUI
    init = UI.init

Or just:

    LibUI.init

Since as of 2022 I prefer the longer variant, e. g. **LibUI**init. The
old UI constant ("alias") will be retained, but new code added to the
libui_paradise gem will not use **UI** - instead the slightly longer
**LibUI** is used.

## UI.new_button()

UI.new_button allows us to create a new button.

Examples:

    button1 = UI.new_button('Text')
    button2 = UI.new_button('▶')
  
## Subclassing

Currently subclassing from LibUI elements does not work - I simply
have no idea how to "subclass" from a **Fiddle::Pointer**. Perhaps we
have to build up a data structure that behaves like **Fiddle::Pointer**
but also has methods that allow for a more direct 'OOP behaviour'. Has
anyone tried this yet? I am scared to try considering I already got
segfaults everywhere ...

Eventually I may figure this out - or someone else with more knowledge
will make this available. We can probably 'fake' subclassing to
a pointer somehow ... after all ruby internally has to figure it
out as well and probably did so already, on the C-level side via
various functions.

## Using scrolling-areas in LibUI

The following API can be used to create a new scrolling area:

    LibUI.new_scrolling_area

Scrolling areas have horziontal and vertical scrollbars. The
amount that can be scrolled is determined by the area's
size, which is decided by the programmer (both when creating
the Area and by a call to SetSize). Only a portion of the
Area is visible at any time; drawing and mouse events are
automatically adjusted to match what portion is visible,
so you do not have to worry about scrolling in your
event handlers.

The method LibUI.new_scrolling_area() accepts three arguments.
The second and third are width and height, respectively
(as **integers**).

The first argument is the area handle. It has the following
pointer types (struct):

    .Draw
    .MouseEvent
    .MouseCrossed
    .DragBroken
    .KeyEvent

The handlerDraw() function in C looks like this:

    static void handlerDraw(uiAreaHandler *a, uiArea *area, uiAreaDrawParams *p)
    {
	    uiDrawTextLayout *textLayout;
	    uiFontDescriptor defaultFont;
	    uiDrawTextLayoutParams params;

	    params.String = attrstr;
	    uiFontButtonFont(fontButton, &defaultFont);
	    params.DefaultFont = &defaultFont;
	    params.Width = p->AreaWidth;
	    params.Align = (uiDrawTextAlign) uiComboboxSelected(alignment);
	    textLayout = uiDrawNewTextLayout(&params);
	    uiDrawText(p->Context, textLayout, 0, 0);
	    uiDrawFreeTextLayout(textLayout);
	    uiFreeFontButtonFont(&defaultFont);
    }

The scrollable area may look like this:

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/hello/hello-windows.png">

## Quickly adding text to a widget

You can use something like this if you use the libui_paradise gem:

    outer_vbox = ui_vbox
    outer_vbox.text(
      'This widget can be used to do xyz.'
    )

Here .text() just means to add a text onto the vertical box.

Again - this modifies **Fiddle::Pointer**, so be wary when using
it. The second argument is the default one for use in a
label / ui_text widget.

## Working with combo-boxes

To create a combo-box in vanilla libui, do this:

    alignment = LibUI.new_combobox
    LibUI.combobox_append(alignment, 'Left')
    LibUI.combobox_append(alignment, 'Center')
    LibUI.combobox_append(alignment, 'Right')
    LibUI.combobox_set_selected(alignment, 0)
    LibUI.combobox_on_selected(alignment) { on_combobox_selected(@area) }

This is a bit cumbersome, so if you use libui_paradise this
can be simplified a bit.

To create a combo-box do:

    combo_box = ui_combo_box

You can fill it with an array of entries **on creation-time** via:

    combo_box = ui_combo_box([1,2,3,4]) # simply pass your Array here
    combo_box = ui_combobox(%w( Left Center Right )) # three members of this Array

This will also focus (aka **select**) on the very first element
when doing so by default, so you can get rid of 4-5 lines of 
code. How fancy! \o/

If you need to do so manually, and focus on another element,
for example, then you can use the following toplevel method:

    UI.combobox_set_selected()

To **query the currently selected value**, use:

    UI.combobox_selected(pointer)

This is usually done via a **proc {}** object. See kojix2' examples.

In LibuiParadise a few custom methods were added, such as 
**.ui_sync_connect()**. This method was added to connect a
combo-box to a entry and automatically sync that entry whenever
the combo box is changed. See the example **007_combo_box_example.rb**
for how this works.

Or, just as a one-liner example:

    ui_sync_connect(@combo_box, @entry) # widget1, then widget2

This may not always work as you'd expect, so a third argument can
be passed (the array that populates the combo-box).

So:

    ui_sync_connect(@combo_box, @entry, @array_here)

There are probably more elegant ways to solve this, but I only
wanted to solve this quickly and move on.

The **source code** to the combo-box in libui, at the least
for UNIX/Linux, can be seen here:

https://github.com/andlabs/libui/blob/master/unix/combobox.c 

## Error messages and ui_error_message

In LibUI respectively ruby-libui you can display error messages
via a popup window. These are also called **message-box** and
**error message box**, respectively.

The API is something like this:

    LibUI.msg_box(main_window, 'Information', 'You clicked the button')
    LibUI.msg_box_error(main_window, 'Information', 'You clicked the button')

The first line shows a normal message box; the second line shows how to
use a message box specifically 'adapted' for displaying errors to the
end user.

LibuiParadise makes this available via **ui_msg_box** and **ui_msg_box_error**
respectively.

## Libui Form

**Form** is a container that takes labels for its contents. This is currently
just a stub though - we may have to research this with better examples.

## Libui Checkbox

A simple checkbox example in **plain** ruby-libui follows:

    checkbox = UI.checkbox('Checkbox')
    checkbox_toggle_callback = proc { |ptr|
      checked = UI.checkbox_checked(ptr) == 1
      UI.checkbox_set_text(ptr, "I am the checkbox (#{checked})")
    }

This may look like so on Linux:

<img src="https://i.imgur.com/d7qWalZ.png" style="margin-left: 2em; padding: 4px; border: 1px solid black;">

To query whether a checkbox is **active**, use code such as the
following:

    checkbox.is_active?
    checkbox.active?

This depends on the modifications to Fiddler::Pointer, so
be wary when you use this - there be dragons (perhaps). Most
of these modifications are based on **.object_id**, which is
registered in a main, toplevel Hash in the 
**libui_paradise project**. Not very elegant, but simple, and
it works (for the most part).

## Adding a widget into another widget

I chose the following **API** for this:

    box1.add(box2, 1)

Note that this is "cheating" a bit because the method **.add()** is defined
on **Fiddle::Pointer**. That's scary! Segfaults coming your way. But it
also seems to work to some extent. Which is amazing ... :-)

In ruby-gtk it is quite common to use **.add()**. While **.pack_start()**
and **.pack_end()** are available in ruby-gtk as well, I think .add() is
the simpler name. We just **add a widget to another widget** - job done.

(I may also use << as alias to .add() and while << is great, remember
that it can not easily be used all the time, e. g. box1 << box2 << 
box3 versus box1.add(box2).add(box3) - the latter is a bit more
resilient syntax-wise.)

As stated, **<<** was added as an alias to **.add()** but I am not yet sure
if this is a very good idea. It's super-nifty to use << everywhere, but it
also changes the syntax of the whole .rb file ... on the other hand, using
<< is easier than .add() so ... I'll go with that as well. Remember
there is more than one way to do something in ruby - you need to 
select the variant(s) that work best for you and possibly ignore the
other variants.

Since a while the above can be simplified a bit, as will be shown
next.

Rather than use:

    box1.add(box2, 1)

You can now do this instead:

    box1.maximal(box2)

This is a tiny bit longer, but you can omit the ", 1" part, which is
nice. The alternative is .minimal(), which defaults to:

    add(second_widget, 0)

So the only difference between .maximal() and .minimal() will be
whether you pass 0 or 1 to the method. See the upstream libui
API to understand the difference.

## Libui Tabs

The notebook-tab may look like this:

<img src="https://i.imgur.com/olWQAIJ.png" style="margin-left: 2em">

## Create a vertical box:

Use code like this:

    vbox = UI.new_vertical_box

If you use the libui_paradise gem, you can use this:

    vbox = ui_vbox # or
    vbox = padded_vbox

## Adding a horizontal separator or a vertical separator

The method **UI.new_horizontal_separator** can be used to add (or rather
first create) a horizontal separator.

You can then add it via .add() or << if you use the libui_paradise
project. Alternatively you can use the toplevel method provided by
ruby-libui, since that is what the libui_paradise project is doing anyway.

To simplify this further, you can do something like this:

    outer_vbox = ui_vbox # I call the most-outer vbox usually outer-vbox
    outer_vbox.add_hsep
    # outer_vbox.add_horizontal_separator # Or this variant if you prefer some verbosity instead.

Or, perhaps better, use a padded vbox:

    outer_vbox = padded_vbox # note that "ui_" is not used here
    outer_vbox.add_hsep

I needed this functionality to quickly add horizontal separators for some
visual cue in the **User Interface**. Using **.add_hsep** is very
convenient and fast to write/type. If you want more verbosity then remember
that you can always use the upstream API as-is.

The same applies to vertical separators, but I haven't used them yet
actually. They do work, though.

For an interesting example, have a look at the following screenshot
from example **031_separator_example.rb**.

<img src="https://i.imgur.com/cXO6RF4.png" style="margin: 1em; margin-left: 3em">

What is interesting is that all the horizontal lines come from using
a hsep (horizontal separator).

The syntax is different though:

    vbox.minimal(hsep, 1)
    vbox.minimal(hsep, 0)

Carefully look at the area that surrounds the button in the middle.

The nearby area is padded, thanks to **vbox.minimal(hsep, 0)**. So
passing **0** means this is quite elegant - you add padding between
different elements. But when you pass 1 then you get this strange
big block. I am not sure if this is how it should be, but if it is
then you can sort of use that as an additional visual cue. I am 
not necessarily recommending this be done, but **if** you ever have
such a use case then you can use it - which is another reason why
I added this screenshot, so that I don't forget. :)

## Entries in LibUI (ui_entry)

The official source for an ui_entry for Unix (including Linux) can be read
here:

https://github.com/andlabs/libui/blob/master/unix/entry.c

Personally I tend to create a new entry element in this way:

    entry = ui_entry

To set new content to it, do:

    entry.set_text('foobar') # Make sure it is a String; that seems to work better.

To query the text content of such an entry, you can use the following API,
if you use the libui_paradise gem:

    entry.text?

To respond to events look at **OnChanged**.

To see an example where the user may input a password entry, have a
look at the following file:

    libui_paradise/examples/028_password_entry_example.rb

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

## LibUI::FFI::DrawTextLayoutParams.malloc

LibUI::FFI::DrawTextLayoutParams.malloc can be used to draw
coloured text.

    params = UI::FFI::DrawTextLayoutParams.malloc
    params.to_ptr.free = Fiddle::RUBY_FREE

    params.Align = 'Left' # Use left alignment here.

## Grids in LibUI

The API is quite complex and hard to remember:

    LibUI.grid_append(grid, entry1, 0, 0, 2, 1, 0, 0, 1, 0)
    LibUI.grid_append(grid, text('Yo2'), 1, 0, 1, 1, 0, 0, 1, 0) # text() can be used if you use the libui_paradise gem

Who can remember offhand what these values mean, though?

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

If you want to pad the grid you can use the following method:

    LibUI.grid_set_padded(grid, 25)

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

You can use a toplevel margined window like this:

    window = margined_window(:filename, 250, 150, 0)

:filename (as Symbol) is an 'alias' - if given then
the filename will become the title of the window at
hand. Only the raw filename will be used, so if you
have a file at **/tmp/foo/bar.rb** then the title
of the window will be **bar.rb**.

## Entry

An entry in libui may look like this:

<img src="https://raw.githubusercontent.com/parro-it/libui-node/master/docs/media/UiEntry.png" style="margin-left:1em">

Such an entry can be set to be **read only** (readOnly: Boolean, aka true or false).

The upstream C code for libui-entry, for **unix/**, can be seen here:

https://github.com/andlabs/libui/blob/master/unix/entry.c

## Borderless windows

A window that is **borderless: true** will not show any title or
outside frame. This may be useful for games and what not.

## Spinbutton / Spinbox

You can use the following API for a spinbox:

    UI.new_spinbox

To create a new spinbox.

To specify the **min** and **max** range, pass them as parameters
on creation-time:

    UI.new_spinbox(0, 100)

If you use the extensions found in the libui_paradise gem then
you can do this instead:

    ui_spinbox
    spinbox # this is the simplest variant
    spinbox(0, 100)

You can also be more explicit and use a hash such as the following
example shows:

    spinbutton = ui_spinbutton(start: 0, end: 100) # Start at 0, end at 100.

You should be able to set a new value of the spinbox via **.set_value**. Have
a look at the file at **libui_paradise/examples/rb 021_spinbutton_example.rb**
to see how this works. 

Relevant methods in regard to the spinbox in libui are as follows:

    UI.spinbox_on_changed()
    UI.spinbox_set_value()
    UI.spinbox_value() 

To **set** a value use either of the following two methods:

    spinbox.set_value(42)
    spinbox.value = 42 # this works as well

Here is a small image of how this looks:

<img src="https://i.imgur.com/FxNTRse.png" style="margin: 0.5em; margin-left: 2em">

## Create a text-view widget

A text-view widget shows content, such as the content of a local file.

In libui the general API for this is:

    UI.new_multiline_entry                      # this is a textview

## Control Gallery

Here is an image, from kotlin-libui, how this may look on windows:

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/controlgallery/controlgallery-windows7.png" style="margin-left: 2em">

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

See the example **029_two_buttons_showing_how_to_enable_and_disable_them.rb**
in how this works.

## libui and ruby-libui internals

This is an incomplete subsection. I know almost nothing at all about
C; kojix2 knows more, so I refer you to the homepage of ruby-libui
respectively.

Most of the code for ruby-libui resides under **ffi.rb**. In August 2021
this file contains almost 1000 lines, including newlines. Still quite
some code. If you want to look at the raw content, have a look at
the following link for **ffi.rb**:

https://raw.githubusercontent.com/kojix2/LibUI/main/lib/libui/ffi.rb

The two most important components there, as far as I understand it,
are **try_extern** and **structs**.

For instance:

    try_extern 'void uiOnShouldQuit(int (*f)(void *data), void *data)'

    Control = struct [

I assume that any support made available for ruby **must** have a
corresponding entry in **ffi.rb**. At the least this is how I
understood it.

If it is not in **ffi.rb** then support for that was not (yet) added.

Individual enum entries can also be seen. For instance, for font-related
data the following attributes are in use: 

    AttributeTypeFamily         = 0
    AttributeTypeSize           = 1
    AttributeTypeWeight         = 2
    AttributeTypeItalic         = 3
    AttributeTypeStretch        = 4
    AttributeTypeColor          = 5
    AttributeTypeBackground     = 6
    AttributeTypeUnderline      = 7
    AttributeTypeUnderlineColor = 8
    AttributeTypeFeatures       = 9

You can probably use the rubygems features of comparing old gem 
releases with one another to see which support has been added to
ruby-libui over the past months or so. Most work was probably done
in 2020 or even before that (there are some older ruby bindings
to libui, but these work differently as kojix2 explained).

## Limitations of/in LibUI

LibUI is not perfect - it is missing many things that should work just fine
on the main operating systems. On top of that I'd love to support specific
features on a given operating system even if it is NOT cross-platform. But
this is not possible via LibUI.

The following subsection mentions a few constraints of LibUI in varying 
degrees of complexity/importance:

- No CSS support. I miss this. On ruby-gtk3 this is possible. In LibUI I can't.
- Unable to set different fonts for an application other than using FontButton.

## Using C structs via fiddle

To use C structs you may have to allocate memory.

Example:

    font_descriptor = UI::FFI::FontDescriptor.malloc
    font_descriptor.to_ptr.free = Fiddle::RUBY_FREE

This is currently necessary. Hopefully Fiddle becomes
a bit more convenient to use in the future, so we don't
have to care about **malloc** when writing ruby anymore.

## Structure of the project

In **September 2021** the libui_paradise project was re-arranged slightly. There
is now a dedicated **libui_classes/** directory that "simulates" separate classes.
For example, libui_button now resides in **button.rb**. I use the same directory
layout in the **gtk_paradise** gem and I think it makes a lot of sense - at the
least I can quickly find the code that I may want to modify or extend. If I
want to extend buttons, then I modify **buttons.rb**. That's simple, right?

Another reason why the project was re-structured was so that we can use a
**unified DSL** for the GUI elements in the long run.

For example, code such as the following:

    _ = button
    _.on_clicked {
      puts 'Hello world!'
    }

Should work on ruby-gtk3, libui and all the other toolkits one day - even on
the www. But the different toolkits do not implement the same functionality.
Libui only offers a reduced functionality, for instance. Thus, the DSL that
we may then use **can only support a subset of functionality**, whereas other
toolkits are more useful in this regard. This was an additional reason why files
such as button.rb were created - it makes it easier to know which functionality
has to be changed in order for libui_paradise to enable such a unified
DSL approach. This currently does not yet work fine in 2021, but one day it
should work just fine.

Note that the older l**ibui_paradise gem** will be made available at the
least for three months (so until end of December 2021 at the least). It used
a different directory layout.

You may ask why the main module is called **LibuiParadise::Extensions**.
Why not modify LibUI directly? After all the gtk_paradise gem does the
same, by modifying **module Gtk** directly.

That is a good question, and the main reason for this is because I was
not sure whether I can actually get away with modifying the LibUI
namespace directly. Fiddle::Pointer still scares me, so I am experimenting.

For now I thought it best to create a separate module, that is then included
and modified - see the **included hook** that is presently used. This seems
to be simpler for the time being. I may plan to change a lot more one day,
if I ever manage to find out how to simulate proper subclasses via
Fiddle::Pointer ... :) 

--------------------------------------------------------------------------------
## SNIPPETS.md

Next, the content of the file called **SNIPPETS.md** will be shown. Note
that this file will eventually be integreated into this file, and then
subsequently removed one day.


<pre>
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

# Add the window to the main UI:

  UI.control_show(main_window)
  main_window.show_the_controls # Or use this one here.

# How to add a click-action to the button:

  UI.button_on_clicked(button) {
    UI.msg_box(main_window, 'Information', 'You clicked the button')
    0
  }

# How to exit easily:

  UI.window_on_closing(main_window) {
    UI.exit_from(main_window)
  }


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



# How to quit:

  UI.quit

# How to build a menu-interface (menu tag):

  help_menu = UI.new_menu('Help')
  version_item = UI.menu_append_item(help_menu, 'Version')

# Fonts and LibUI:

  font_descriptor = UI::FFI::FontDescriptor.malloc
  p 'Font family: '+font_descriptor.Family.to_s+
    'Font size: '+font_descriptor.Size+
    'Font weight: '+font_descriptor.Weight+
    'Font italic: '+font_descriptor.Italic+
    'Font stretch: '+font_descriptor.Stretch

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
is needlessly complicated. (This may not be completely correct, though -
the glimmer-dsl-libui has example that seem to work. But if you ask me
right now in 2021 how this works via a standalone example then I can
happily tell you I have absolutely no idea. Which brings me to the
next problem...)
- Lack of documentation. This part is REALLY annoying ...

Some more disadvantages relate to Fiddle::Pointer. You kind of need to
know C fairly well as well as the GC in ruby, in order to understand
what is going on. Since I don't, I hit a dead end, kind of.

This is so far in September 2021. Let's see what the future brings.
Perhaps other toolkits will learn from libui and implement the good
parts for **their own** widget set.

## LibuiParadise.parse_this_config_file()

This method can be used to parse a .config file. This file should
describe the main window, such as:

     width:                                      1000
     height:                                      150
     title:                 Parse Config File Example

I have been using this in gtk_paradise and I think it may be convenient
if you create lots of small windows and widgets that you don't want
to hardcode values for directly into the .rb file at hand.

To create a toplevel window from this use code such as the following:

    use_this_config_file = '023_parse_config_file_example.config'
    window = LibuiParadise.parse_this_config_file(use_this_config_file)

In fact, the example **023_parse_config_file_example.rb** shows how
this is used. The width of the main window will be 1000 and the
height only 150.

This functionality may be extended in the future. For example, we
could enable to automatically parse such a .config file if it 
exists, thus not even requiring that method call in the future.

For now, though, you have to explicitely use that method if you
want to instantiate such a window from a .config file. It will
be evaluated at a later time (past September 2021) how useful this
really is.

## Width and Height of the main window

Different computers / monitors have different display values
(their monitor).

I use a wide-screen LCD monitor, but I also have a smaller laptop,
and I want **libui** to work there just as well.

The following API can be used to set the width and height of the
main window:

    set_height()
    set_width()

You can also use something like '95%' as input. In that case the
desired value will be calculated depending on the max-resolution
of the current display. This presently only works on **linux**; if
someone knows how to make this work on windows and Mac OSX let
me know. (On these systems it will instead default to a hardcoded
value of 1024 for width and 800 for height).

The following example shows how to use a percentage value:

    set_height('80%')

## Coloured Text

At this point I only show how this may look on Win7, re-using
the picture the **kotlin-libui developers** made available:

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/drawtext/drawtext-windows7.png" style="margin-left: 2em">

Doesn't look that bad, right? May not be the prettiest GUI of all
times, but it is functional - and simple.

## DSLs for libui (in ruby)

kojix2 pointed out that glimmer has support for libui; check it out
here:

https://github.com/AndyObtiva/glimmer-dsl-libui

libui_paradise will support the same syntax (in the long run) as
glimmer does, either directly, or via a module and a way to
require it specifically. But stay tuned for this - right now as
of late 2021 this is not yet guaranteed. (If anyone needs quick
API changes, let me know and I'll change libui_paradise. Other
than that, the libui_paradise project is in a slow maintenance
mode right now, so again, stay tuned. \o/ )

## Status of the libui_paradise project

I am still, as of 2021, experimenting somewhat randomly. While I intend to
improve libui_paradise, it is a hobby project that is not as important
as, say, the gtk_paradise project (which contains custom ruby-gtk
related addons; ruby-gtk has a LOT more functionality than libui has,
just look at the CSS-related aspects).

I can not promise to work reliably on libui_paradise, but every now and
then, say every some weeks, I will try to add more code to it, in 
particular examples and documentation. However had, keep in mind that
the project is not one of my most important projects, so it may not
receive as many updates as other projects; Andy is much more active
recently via glimmer-libui-dsl, so check out his project. See also
the following subsection, the "Todo List".

## Todo List and Goals related to libui

Here I will list some todo entries and related goals for libui or the
libui_paradise gem - if anyone finds out how to solve some of these
limitations, you are welcome to share!

This list may become outdated eventually, so assume that this has been
valid at one point in time, but may no longer be absolutely "up to date"
anymore.

Here goes:

- Add more small, **standalone examples** showcasing how to use (and
combine) different functionality, in particular colourized text and use
of (embedded) images if applicable. Ideally we should be able to
combine both freely, if possible. Ideally it should be a small functionality,
to demonstrate **how** something can be done. Users can then expand from
this point for their own GUI sets.

- Find out how to create "proper" subclasses to Fiddle::Pointer, simulating
a subclass to it.

- Find out how halign and valign work in Libui-Grid. Somehow I can not easily reposition it ...
or perhaps I have been able to, and just have not noticed this (may have to embed one
widget in another widget in order for this to come into effect)

- Find out how to do ad-hoc calls on linux to gtk, so that we can use CSS.
Perhaps some extension mechanism could be used, similar to how ffi works
in general. Unfortunately this probably requires knowledge of C, so this
is an obstacle for me. I should have learned C before ruby ... :P

- Get more people to learn about libui and use them in their projects,
in particular for simple applications. I think this is the most important
goal: we need more people to learn about libui and begin to use it. 
Contribute to upstream as well. If we have a sufficiently large user
base then it should be easier to add new possibilities onto libui,
which in turn will "cascade" downwards to all the other bindings 
to libui, be it in kotlin, python, ruby and so forth.

## DateTime Widget

Let's start with an image to show how the date-time picker may look
on windows:

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/datetime/datetime-windows7.png" style="margin-left: 2em">

Here is another image, from Win10:

<img src="https://i.imgur.com/Vkn4Vmg.jpg" style="margin: 1em; margin-left: 2em">

The basic API is this:

    LibUI.date_time_picker_time

Or rather:

    date_time_picker = LibUI.new_date_time_picker
    time = LibUI::FFI::TM.malloc
    LibUI.date_time_picker_on_changed(date_time_picker) {
      LibUI.date_time_picker_time(date_time_picker, time)
    }

Modify this to suit your needs as-is.

I tested this in **February 2022** on Linux. The next screenshot
shows how this may look (on icewm):

<img src="https://i.imgur.com/Jdbf6Jc.png" style="margin: 1em">

## radio-buttons in LibUI

The syntax goes something like this:

    rb = ui_radio_buttons
    UI.radio_buttons_append(rb, 'Radio Button 1')
    UI.radio_buttons_append(rb, 'Radio Button 2')
    UI.radio_buttons_append(rb, 'Radio Button 3')
    outer_vbox.minimal(rb) # add the radio-button control to the box.

In other words: you instantiate a new rb-radio-button 'pointer';
and then you simply append the options onto it. The String above
will be the option at hand, e. g. 'Radio Button 1'.

As I am very lazy I don't want this boilerplate code, so the following
variant exists instead:

    rb = ui_radio_buttons( ['Radio Button 1','Radio Button 2','Radio Button 3'] )
    outer_vbox.minimal(rb) # add the radio-button control to the box.

So you can simply pass in an Array. This cuts down the number of
lines necessary. \o/

Here is a screenshot to show how this looks (from
example **032_radio_button_example.rb**).

<img src="https://i.imgur.com/aJOBQzn.png" style="margin-left: 2em">

## Password entries in LibUI

If you use the libui_paradise gem then you can create a new password entry
in using any of the following variants:

    entry = ui_password_entry
    entry = password_entry

For "raw" libui, use this:

    LibUI.new_password_entry

## Progress Bars in LibUI

Here an image how this may look:

<img src="https://i.imgur.com/i1i4ppZ.png" style="margin-left: 2em">

## Tables in LibUI

You may be able to create a new table via:

    table = LibUI.new_table
    
    model = LibUI.new_table_model(model_handler)

    table_params = LibUI::FFI::TableParams.malloc
    table_params = Fiddle::RUBY_FREE
    table_params.Model = model
    table_params.RowBackgroundColorModelColumn = -1
    table = LibUI.new_table(table_params)

The table header is an array that contains the following attributes:

    1. editable, bool type, the column is whether editable
    2. textColor
    3. title
    4. type, specify value of button, image, imgtext, progress, checkbox, checkboxtext, color, text

Note that this is incomplete; it's a bit complicated.

In the end, this is possible though:

<img src="https://raw.githubusercontent.com/msink/kotlin-libui/master/samples/table/table-windows7.png" style="margin-left: 2em">

## Form example in LibuiParadise

Inspired by **glimmer-libui**, I ported the form example, into
**027_form_example.rb**. Unfortunately it does not look 
as good as it does in **glimmer-libui**, and the code I use for
it is too verbose right now.

Still, if you are curious, this is how it looks on icewm
in October 2021:

<img src="https://i.imgur.com/FkU6aWd.png" style="margin-left: 2em">

I may improve this eventually a bit, so that the alignment looks
as good as it does on glimmer-dsl; the code of 27_form_example.rb
may also be cleaned up in the future (the glimmer-libui code 
looks better). But for now this is how it is; Andy is very
actively improving **glimmer-libui** right now.

## Available widgets in libUI:

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

Available "**new**"-widgets in LibUI:

    LibUI.new_area
    LibUI.new_attributed_string
    LibUI.new_group
    LibUI.new_spinbox
    LibUI.new_stretch_attribute
    LibUI.new_background_attribute
    LibUI.new_button                               # this is a simple button
    LibUI.new_checkbox                             # this is a simple checkbox
    LibUI.new_color_attribute
    LibUI.new_color_button
    LibUI.new_combobox                             # this is a combobox
    LibUI.new_date_picker
    LibUI.new_date_time_picker
    LibUI.new_editable_combobox
    LibUI.new_grid
    LibUI.new_horizontal_box
    LibUI.new_horizontal_separator                 # this is a simple horizontal separator
    LibUI.new_image                                # this is a simple image
    LibUI.new_italic_attribute                     # this is basically italic font-style
    LibUI.new_label
    LibUI.new_tab
    LibUI.new_table                                # this is a simple table
    LibUI.new_table_model
    LibUI.new_table_value_image
    LibUI.new_table_value_int
    LibUI.new_table_value_color
    LibUI.new_table_value_string
    LibUI.new_time_picker
    LibUI.new_menu
    LibUI.new_multiline_entry                      # this is a textview
    LibUI.new_non_wrapping_multiline_entry
    LibUI.new_open_type_features
    LibUI.new_password_entry
    LibUI.new_underline_attribute
    LibUI.new_entry
    LibUI.new_progress_bar                         # this is a progress_bar
    LibUI.new_underline_color_attribute
    LibUI.new_family_attribute
    LibUI.new_radio_buttons                        # this is for the radio button
    LibUI.new_vertical_box
    LibUI.new_features_attribute
    LibUI.new_scrolling_area                       # this is a scrolling area
    LibUI.new_vertical_separator
    LibUI.new_font_button
    LibUI.new_weight_attribute
    LibUI.new_form                                 # this is a form
    LibUI.new_size_attribute
    LibUI.new_window
    LibUI.new_slider                               # this is a slider

## A search entry in LibUI

The API is:

    LibUI.new_search_entry # this is a search entry

How does this look? The following image shows this:

<img src="https://i.imgur.com/AueDc7l.png" style="margin: 1em">

## Creating a new image in LibUI:

Use the following API for this:

    image = LibUI.new_image(width, height)

## Horizontal boxes

A HBox represents a horizontal box. The API for putting 
something into a hbox goes as follows, such as when you
wish to put a text-entry into the hbox:

    LibUI.box_append(hbox1, text_entry, 1)

## The slider widget

If you use the LibuiParadise gem then you can create and use a new slider
like this:

    slider = ui_slider

    # define our callback
    slider_changed_callback = proc { |ptr|
      puts "New Slider value: #{UI.slider_value(ptr)}"
      0
    }
    UI.slider_on_changed(slider, slider_changed_callback) # last element is nil, but it seems we can omit it

This may look like so on Linux:

<img src="https://i.imgur.com/GVKPMS7.png" style="margin-left: 3em">

## Create a new tabbed notebook:

   ui_tabs
   ui_notebook

## Creating a textview in LibUI:

    LibUI.new_non_wrapping_multiline_entry

If you want to make it read only then you can use an API like this:

    LibUI.multiline_entry_set_read_only(text, 1)

## Coloured box examples

Since as of November 2021 you can use the libui_paradise gem to
create coloured boxes:

<img src="https://i.imgur.com/Ervg3vF.png" style="margin: 0.5em; margin-left: 2em">

The API for this goes like so:

    LibuiParadise.draw_rectangle
    LibuiParadise.draw_rectangle(50, 50, :steelblue) # width, height, html-colour to use

## Attributed Strings in LibUI

An **AttributedString** is a string that contains information
about specific styles, such as text color, font, font size. It can be
drawn in a **UiArea element**.

Various ways to style such an attributed String is possible.

For instance, the text-weight part accepts these values

    minimum
    thin
    ultraLight
    light
    book
    normal
    medium
    semiBold
    bold
    ultraBold
    heavy
    ultraHeavy
    maximum
    # or  any number between minimum and maximum

To create an attributed String you can use the following API:

    string = LibUI.new_attributed_string
    attributes = LibUI.new_family_attribute("Courier New 30") # Specify a certain font.
    attribute = LibUI.new_color_attribute(0.75, 0.25, 0.5, 0.75) # And a certain colour.
    LibUI.append_with_attribute("text color", attribute, nil)

## How to run the main loop in libui

    LibUI.main

## Examples distributed in the libui_paradise gem

In February 2022 the examples directory was re-arranged. There are now two
different directories, called simple/ and complex/.

Files in the simple/ directory may only use code that is made available
via kojix2' libui bindings.

Files in the complex/ directory may tap into code made available by the
libui_paradise gem.

This re-arrangement was done because some of the old examples were no
longer working, and it was messy to try to find out whether there was
a bug in the libui bindings, or whether I messed up. That way I can 
now focus on the complex/ examples to showcase what libui_paradise
can do, whereas the simple/ directory will show how you can work with
"vanilla" libui in general.

## Setting the title, width and height of a widget

The libui_paradise gem comes with methods such as
.set_title(), .set_width() and .set_height().

This is a bit cumbersome to use as you need at the least
three lines of code normally, as well as the constants.
So the following compound method was added in February
of 2022:

    title_width_height()

Now you can define title, width and height of your main
window via one method call. \o/

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

This is andlabs' documentation for libui, from the point of view of
**Go**. It is probably the biggest, most complete documentation for
libui. While it is specific to Go, as it was written by the same
author you can expect the documentation to be quite decent.

(Note that some other bindings contain good documentation too,
such as kotlin libui bindings and others.)

(3) http://api.call-cc.org/4/doc/libui

Similar to the first one, but uses a different layout, which
may be helpful.


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

