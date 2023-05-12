# otel-config-buildpack

## Redaction

To redact query parameters, add an environment variable names `LOVES_OTEL_REDACTED_QUERY_PARAMS`.

```sh
heroku config:set LOVES_OTEL_REDACTED_QUERY_PARAMS=apiSecretKey,clientSecret
```
