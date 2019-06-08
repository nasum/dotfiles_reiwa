#!/bin/bash
docker build -t dotfiles .
docker run -v $(pwd):/workdir -it dotfiles