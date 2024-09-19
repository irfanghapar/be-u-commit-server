defmodule Mix.Tasks.ImportData do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")
    Cerberus.Workers.DataImport.import_data()
  end
end
