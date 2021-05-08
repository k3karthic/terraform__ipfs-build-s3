#!/usr/bin/env bash

terraform plan -var-file=ipfs.tfvars --out=tf.plan $@
