#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

jazzy --objc \
      --module 'JSQMessagesViewController' \
      --framework-root . \
      --umbrella-header JSQMessagesViewController/Controllers/JSQMessagesViewController.h \
      --readme README.md \
      --author 'Jesse Squires' \
      --author_url 'https://twitter.com/jesse_squires' \
      --github_url 'https://github.com/jessesquires/JSQMessagesViewController' \
      --output docs/ \
