#!/bin/python3.9

import subprocess
import argparse

addrs = subprocess.Popen(["dbus-launch"]).stdout;

print(addrs)

parser = argparse.ArgumentParser();

parser.add_argument("addrs",action=)
