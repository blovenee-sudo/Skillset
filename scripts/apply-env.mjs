#!/usr/bin/env node
/**
 * .env → env-config.js (브라우저에서 window.__UX_SKILLSET_ENV__ 로 노출)
 * 사용: skillset 폴더에서 `node scripts/apply-env.mjs`
 * 주의: env-config.js 는 비밀값이 들어갈 수 있으므로 Git에 올리지 않는다.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, "..");
const envPath = path.join(root, ".env");
const outPath = path.join(root, "env-config.js");

function parseEnv(text) {
  const out = {};
  for (const line of text.split("\n")) {
    const raw = line.trim();
    if (!raw || raw.startsWith("#")) continue;
    const eq = raw.indexOf("=");
    if (eq === -1) continue;
    const key = raw.slice(0, eq).trim();
    let val = raw.slice(eq + 1).trim();
    if (
      (val.startsWith('"') && val.endsWith('"')) ||
      (val.startsWith("'") && val.endsWith("'"))
    ) {
      val = val.slice(1, -1);
    }
    out[key] = val;
  }
  return out;
}

let env = {};
if (fs.existsSync(envPath)) {
  env = parseEnv(fs.readFileSync(envPath, "utf8"));
} else {
  console.warn("[apply-env] .env 없음 → 빈 env-config.js 생성 (.env.example 복사해 .env 로 저장)");
}

const json = JSON.stringify(env, null, 2);
const body =
  `/* 자동 생성: node scripts/apply-env.mjs (.env 읽음). 비밀 포함 시 Git 커밋 금지 */\n` +
  `window.__UX_SKILLSET_ENV__ = ${json};\n`;
fs.writeFileSync(outPath, body, "utf8");
console.log("[apply-env] 작성:", outPath, "키 개수:", Object.keys(env).length);
