#!/bin/bash

pwd
echo "-------------------------------"
# cargo run
cargo build && sudo ./target/debug/mc_mitm
echo "-------------------------------"
bash
