local status, pears = pcall(require, "pears")
if not status then
  return
end

pears.setup(
  function(conf)
    conf.pair("{", {
      filetypes = {"c", "javascript"}
    })
  end
)
