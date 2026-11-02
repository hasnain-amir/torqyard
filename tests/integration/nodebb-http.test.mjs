import assert from "node:assert/strict";
import { test } from "node:test";

const rawUrl = process.env.NODEBB_SMOKE_URL;

if (!rawUrl) {
  throw new Error("NODEBB_SMOKE_URL must be provided");
}

const baseUrl = new URL(rawUrl);

if (
  baseUrl.protocol !== "http:" ||
  !["127.0.0.1", "localhost"].includes(baseUrl.hostname) ||
  !baseUrl.port ||
  ["4567", "4568"].includes(baseUrl.port) ||
  baseUrl.pathname !== "/" ||
  baseUrl.search ||
  baseUrl.hash ||
  baseUrl.username ||
  baseUrl.password
) {
  throw new Error(
    "NODEBB_SMOKE_URL must target an isolated local HTTP instance",
  );
}

async function get(path) {
  const url = new URL(path, baseUrl);

  const response = await fetch(url, {
    redirect: "manual",
    signal: AbortSignal.timeout(10_000),
  });

  return response;
}

test("NodeBB serves the public homepage", async () => {
  const response = await get("/");

  assert.equal(response.status, 200);

  const contentType = response.headers.get("content-type") ?? "";

  assert.match(contentType, /text\/html/i);

  const body = await response.text();

  assert.match(body, /<html[\s>]/i);
  assert.match(body, /<\/html>/i);
});

test("NodeBB exposes its public configuration endpoint", async () => {
  const response = await get("/api/config");

  assert.equal(response.status, 200);

  const contentType = response.headers.get("content-type") ?? "";

  assert.match(contentType, /application\/json/i);

  const config = await response.json();

  assert.equal(typeof config, "object");
  assert.notEqual(config, null);
  assert.equal(Array.isArray(config), false);
});
