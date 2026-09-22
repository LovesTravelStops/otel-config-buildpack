#!/usr/bin/env bash

export SPLUNK_REALM=${SPLUNK_REALM:-us1}
export SPLUNK_INGEST_URL=${SPLUNK_INGEST_URL:-https://ingest.${SPLUNK_REALM}.observability.splunkcloud.com}
export SPLUNK_API_URL=${SPLUNK_API_URL:-https://api.${SPLUNK_REALM}.observability.splunkcloud.com}
export SPLUNK_CONFIG=${SPLUNK_CONFIG:-$HOME/.splunk/config_without_sa.json}

echo "SPLUNK_REALM set to $SPLUNK_REALM"
echo "SPLUNK_INGEST_URL set to $SPLUNK_INGEST_URL"
echo "SPLUNK_API_URL set to $SPLUNK_API_URL"
echo "SPLUNK_CONFIG set to $SPLUNK_CONFIG"

if [[ -n $LOVES_OTEL_REDACTED_QUERY_PARAMS ]]
then
  $HOME/.heroku/node/bin/node $HOME/.profile.d/setup-query-param-redaction.mjs
fi

export HOSTNAME=${HOSTNAME:-$(hostname)}
echo "HOSTNAME set to $HOSTNAME"
