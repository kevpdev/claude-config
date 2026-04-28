#!/usr/bin/env node

import { appendFile, mkdir } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import type { HookInput, HookOutput } from "./lib/types.ts";
import { CommandValidator } from "./lib/validator.ts";

const __dirname = dirname(fileURLToPath(import.meta.url));
const LOG_FILE = join(__dirname, "../data/security.log");

async function logSecurityEvent(
	command: string,
	toolName: string,
	result: { isValid: boolean; severity: string; violations: string[] },
	sessionId: string | null,
) {
	const timestamp = new Date().toISOString();
	const logEntry = {
		timestamp,
		sessionId,
		toolName,
		command: command.substring(0, 500),
		blocked: !result.isValid,
		severity: result.severity,
		violations: result.violations,
		source: "claude-code-hook",
	};

	try {
		const logLine = `${JSON.stringify(logEntry)}\n`;
		await mkdir(dirname(LOG_FILE), { recursive: true });
		await appendFile(LOG_FILE, logLine, "utf8");

		console.error(
			`[SECURITY] ${result.isValid ? "ALLOWED" : "BLOCKED"}: ${command.substring(0, 100)}`,
		);
	} catch (error) {
		console.error("Failed to write security log:", error);
	}
}

async function main() {
	const validator = new CommandValidator();

	try {
		const stdin = process.stdin;
		const chunks: Buffer[] = [];

		for await (const chunk of stdin) {
			chunks.push(chunk);
		}

		const input = Buffer.concat(chunks).toString();

		if (!input.trim()) {
			console.error("No input received from stdin");
			process.exit(1);
		}

		let hookData: HookInput;
		try {
			hookData = JSON.parse(input) as HookInput;
		} catch (error) {
			console.error("Invalid JSON input:", (error as Error).message);
			process.exit(1);
			return;
		}

		const toolName = hookData.tool_name ?? "Unknown";
		const toolInput = hookData.tool_input ?? {};
		const sessionId = hookData.session_id ?? null;

		if (toolName !== "Bash") {
			console.log(`Skipping validation for tool: ${toolName}`);
			process.exit(0);
		}

		const command = toolInput.command;
		if (!command) {
			console.error("No command found in tool input");
			process.exit(1);
		}

		const result = validator.validate(command as string, toolName);

		await logSecurityEvent(command, toolName, result, sessionId);

		if (result.isValid) {
			console.log("Command validation passed");
			process.exit(0);
		}

		const confirmationMessage = `⚠️  Potentially dangerous command detected!\n\nCommand: ${command}\nViolations: ${result.violations.join(", ")}\nSeverity: ${result.severity}\n\nDo you want to proceed with this command?`;

		const hookOutput: HookOutput = {
			hookSpecificOutput: {
				hookEventName: "PreToolUse",
				permissionDecision: "ask",
				permissionDecisionReason: confirmationMessage,
			},
		};

		console.log(JSON.stringify(hookOutput));
		process.exit(0);
	} catch (error) {
		console.error("Validation script error:", error);
		process.exit(2);
	}
}

main().catch((error) => {
	console.error("Fatal error:", error);
	process.exit(2);
});
