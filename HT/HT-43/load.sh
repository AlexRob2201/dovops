#!/bin/bash

while true; do
    curl http://bukhenko-ht-43-1334211709.eu-central-1.elb.amazonaws.com/api/test
    sleep $1
done

