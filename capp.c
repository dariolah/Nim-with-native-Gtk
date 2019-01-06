#include "capp.h"

void gtkinit()
{
    GtkWidget *window;
    GtkBuilder *builder;
	
    int argc = 0;
    char **argv = NULL;
    gtk_init(&argc, &argv);

    builder = gtk_builder_new();

    //builder object from embedded resources
    gtk_builder_add_from_file (builder, "./gui.glade", NULL);
	
    window = GTK_WIDGET(gtk_builder_get_object(builder, "main_window"));
    gtk_builder_connect_signals(builder, NULL);

    lbl_method1 = GTK_WIDGET(gtk_builder_get_object(builder, "lbl_method1"));
    lbl_method2 = GTK_WIDGET(gtk_builder_get_object(builder, "lbl_method2"));
    lbl_method3 = GTK_WIDGET(gtk_builder_get_object(builder, "lbl_method3"));

    g_object_unref(builder);

    gtk_widget_show(window);
    gtk_main();
}

void lbl_method1_set_text(const gchar *str)
{
    gtk_label_set_text(GTK_LABEL(lbl_method1), str);
}

void on_main_window_destroy()
{
    gtk_main_quit();
}
