#!/bin/bash

# assist: fix spotify if it freezes

pkill spotify
sleep 2
pgrep spotify && pkill spotify
