AS201, AS204, AS205, AS206
https://ada-sub.dh-index.org/school/api/png/ses-overview/exm_2_1.png

name: Build Pages
on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout main book repo (HU-LX)
      uses: actions/checkout@v4
      # default: path = ./HU-LX/ but we clean it up below

    - name: Checkout STORE-repo alongside
      uses: actions/checkout@v4
      with:
        repository: yourusername/STORE-repo  # same owner, different repo
        path: STORE-repo                    # at workspace root

    - name: Move book into workspace root
      run: |
        mv HU-LX/* .      # book files now at workspace root
        mv HU-LX/.* . 2>/dev/null || true  # dotfiles
        rmdir HU-LX

    - name: Setup R
      uses: r-lib/actions/setup-r@v2

    - name: Install dependencies  
      uses: r-lib/actions/setup-renv@v2

    - name: Render everything
      run: Rscript render.R  # your existing script, unchanged


direct-store.lua
local store_root = './STORE-repo/img'  -- relative to workspace root where render.R runs

function Image(img)
  if not img.src:match('^https?://') then return nil end
  local store_path = img.src:gsub('https?://[^/]+/', '')
  img.src = store_root .. '/' .. store_path
  return img
end

_pdf.yml
bookdown::pdf_book:
  pandoc_args: ["--lua-filter=direct-store.lua"]
