local M = {}

function M.gofmt()
	return {
		exe = "gofmt",
		stdin = true,
	}
end

function M.goimports()
	return {
		exe = "~/go/bin/goimports",
		stdin = true,
	}
end

function M.gofumpt()
	return {
		exe = "gofumpt",
		stdin = true,
	}
end

function M.gofumports()
	return {
		exe = "gofumports",
		stdin = true,
	}
end

return M
