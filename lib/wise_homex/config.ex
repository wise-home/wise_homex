defmodule WiseHomex.Config do
  @moduledoc """
  The configuration object used for requests. It contains information
  which is used to perform requests, e.g. authorization headers,
  api_version, base url and http timeouts.
  """

  @type t :: %__MODULE__{
          authorization_header: String.t(),
          api_version: String.t(),
          timeout: pos_integer(),
          base_url: String.t()
        }

  defstruct authorization_header: nil,
            api_version: "v6",
            timeout: 5000,
            base_url: "https://api.wisehome.dk"

  @doc """
  Return a WiseHomex.Config from an authentication method.

  :plain uses authentication with email and password
  :api_key uses authentication using an api key
  :auth_header sets the value of the authentication header directly

  iex> new_config(:plain, {"some_user", "some_pass"})
  %WiseHomex.Config{
              api_version: "v6",
              authorization_header: "Basic c29tZV91c2VyOnNvbWVfcGFzcw==",
              base_url: "https://api.wisehome.dk",
              timeout: 5000
            }

  iex> new_config(:api_key, "12341234")
  %WiseHomex.Config{
              api_version: "v6",
              authorization_header: "Basic OjEyMzQxMjM0",
              base_url: "https://api.wisehome.dk",
              timeout: 5000
            }

  iex> new_config(:auth_header, "authheader")
  %WiseHomex.Config{
              api_version: "v6",
              authorization_header: "authheader",
              base_url: "https://api.wisehome.dk",
              timeout: 5000
            }

  iex> new_config(:auth_header, "authheader", api_version: "v1", base_url: "https://test.wisehome.dk", timeout: 60_000)
  %WiseHomex.Config{
              api_version: "v1",
              authorization_header: "authheader",
              base_url: "https://test.wisehome.dk",
              timeout: 60_000
            }

  """
  def new_config(term, credentials, opts \\ [])

  def new_config(:plain, {email, password}, opts) when is_binary(email) and is_binary(password) do
    auth_header = "Basic " <> Base.encode64("#{email}:#{password}")
    new_config(:auth_header, auth_header, opts)
  end

  def new_config(:api_key, api_key, opts) when is_binary(api_key) do
    auth_header = "Basic " <> Base.encode64(":" <> api_key)
    new_config(:auth_header, auth_header, opts)
  end

  def new_config(:auth_header, auth_header, opts) when is_binary(auth_header) do
    default_configuration = %__MODULE__{authorization_header: auth_header}

    opts
    |> Enum.reduce(default_configuration, fn {key, value}, config ->
      Map.update!(config, key, fn _ -> value end)
    end)
  end
end
