require "pears".setup(
  function(conf)
    conf.pair("{", {
      filetypes = {"c", "javascript"}
    })
  end
)
