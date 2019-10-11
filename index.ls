# require! <[
#   crypto
#   path
# ]>
# require! {
#   \js-yaml : yaml
#   \fs-extra : fs
# }



module.exports = {
  end : (dir)!~>

  file : (buf)~>
    console.log buf.path
    return buf
}
