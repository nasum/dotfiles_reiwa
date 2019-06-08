#!/bin/bash
docker build -t dotfiles .
docker run -v $(pwd):/root -it dotfiles zsh