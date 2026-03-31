export function toString(bytes) {
	const decoder = new TextDecoder("utf-8", { fatal: true });

	return decoder.decode(bytes);
}
