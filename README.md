# Lovely Imgui

LovelyImgui is a WIP immediate-mode gui written in pure Lua. It attempts to be **simple**, **stupid** and **highly customizable**!

Currently it doesn't support that many widgets but in the future (perhaps with support of contributors) it'll support many essential widgets and features! This limitation doesn't mean it's not fit for development - infact a `complete project
<http://github.com/YoungNeer/brief>`_ has been made with this GUI!!

The following screenshot can perhaps give you an idea of the number and type of widgets LI currently supports!

<p align="center">
<a href="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/main.png"><img width=530 height=400 src="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/main.png"/></a><br>
  <span style="align:center">A demo of LovelyImgui</span>
</p>


Here's a snippet showing a basic imgui created with Lovely-Imgui::

```lua
imgui = require 'imgui'

function love.draw()
  if imgui.button('Hello world') then
    imgui.label('You are clicking on the button!!')
  end
  imgui.draw()
end
```

## Features of LovelyImgui

- **Bloat-Free**: Unlike Slab and SUIT, LI doesn't create a whole *lot* of tables or garbage! This gives LI a significant performance boost compared to forementioned libraries!
- **Completely Customizable**: You can change the colors or change the whole theme! Themes in LI are more like LAF in Java in the sense that themes not just define the look but also the "behaviour" - a feature you can exploit to make tweening possible in your theme!
- **Simple and Comfortable Layout System**: While still in progress, LI's layout system is based on rows and is very easy to understand! Ofcourse it comes with several limitations but for the simplest GUI the layout system can be very helpful!
- **Responsiveness**: Instead of talking, I guess I'll show you some GIFs:-
<p align="center">
<a href="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive3.gif"><img width=215 height=200 src="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive3.gif"/></a>
<a href="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive1.gif"><img width=215 height=200 src="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive1.gif"/></a>
<a href="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive2.gif"><img width=215 height=200 src="https://raw.githubusercontent.com/YoungNeer/lovely-imgui/examples/Screenshots/responsive2.gif"/></a>
<br>

## Documentation

Documentation will be live very soon once the alpha version is released!

## Contribution

Making a GUI is easy! Making a reusable GUI is hard and by hard I mean *really hard*! There's currently a lot of stuff that I can't figure out (such as menu-bars, combo-boxes, windows, etc) so definitely I need some help. (And by help I mean "contribution" just so you don't get the wrong idea :laughing:)

</p>
