#!/usr/bin/env bash

export SPLUNK_REALM=${SPLUNK_REALM:-us1}
export SPLUNK_CONFIG=${SPLUNK_CONFIG:-$HOME/.splunk/config_without_sa.json}

echo "SPLUNK_REALM set to $SPLUNK_REALM"
echo "SPLUNK_CONFIG set to $SPLUNK_CONFIG"
