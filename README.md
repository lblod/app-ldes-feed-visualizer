# app-ldes-feed-visualizer

This tool allows you to consume a given [LDES endpoint](https://interoperable-europe.ec.europa.eu/collection/semic-support-centre/linked-data-event-streams-ldes) and visualize the consumed data through a [SPARQL endpoint](https://en.wikipedia.org/wiki/SPARQL) and [ember-metis](https://github.com/redpencilio/ember-metis).

## How to

```
docker compose up -d # change the environment variables of the consumer stack if necessary
```

You primarily want to override the `LDES_ENDPOINT_VIEW` environment variable in the consumer stack; the rest can probably remain at their default values.

