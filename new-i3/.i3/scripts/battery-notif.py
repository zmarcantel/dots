#!/usr/bin/env python

import os
import re
import time
import subprocess

def get_acpi_battery():
    acpi_out = subprocess.Popen(
        ['acpi', '-b'],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        ).communicate()[0].strip()
    lines = acpi_out.splitlines()
    # find the first battery line with a known state
    for l in lines:
        if "Unknown" in l:
            continue
        return l.split(" ")
    raise ValueError("no batteries found")


class BatteryState():
    def __init__(self, update=True):
        if update:
            self.update()

    def __str__(self):
        return "{charge}: {level} {rem}".format(
            charge="charging" if self.charging else "unplugged",
            level=self.level,
            rem=self.remaining,
            )

    def update(self):
        try:
            line = get_acpi_battery()
            self.charging = "Charging" in line[2]
            self.level = line[3].rstrip('%,')
            self.remaining = line[4]
        except ValueError as e:
            print(" FAILED TO GET BATTERY INFO: " + e)

    def write(self, path):
        chrg_str = "charging" if self.charging else "discharging"
        with open(path, "w") as f:
            f.write(str(self.level) + "\n")
            f.write(chrg_str+ "\n")

    def string(self):
        return "{charge}{level}% - {rem}".format(
            charge="charging: " if self.charging else "",
            level=self.level,
            rem=self.remaining,
            )

def read_stored_state(path):
    with open(path, "r") as f:
        state = BatteryState(update=False)
        state.level = int(f.readline().strip())
        state.charging = f.readline().strip() == "charging"
        return state


def send_low_battery(state):
    print("sending low battery notif")
    msg = "Low Battery: {level}% - {rem} remaining".format(
        level=state.level,
        rem=state.remaining,
        )
    subprocess.Popen(['notify-send', msg, "-u", "critical"]).communicate()

def send_crit_battery(state):
    print("sending critical battery notif")
    msg = "Critical Battery: {level}% - {rem} remaining".format(
        level=state.level,
        rem=state.remaining,
        )
    subprocess.Popen(
        ['notify-send', msg, "-u", "critical"]).communicate()

def send_plug_status_change(state):
    print("sending battery plug status notif: {state}".format(state=state.string()))
    msg = "Charging: computer is plugged in"
    if not state.charging:
        msg = "Power Unplugged: {rem} remaining".format(
            rem=state.remaining)
    subprocess.Popen(
        ['notify-send', msg, "-u", "low"]).communicate()

UPDATE_INTERVAL = 2
BATTERY_STATE_FILE = "/tmp/.battery"

# write state file if not exists
if not os.path.exists(BATTERY_STATE_FILE):
    state = BatteryState()
    state.write(BATTERY_STATE_FILE)

old_state = read_stored_state(BATTERY_STATE_FILE)
while True:
    time.sleep(UPDATE_INTERVAL)
    state = BatteryState()
    state.write(BATTERY_STATE_FILE)

    if state.charging and old_state.charging:
        old_state = state
        continue

    if state.level <= 5:
        send_crit_battery(state)
    elif state.level <= 15:
        send_low_battery(state)

    if state.charging != old_state.charging:
        send_plug_status_change(state)

    old_state = state
