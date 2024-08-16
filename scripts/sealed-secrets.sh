#!/bin/bash
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm install sealed-secrets-cluster sealed-secrets/sealed-secrets
