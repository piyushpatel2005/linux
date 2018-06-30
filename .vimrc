# This is for configuring vim editor
set showmode
set nohlsearch
set autoindent
set tabstop=4
set expandtab
syntax on
abbr _sh #!/bin/bash
abbr _pl #!/usr/bin/perl
abbr _if if [ -z $1 ]; then<CR>echo "> $0 <name><CR>exit 2<CR>fi