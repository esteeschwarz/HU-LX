-- local store_root = './STORE-repo/img'  -- relative to workspace root where render.R runs
-- local store_root = '/Users/guhl/Documents/GitHub/school/api/png/ses-overview'  -- relative to workspace root where render.R runs

-- function Image(img)
--   if not img.src:match('^https?://') then return nil end
--   local store_path = img.src:gsub('https?://[^/]+/', '')
--   img.src = store_root .. '/' .. store_path
--   return img
-- end


-------------------
-- direct-store.lua
local store_root

-- Detect environment and set path accordingly
local gh_runner = os.getenv("GITHUB_ACTIONS") == "true"
if gh_runner then
  -- GitHub Actions runner
  store_root = '../../..'
else
  -- Local desktop (adjust path to your local STORE-repo)
  -- store_root = '/Users/yourusername/repos/STORE-repo/img'  -- macOS example
  store_root = '../../..'  -- relative to workspace root where render.R runs

  -- or: store_root = '/home/yourusername/STORE-repo/img'   -- Linux
end

function Image(img)
  if not img.src:match('^https?://') then return nil end
  
  local store_path = img.src:gsub('https?://[^/]+/', '')
  img.src = store_root .. '/' .. store_path
  return img
end
