import { readFile, writeFile } from "node:fs/promises";

const commaSeparatedParams = process.env.LOVES_OTEL_REDACTED_QUERY_PARAMS;
const configPath = process.env.SPLUNK_CONFIG;

if (!commaSeparatedParams) {
  console.log("No params found");
  process.exit(0);
}

if (!configPath) {
  console.log("No config path specified");
  process.exit(0);
}

const paramList = commaSeparatedParams.split(",");
const paramGroup = paramList.join("|");

console.log(
  "Patching config to redact specified query params",
  paramList.join(", ")
);

const config = JSON.parse((await readFile(configPath)).toString());

if (!config.service) {
  config.service = {};
}

if (!config.service.pipelines) {
  config.service.pipelines = {};
}

if (!config.service.pipelines.traces) {
  config.service.pipelines.traces = {};
}

if (!config.service.pipelines.traces.processors) {
  config.service.pipelines.traces.processors = [];
}

if (!config.service.pipelines.traces.processors.includes("transform")) {
  config.service.pipelines.traces.processors.push("transform");
}

const redactionTraceStatement = {
  context: "span",
  statements: [
    `replace_all_patterns(attributes, "value", "\\\\b(${paramGroup})=(?:[^&])+", "$$1=[redacted]")`,
  ],
};

if (!config.processors.transform) {
  config.processors.transform = {};
}

if (!config.processors.transform.error_mode) {
  config.processors.transform.error_mode = "ignore";
}

if (!config.processors.transform.trace_statements) {
  config.processors.transform.trace_statements = [];
}

config.processors.transform.trace_statements.push(redactionTraceStatement);

await writeFile(configPath, config);
