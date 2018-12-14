#!/bin/bash

gcloud dns managed-zones list
gcloud dns dns-keys list --zone=$1