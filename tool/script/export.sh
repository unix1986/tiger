#!/bin/sh
TOOL_DIR=$(dirname `readlink -f $0`)
PATH="\
$TOOL_DIR/astyle:\
$TOOL_DIR/protobuf:\
$PATH" sh
