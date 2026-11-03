"use strict";

const path = require("node:path");

async function main() {
  const nodebbRoot = process.cwd();

  const fs = require("node:fs");

  const marker = path.join(nodebbRoot, ".torqyard-theme-test");

  if (!fs.existsSync(marker)) {
    throw new Error(
      "Theme activation is restricted to a disposable test installation.",
    );
  }

  const nconf = require(path.join(nodebbRoot, "node_modules/nconf"));

  const database = require(path.join(nodebbRoot, "src/database"));

  const meta = require(path.join(nodebbRoot, "src/meta"));

  const themes = require(path.join(nodebbRoot, "src/meta/themes"));

  const config = require(path.join(nodebbRoot, "config.json"));

  nconf.file({
    file: path.join(nodebbRoot, "config.json"),
  });

  nconf.set("base_dir", nodebbRoot);
  nconf.set("themes_path", path.join(nodebbRoot, "node_modules"));
  nconf.set("version", require(path.join(nodebbRoot, "package.json")).version);

  await database.init();

  try {
    await meta.configs.init();

    await themes.set({
      type: "local",
      id: "nodebb-theme-torqyard",
      uid: 1,
      ip: "127.0.0.1",
    });

    const selectedTheme = await meta.configs.get("theme:id");

    const activePlugins = await database.getSortedSetRange(
      "plugins:active",
      0,
      -1,
    );

    console.log("Selected theme:", selectedTheme);
    console.log("Active plugins:", activePlugins);

    if (selectedTheme !== "nodebb-theme-torqyard") {
      throw new Error(
        `Theme selection failed: expected TorqYard, got ${selectedTheme}`,
      );
    }

    if (!activePlugins.includes("nodebb-theme-torqyard")) {
      throw new Error("TorqYard is not registered as an active plugin.");
    }

    if (activePlugins.includes("nodebb-theme-harmony")) {
      throw new Error("Harmony remains active alongside TorqYard.");
    }

    console.log("TorqYard theme selection verified.");
  } finally {
    await database.close();
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
