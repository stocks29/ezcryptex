defmodule Ezcryptex.Mixfile do
  use Mix.Project

  def project do
    [app: :ezcryptex,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :cryptex]]
  end

  def description do
    """
    Thin layer on top of Cryptex for more easily encrypting/decrypting, signing/verifying data in elixir.
    """ 
  end

  def package do
    [
      contributors: ["Bob Stockdale"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/stocks29/ezcryptex"}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:cryptex, git: "https://github.com/scrogson/cryptex.git", branch: "master"}
    ]
  end
end
