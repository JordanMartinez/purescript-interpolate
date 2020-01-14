"use strict";

exports.unsafeCrashWith = function(msg) {
  throw new Error(msg);
}
