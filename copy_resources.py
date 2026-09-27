#!/usr/bin/env python3
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
"""Copia le risorse UI/CSS nella build dir.

Uso: copy_resources.py <script> <input...> <src_dir> <build_dir> <stamp>

Gli ultimi tre argomenti sono src_dir, build_dir e il file di stamp.
"""
import os
import shutil
import sys

argv = sys.argv[1:]
src_dir, build_dir, stamp = argv[-3], argv[-2], argv[-1]

CSS = [
    'gnome-clocks.css',
    'gnome-clocks.dark.css',
    'gnome-clocks.highcontrast.css',
]

UI = [
    'shortcuts-dialog.ui',
    'alarm-day-picker-row.ui',
    'alarm-face.ui',
    'alarm-ringing-panel.ui',
    'alarm-row.ui',
    'alarm-setup-dialog.ui',
    'header-bar.ui',
    'local-clock-face.ui',
    'sound-chooser.ui',
    'sound-chooser-row.ui',
    'stopwatch-face.ui',
    'stopwatch-laps-row.ui',
    'timer-face.ui',
    'timer-row.ui',
    'timer-setup-dialog.ui',
    'timer-setup.ui',
    'window.ui',
    'world-face.ui',
    'world-location-dialog.ui',
    'world-location-dialog-row.ui',
    'world-row.ui',
    'world-standalone.ui',
]

os.makedirs(os.path.join(build_dir, 'css'), exist_ok=True)
os.makedirs(os.path.join(build_dir, 'ui'), exist_ok=True)

for name in CSS:
    src = os.path.join(src_dir, 'css', name)
    if os.path.isfile(src):
        shutil.copy2(src, os.path.join(build_dir, 'css', name))

for name in UI:
    src = os.path.join(src_dir, 'ui', name)
    if os.path.isfile(src):
        shutil.copy2(src, os.path.join(build_dir, 'ui', name))

with open(stamp, 'w') as fp:
    fp.write('ok\n')
