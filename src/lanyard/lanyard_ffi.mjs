import { BitArray$BitArray } from "../gleam.mjs";

export function randomBytes(size) {
	const bytes = new Uint8Array(size);
	globalThis.crypto.getRandomValues(bytes);

	return BitArray$BitArray(bytes);
}

export function bitwiseAnd(left, right) {
	return left & right;
}
