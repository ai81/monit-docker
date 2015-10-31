#!/usr/bin/env bash

MHOST=$(hostname -s) docker-compose build && docker tag -f monitdocker_monit ai81/monit-docker:latest
