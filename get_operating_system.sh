#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "arch_linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macos"
fi
