defmodule StellarBase.XDR.Operations.CreateAccountResultCode do
  @moduledoc """
  Representation of Stellar `CreateAccountResultCode` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    # account was created
    CREATE_ACCOUNT_SUCCESS: 0,
    # invalid destination
    CREATE_ACCOUNT_MALFORMED: -1,
    # not enough funds in source account
    CREATE_ACCOUNT_UNDERFUNDED: -2,
    # would create an account below the min reserve
    CREATE_ACCOUNT_LOW_RESERVE: -3,
    # account already exists
    CREATE_ACCOUNT_ALREADY_EXIST: -4
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(code :: atom()) :: t()
  def new(code), do: %__MODULE__{identifier: code}

  @impl true
  def encode_xdr(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: code}) do
    @declarations
    |> XDR.Enum.new(code)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: code}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(code), rest}
  end
end
