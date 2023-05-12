#!/usr/bin/env bash

if [[ -n $LOVES_OTEL_REDACTED_QUERY_PARAMS ]]
then
  node setup-query-param-redaction.mjs
fi
