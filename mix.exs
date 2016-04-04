defmodule ExrmDocker.Mixfile do
  use Mix.Project

  def project do
    [app: :exrm_docker,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    [{:exrm, "~> 1.0.0"},
     {:dialyxir, "~> 0.3", only: [:dev]}]
  end


  defp description do
    """
    Exrm plugin to push your release into a Docker image.
    """
  end

  defp package do
    [files: ["lib", "mix.exs", "README.md", "LICENSE"],
     maintainers: ["Kevin W. van Rooijen"],
     licenses: ["GPL3"],
     links: %{"GitHub": "https://github.com/kwrooijen/exrm_docker"}]
  end
end
