resource_deps = []

# Le risorse UI/CSS vivono nel sorgente ma gnome.compile_resources usa
# source_dir = build dir (perche' i suoni .oga sono generati durante la build).
# Le copiamo quindi nella build dir come dipendenza vera e propria, cosi' le
# modifiche ai file .ui/.css vengono rilevate da ninja.
copy_script = files('..' / 'copy_resources.py')
copy_inputs = files(
  'css/gnome-clocks.css',
  'css/gnome-clocks.dark.css',
  'css/gnome-clocks.highcontrast.css',
  'ui/shortcuts-dialog.ui',
  'ui/alarm-day-picker-row.ui',
  'ui/alarm-face.ui',
  'ui/alarm-ringing-panel.ui',
  'ui/alarm-row.ui',
  'ui/alarm-setup-dialog.ui',
  'ui/header-bar.ui',
  'ui/local-clock-face.ui',
  'ui/sound-chooser.ui',
  'ui/sound-chooser-row.ui',
  'ui/stopwatch-face.ui',
  'ui/stopwatch-laps-row.ui',
  'ui/timer-face.ui',
  'ui/timer-row.ui',
  'ui/timer-setup-dialog.ui',
  'ui/timer-setup.ui',
  'ui/window.ui',
  'ui/world-face.ui',
  'ui/world-location-dialog.ui',
  'ui/world-location-dialog-row.ui',
  'ui/world-row.ui',
  'ui/world-standalone.ui',
)

resource_deps += custom_target(
  'copy-resources',
  input: copy_script + copy_inputs,
  output: 'resources.stamp',
  command: [
    find_program('python3'),
    copy_script[0],
    '@INPUT@',
    meson.current_source_dir(),
    meson.project_build_root(),
    '@OUTPUT@',
  ],
  build_by_default: true,
)

subdir('sounds')

# Install icons
scalable_iconsdir = join_paths('icons', 'hicolor', 'scalable', 'apps')
install_data(
  join_paths(scalable_iconsdir, '@0@.svg'.format(app_id)),
  install_dir: join_paths(get_option('datadir'), scalable_iconsdir),
)

symbolic_iconsdir = join_paths('icons', 'hicolor', 'symbolic', 'apps')
install_data(
  join_paths(symbolic_iconsdir, '@0@-symbolic.svg'.format(app_id)),
  install_dir: join_paths(get_option('datadir'), symbolic_iconsdir),
)

# Icona PNG per i gestori di pacchetti (GNOME Software, gdebi, ecc.)
install_data(
  '@0@.png'.format(app_id),
  install_dir: join_paths(get_option('datadir'), 'pixmaps'),
)

resource_files = files('simon-orologio.gresource.xml')
resources = gnome.compile_resources('com.simonecompany.simonorologio', resource_files,
  c_name: 'resources',
  dependencies: resource_deps,
  source_dir: meson.project_build_root(),
)

desktop_conf = configuration_data()
desktop_conf.set('icon', app_id)
desktop_file = i18n.merge_file(
  type: 'desktop',
  input: configure_file(
    input: 'com.simonecompany.simonorologio.desktop.in.in',
    output: '@BASENAME@',
    configuration: desktop_conf
  ),
  output: '@0@.desktop'.format(app_id),
  po_dir: podir,
  install: true,
  install_dir: get_option('datadir') / 'applications',
)

# Validate Desktop file
desktop_file_validate = find_program('desktop-file-validate', required: false)
if desktop_file_validate.found()
  test(
    'validate-desktop',
    desktop_file_validate,
    args: [
      desktop_file.full_path()
    ]
  )
endif


dbusconf = configuration_data()
dbusconf.set('bindir', get_option('prefix') / get_option('bindir'))
dbusconf.set('name', app_id)
configure_file(
  input: 'com.simonecompany.simonorologio.service.in',
  output: '@0@.service'.format(app_id),
  configuration: dbusconf,
  install: true,
  install_dir: get_option('datadir') / 'dbus-1' / 'services',
)

metainfo_conf = configuration_data()
metainfo_conf.set('appid', app_id)
metainfo_file = i18n.merge_file (
  input: configure_file(
    input: 'com.simonecompany.simonorologio.metainfo.xml.in.in',
    output: '@BASENAME@',
    configuration: metainfo_conf
  ),
  output: '@0@.metainfo.xml'.format(app_id),
  po_dir: podir,
  install: true,
  install_dir: get_option('datadir') / 'metainfo',
)

# Validate metainfo
appstreamcli = find_program('appstreamcli', required: false)
if appstreamcli.found()
  test(
    'validate-metainfo', appstreamcli,
    args: [
      'validate', '--no-net', '--explain', metainfo_file.full_path()
    ]
  )
endif

search_conf = configuration_data()
search_conf.set('appid', app_id)
search_conf.set('profile', profile)
configure_file(
  input: 'com.simonecompany.simonorologio.search-provider.ini.in',
  output: '@0@.search-provider.ini'.format(app_id),
  configuration: search_conf,
  install: true,
  install_dir: get_option('datadir') / 'gnome-shell' / 'search-providers',
)

gsettingsconf = configuration_data()
gsettingsconf.set('GETTEXT_PACKAGE', meson.project_name())
configure_file(
  input: 'com.simonecompany.simonorologio.gschema.xml.in',
  output: '@BASENAME@',
  configuration: gsettingsconf,
  install: true,
  install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
)

glib_compile_schemas = find_program('glib-compile-schemas', required: false)
# Validate GSchema
if glib_compile_schemas.found()
  test(
    'validate-gschema', glib_compile_schemas,
    args: [
      '--strict', '--dry-run', meson.current_source_dir()
    ]
  )
endif
