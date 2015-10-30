#!/usr/bin/env bash

MHOST=$(hostname -s) docker-compose up -d && docker tag monitdocker_monit ai81/monit-docker:latest
