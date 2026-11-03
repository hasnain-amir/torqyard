"use strict";

const harmony = require("nodebb-theme-harmony");

const methods = [
  "init",
  "addAdminNavigation",
  "defineWidgetAreas",
  "getThemeConfig",
  "getAdminSettings",
  "saveUserSettings",
  "addProfileItem",
  "filterMiddlewareRenderHeader",
];

for (const method of methods) {
  if (typeof harmony[method] !== "function") {
    throw new TypeError(`Harmony is missing the required method: ${method}`);
  }

  exports[method] = (...args) => harmony[method](...args);
}
