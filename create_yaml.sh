#!/bin/bash

input="hostgroups"
while IFS= read -r line
do
    qconf -shgrp $line > $line.hgrp

done < "$input"
