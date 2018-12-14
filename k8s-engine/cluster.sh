#!/bin/bash

gcloud container clusters create test-vcluster \
      --zone europe-west1-b \
      --num-nodes 1 \
      --cluster-version 1.11 \
      --disk-size 100 \
      --machine-type n1-standard-8