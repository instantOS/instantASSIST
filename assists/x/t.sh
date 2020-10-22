#!/bin/bash

# assist: make window partially transparent

if ! command -v transset
then
    instantinstall xorg-transset
fi

transset 0.75
