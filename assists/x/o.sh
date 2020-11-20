#!/bin/bash

# assist: make window opaque

if ! command -v transset
then
    instantinstall xorg-transset
fi

transset 1
