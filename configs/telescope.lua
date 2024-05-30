return {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob", -- this flag allows you to hide exclude these files and folders from your search 👇
      "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,**/build/*,**/.DS_Store}",
    },
  },
  pickers = {
    file_ignore_patterns = {
      "node_modules",
      ".git",
    },
    find_files = {
      hidden = true,
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--no-ignore-vcs",
        "-g",
        "!**/.git/*",
        "-g",
        "!**/node_modules/*",
        "-g",
        "!**/.repro/*", -- just to hide .repro rtp
        "-g",
        "!**/build/*",
        "-g",
        "!**/.DS_Store",
      },
    },
  },
}
