# require! <[
#   crypto
#   path
# ]>
# require! {
#   \js-yaml : yaml
#   \fs-extra : fs
# }

_PATH = {}

module.exports = {
  end : (dir)!~>
    console.log _PATH

  file : (path)!~>
    pos = path.indexOf("/")
    key = path.slice(0, pos)
    li = _PATH[key]
    if not li
      li = _PATH[key] = []
    li.push path.slice(pos+1, -key.length-1)
}
