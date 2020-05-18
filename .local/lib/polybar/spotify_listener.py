#!/usr/bin/env python3

import dbus
import dbus.service
import time

from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
from os import system

CACHED_STATE = { 'mpris:trackid': None, 'PlaybackStatus': None }

def polybar_msg(module, hook, sleep_time=0.02):
    system("polybar-msg hook {} {}".format(module, hook))
    time.sleep(sleep_time)

def update_polybar():
    if CACHED_STATE['PlaybackStatus'] == 'Paused':
        polybar_msg("playpause", 2)
    if CACHED_STATE['PlaybackStatus'] == 'Playing':
        polybar_msg("playpause", 3)
    polybar_msg("spotify", 1)
    polybar_msg("previous", 3)
    polybar_msg("next", 3)

def properties_changed_handler(*args):
    data = unwrap(args)
    try:
        trackid = data[1]['Metadata']['mpris:trackid']
        PlaybackStatus = data[1]['PlaybackStatus']
        if trackid.startswith('spotify'):
            if CACHED_STATE['mpris:trackid'] != trackid:
                CACHED_STATE['mpris:trackid'] = trackid
                print("Spotify track change.")
                print(CACHED_STATE)
                update_polybar()
            elif CACHED_STATE['PlaybackStatus'] != PlaybackStatus:
                CACHED_STATE['PlaybackStatus'] = PlaybackStatus
                print("Spotify play/pause toggle.")
                print(CACHED_STATE)
                update_polybar()
    except (KeyError, IndexError):
        pass

def spotify_quit_handler(*args):
    data = unwrap(args)
    try:
        if data[0] == 'org.mpris.MediaPlayer2.spotify' and system('[ ! -z "$(pgrep spotify)" ]'):
            print(data)
            print("Spotify quitting...")
            polybar_msg("playpause", 4)
            polybar_msg("previous", 2)
            polybar_msg("next", 2)
            polybar_msg("spotify", 2)
    except KeyError:
        pass

def unwrap(val):
    if isinstance(val, dbus.ByteArray):
        return "".join([str(x) for x in val])
    if isinstance(val, (dbus.Array, list, tuple)):
        return [unwrap(x) for x in val]
    if isinstance(val, (dbus.Dictionary, dict)):
        return dict([(unwrap(x), unwrap(y)) for x, y in val.items()])
    if isinstance(val, (dbus.Signature, dbus.String)):
        return str(val)
    if isinstance(val, dbus.Boolean):
        return bool(val)
    if isinstance(val, (dbus.Int16, dbus.UInt16, dbus.Int32, dbus.UInt32, dbus.Int64, dbus.UInt64)):
        return int(val)
    if isinstance(val, dbus.Byte):
        return bytes([int(val)])
    return val

def main():
    DBusGMainLoop(set_as_default=True)
    bus = dbus.SessionBus()
    loop = GLib.MainLoop()
    bus.add_signal_receiver(properties_changed_handler,
                            path='/org/mpris/MediaPlayer2',
                            dbus_interface='org.freedesktop.DBus.Properties',
                            )
    bus.add_signal_receiver(spotify_quit_handler,
                            path='/org/freedesktop/DBus',
                            dbus_interface='org.freedesktop.DBus',
                            )
    try:
        loop.run()
    except (KeyboardInterrupt, SystemExit):
        loop.quit()

if __name__ == '__main__':
    main()
