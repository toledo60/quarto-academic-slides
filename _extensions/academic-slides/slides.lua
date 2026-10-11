if not FORMAT:match('typst') then return {} end

local function raw(s) return pandoc.RawBlock('typst', s) end
local function inline_typst(xs)
  return pandoc.write(pandoc.Pandoc({pandoc.Plain(xs)}), 'typst'):gsub('%s+$', '')
end
local function has(el, cls)
  for _, c in ipairs(el.classes) do if c == cls then return true end end
  return false
end
function Span(el)
  for _, cls in ipairs({'al', 'alg', 'alr', 'alb'}) do
    if has(el, cls) then return pandoc.RawInline('typst', '#' .. cls .. '[' .. inline_typst(el.content) .. ']') end
  end
end
function Div(el)
  if has(el, 'last-slide') then return raw('#lastslide()') end
  for _, cls in ipairs({'theorem', 'proposition', 'assumption', 'remark', 'block'}) do
    if has(el, cls) then
      local title = el.attributes.title or (cls:sub(1,1):upper() .. cls:sub(2))
      local out = {raw('#theme-block(title: [' .. inline_typst({pandoc.Str(title)}) .. '])[')}
      for _, b in ipairs(el.content) do table.insert(out, b) end
      table.insert(out, raw(']'))
      return out
    end
  end
end
function Pandoc(doc)
  local out, opened = {}, false
  for _, b in ipairs(doc.blocks) do
    if (b.t == 'Header' and b.level <= 2) or (b.t == 'RawBlock' and b.text == '#lastslide()') then
      if opened then table.insert(out, raw(']')); opened = false end
      if b.t == 'RawBlock' then table.insert(out, b)
      elseif b.level == 1 then table.insert(out, raw('#section-slide([' .. inline_typst(b.content) .. '])'))
      else table.insert(out, raw('#slide(title: [' .. inline_typst(b.content) .. '])[')); opened = true end
    else table.insert(out, b) end
  end
  if opened then table.insert(out, raw(']')) end
  return pandoc.Pandoc(out, doc.meta)
end
