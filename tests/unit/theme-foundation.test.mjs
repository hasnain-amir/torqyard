import assert from "node:assert/strict";
import { readFileSync, existsSync } from "node:fs";
import { test } from "node:test";

const root = new URL("../../packages/nodebb-theme-torqyard/", import.meta.url);

function readJson(filename) {
  return JSON.parse(readFileSync(new URL(filename, root), "utf8"));
}

test("theme package declares supported NodeBB compatibility", () => {
  const pkg = readJson("package.json");

  assert.equal(pkg.name, "nodebb-theme-torqyard");
  assert.equal(pkg.version, "0.1.0");
  assert.equal(pkg.private, true);
  assert.equal(pkg.nbbpm.compatibility, "^4.16.0");
  assert.equal(pkg.peerDependencies["nodebb-theme-harmony"], "3.3.9");
});

test("theme inherits Harmony templates", () => {
  const pkg = readJson("package.json");
  const theme = readJson("theme.json");

  assert.equal(theme.id, pkg.name);
  assert.equal(theme.baseTheme, "nodebb-theme-harmony");

  assert.ok(
    existsSync(new URL("templates/", root)),
    "A theme templates directory is required",
  );
});

test("plugin metadata identifies the theme", () => {
  const pkg = readJson("package.json");
  const plugin = readJson("plugin.json");

  assert.equal(plugin.id, pkg.name);
  assert.equal(plugin.hooks.length, 8);

  for (const hook of plugin.hooks) {
    assert.equal(typeof hook.hook, "string");
    assert.equal(typeof hook.method, "string");
  }
});

test("stylesheet imports Harmony and Carbon Amber tokens", () => {
  const stylesheet = readFileSync(new URL("theme.scss", root), "utf8");

  assert.match(
    stylesheet,
    /@import\s+["']nodebb-theme-harmony\/scss\/harmony["']/,
  );

  assert.match(stylesheet, /@import\s+["']\.\/scss\/tokens["']/);
});

test("Carbon Amber defines core semantic colours", () => {
  const tokens = readFileSync(new URL("scss/_tokens.scss", root), "utf8");

  for (const token of [
    "--ty-carbon-950",
    "--ty-amber-500",
    "--ty-text-primary",
    "--ty-surface-page",
    "--ty-action-primary",
  ]) {
    assert.ok(tokens.includes(token), `Missing ${token}`);
  }
});

test("theme maps Harmony fonts to TorqYard assets", () => {
  const stylesheet = readFileSync(new URL("theme.scss", root), "utf8");

  const plugin = readJson("plugin.json");

  assert.match(
    stylesheet,
    /\$font-path:\s*["']\.\/plugins\/nodebb-theme-torqyard["']/,
  );

  assert.ok(plugin.staticDirs.inter);
  assert.ok(plugin.staticDirs.poppins);
});
