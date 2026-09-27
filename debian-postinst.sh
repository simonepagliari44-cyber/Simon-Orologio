#!/bin/sh
#
# Copyright (C) 2026 Simone
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
set -e

# Compila gli schema GSettings
if command -v glib-compile-schemas >/dev/null 2>&1; then
    glib-compile-schemas /usr/share/glib-2.0/schemas || true
fi

# Aggiorna la cache delle icone
if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -q -t -f /usr/share/icons/hicolor || true
fi

# Aggiorna il database delle applicazioni
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database -q /usr/share/applications || true
fi

# Ricarica la configurazione di D-Bus per registrare il nuovo servizio,
# necessario perche l'avvio dall'icona (DBusActivatable=true) funzioni.
if command -v dbus-send >/dev/null 2>&1; then
    dbus-send --system --dest=org.freedesktop.DBus --type=method_call \
        --print-reply / org.freedesktop.DBus.ReloadConfig >/dev/null 2>&1 || true
fi

exit 0
