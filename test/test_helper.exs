ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Cerberus.Repo, :manual)

Cerberus.Workers.DataImport.import_data()
