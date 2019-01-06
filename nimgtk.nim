{. passL:"-rdynamic" passL:"libcapp.a".}
{. passL:gorge("pkg-config gtk+-3.0 --libs").}
{. passC:gorge("pkg-config gtk+-3.0 --cflags").}
{. passC:"-I.".}

{.emit: """/*INCLUDESECTION*/
#include "capp.h"
"""
.}

#//TODO https://stackoverflow.com/questions/28855850/gtk-c-and-gtkbuilder-to-make-a-single-executable

proc gtkinit: void {.importc.}

#interop method1: import function from capp
proc lbl_method1_set_text(text:cstring) {.importc.}

#interop option 2: import Gtk function, and global vars from capp
proc gtk_label_set_text(gtklabel: pointer, str:cstring) {.importc, header:"gtk/gtk.h".}
var lbl_method2 {.importc, header: "\"capp.h\""}: pointer

#callback function, registered with gtk/button on_click action in glade
proc on_btn1_clicked*(): void {.exportc.} =
  var str_count: cstring
  var msg:cstring = "called function in capp to set gtk label text"

  #method 1: call function in capp to set gtk label text
  lbl_method1_set_text(msg)

  #method 2: call imported Gtk function to set gtk label text
  msg = "called imported Gtk function to set gtk label text"
  gtk_label_set_text(lbl_method2, msg)

  #method 3: emit C code to set gtk label text
  msg = "emited C code to set gtk label text"
  {.emit: ["gtk_label_set_text(GTK_LABEL(lbl_method3), ", msg, ");"].}

when isMainModule:
  gtkinit() 
