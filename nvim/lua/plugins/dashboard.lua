return {
    {
        "goolord/alpha-nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- ロゴの各行の頭に半角スペースを4つ自動で足す
            local logo = {
                "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            }
            for k, v in ipairs(logo) do
                logo[k] = "    " .. v .. "    "
            end
            dashboard.section.header.val = logo
            dashboard.section.header.opts.hl = "Keyword"

            local function get_recent_files()
                local buttons = {}
                local oldfiles = vim.v.oldfiles
                local count = 0
                for _, file in ipairs(oldfiles) do
                    if count >= 5 then break end
                    if vim.fn.filereadable(file) == 1 then
                        local filename = vim.fn.fnamemodify(file, ":t")
                        local icon, _ = require("nvim-web-devicons").get_icon(file, vim.fn.fnamemodify(file, ":e"), { default = true })
                        local b = dashboard.button(tostring(count + 1), icon .. "  " .. filename, ":e " .. file .. "<CR>")
                        table.insert(buttons, b)
                        count = count + 1
                    end
                end
                if count == 0 then
                    table.insert(buttons, dashboard.button("n", "󰈚  No recent files", ""))
                end
                return buttons
            end

            dashboard.section.buttons.val = get_recent_files()

            local function get_metrics()
                local handle = io.popen("top -l 1 -n 0 | grep 'CPU usage' | awk '{print $3}'")
                local result = handle:read("*a")
                handle:close()
                local cpu = result:gsub("[%s\n\r]+", "")
                return "System Ready | CPU: " .. (cpu ~= "" and cpu or "0.00%")
            end

            dashboard.section.footer.val = get_metrics()
            dashboard.section.footer.opts.hl = "Comment"

            alpha.setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    local row = #dashboard.section.header.val + 2
                    pcall(vim.api.nvim_win_set_cursor, 0, { row, 0 })
                end,
            })
        end,
    },
}
