/*
 * Copyright (C) 2026 Simone
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

namespace Clocks {

[GtkTemplate (ui = "/com/simonecompany/simonorologio/ui/local-clock-face.ui")]
public class LocalClockFace : Adw.Bin, Clocks.Clock {
    public PanelId panel_id { get { return CLOCK; } }
    public ButtonMode button_mode { get; set; default = NONE; }
    public string? new_label { get { return null; } }

    [GtkChild]
    private unowned Gtk.Label time_label;

    [GtkChild]
    private unowned Gtk.Label date_label;

    [GtkChild]
    private unowned Gtk.Label day_label;

    construct {
        // Start the clock update loop
        Utils.WallClock.get_default ().tick.connect (() => {
            update_time ();
        });

        update_time ();
    }

    private void update_time () {
        var now = new GLib.DateTime.now_local ();

        // Format time as HH:MM:SS
        var time_str = now.format ("%H:%M:%S");
        time_label.label = time_str;

        // Format date as "sabato 26 settembre 2026"
        var date_str = now.format ("%A %d %B %Y");
        date_label.label = date_str;

        // Day of week only (for smaller label)
        var day_str = now.format ("%A");
        day_label.label = day_str;
    }
}

} // namespace Clocks