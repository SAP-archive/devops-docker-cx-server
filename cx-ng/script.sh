#!/bin/bash

dir=$(mktemp -d)
cd $dir
git clone -b piper-action https://github.com/SAP/cloud-s4-sdk-book repo
cd repo
/opt/act/act
