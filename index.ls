require! <[
  path
  terser
]>
require! {
  \fs-extra : fs
}

_PATH = {}

# pug : ':f(about)'
# md : ':f(join|vision|readme|0day|2019-image|quote/declaration-of-digital-independence|help)'

module.exports = {
  end : (dir)!~>
    jspath = path.join(dir, \6.js)
    js = await fs.readFile jspath,'utf-8'
    n = 1
    begin = js.indexOf('C={')+2
    for i,pos in js.slice(begin+1)
      if i == "{"
        ++n
      else if i == "}"
        --n
      if not n
        end = pos
        break
    end = end+begin+2
    prev = js.slice(0, begin)
    mid = eval '('+js.slice(begin, end)+')'
    mid.url = mid.url or {}
    after = js.slice(end)

    for k,li of _PATH
      li.sort (a,b)~>
        a.length - b.length
      mid.url[k] = li.join('|')
    await fs.writeFile jspath, terser.minify(prev+JSON.stringify(mid)).code.slice(0,-1)+after

  file : (path)!~>
    pos = path.indexOf("/")
    key = path.slice(0, pos)
    li = _PATH[key]
    if not li
      li = _PATH[key] = []
    li.push path.slice(pos+1, -key.length-1)
}
